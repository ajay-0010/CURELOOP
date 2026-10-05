from fastapi import APIRouter, Depends, HTTPException, status, Request
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select

from app.core.security import create_access_token, create_refresh_token, verify_refresh_token
from app.core.config import settings
from app.db.database import get_db
from app.models.user import User
from app.schemas.user import OTPRequest, OTPVerify, Token
from app.services.otp_service import otp_provider
from app.services.rate_limiter import RateLimiter

router = APIRouter(prefix="/auth", tags=["auth"])

otp_rate_limiter = RateLimiter(settings.OTP_MAX_REQUESTS, settings.OTP_RATE_LIMIT_MINUTES)
verify_rate_limiter = RateLimiter(settings.OTP_MAX_REQUESTS * 2, settings.OTP_RATE_LIMIT_MINUTES)

@router.post("/request-otp", status_code=status.HTTP_200_OK)
async def request_otp(request: OTPRequest, req: Request):
    client_ip = req.client.host if req.client else "unknown"
    key = f"{client_ip}:{request.phone_number}"
    if not otp_rate_limiter.is_allowed(key):
        raise HTTPException(status_code=429, detail="Too many OTP requests. Please try again later.")

    await otp_provider.send_otp(request.phone_number)
    return {"message": "OTP sent successfully"}


@router.post("/verify-otp", response_model=Token)
async def verify_otp(request: OTPVerify, req: Request, db: AsyncSession = Depends(get_db)):
    client_ip = req.client.host if req.client else "unknown"
    key = f"{client_ip}:{request.phone_number}"
    
    if not verify_rate_limiter.is_allowed(key):
        raise HTTPException(status_code=429, detail="Too many verification attempts.")

    is_valid = await otp_provider.verify_otp(request.phone_number, request.otp)
    if not is_valid:
        raise HTTPException(status_code=400, detail="Invalid OTP")

    otp_rate_limiter.clear(key)
    verify_rate_limiter.clear(key)

    stmt = select(User).where(User.phone_number == request.phone_number)
    result = await db.execute(stmt)
    user = result.scalar_one_or_none()

    if not user:
        user = User(phone_number=request.phone_number)
        db.add(user)
        await db.commit()
        await db.refresh(user)

    if not user.is_active:
        raise HTTPException(status_code=403, detail="Inactive user")

    access_token = create_access_token(subject=str(user.id))
    refresh_token = create_refresh_token(subject=str(user.id))

    return {
        "access_token": access_token,
        "refresh_token": refresh_token,
        "token_type": "bearer",
    }


from pydantic import BaseModel
class RefreshRequest(BaseModel):
    refresh_token: str

@router.post("/refresh", response_model=Token)
async def refresh_token_endpoint(request: RefreshRequest, db: AsyncSession = Depends(get_db)):
    user_id_str = verify_refresh_token(request.refresh_token)
    if not user_id_str:
        raise HTTPException(status_code=401, detail="Invalid or expired refresh token")
    import uuid
    try:
        user_id = uuid.UUID(user_id_str)
    except ValueError:
        raise HTTPException(status_code=401, detail="Invalid token format")

    stmt = select(User).where(User.id == user_id)
    result = await db.execute(stmt)
    user = result.scalar_one_or_none()
    
    if not user or not user.is_active:
        raise HTTPException(status_code=403, detail="Inactive user")

    access_token = create_access_token(subject=str(user.id))
    # Rotate refresh token
    new_refresh_token = create_refresh_token(subject=str(user.id))

    return {
        "access_token": access_token,
        "refresh_token": new_refresh_token,
        "token_type": "bearer",
    }


