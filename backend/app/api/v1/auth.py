from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select

from app.db.database import get_db
from app.models.user import User
from app.schemas.user import OTPRequest, OTPVerify, Token, UserResponse
from app.services.otp_service import otp_provider
from app.core.security import create_access_token, create_refresh_token

router = APIRouter(prefix="/auth", tags=["auth"])


@router.post("/request-otp", status_code=status.HTTP_200_OK)
async def request_otp(request: OTPRequest):
    # In Phase 1, we send mock OTP via service
    otp = await otp_provider.send_otp(request.phone_number)
    # Don't return OTP in prod! Just for MVP ease if needed, but we keep it secure-ish by just returning success.
    return {"message": "OTP sent successfully"}


@router.post("/verify-otp", response_model=Token)
async def verify_otp(request: OTPVerify, db: AsyncSession = Depends(get_db)):
    is_valid = await otp_provider.verify_otp(request.phone_number, request.otp)
    if not is_valid:
        raise HTTPException(status_code=400, detail="Invalid OTP")

    stmt = select(User).where(User.phone_number == request.phone_number)
    result = await db.execute(stmt)
    user = result.scalar_one_or_none()

    if not user:
        user = User(phone_number=request.phone_number)
        db.add(user)
        await db.commit()
        await db.refresh(user)

    if not user.is_active:
        raise HTTPException(status_code=400, detail="Inactive user")

    access_token = create_access_token(subject=str(user.id))
    refresh_token = create_refresh_token(subject=str(user.id))

    return {
        "access_token": access_token,
        "refresh_token": refresh_token,
        "token_type": "bearer",
    }
