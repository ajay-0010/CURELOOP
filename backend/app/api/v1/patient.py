from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select

from app.db.database import get_db
from app.models.user import User
from app.models.patient import PatientProfile
from app.schemas.patient import (
    PatientProfileCreate,
    PatientProfileUpdate,
    PatientProfileResponse,
)
from app.core.security import get_current_user

router = APIRouter(prefix="/patient", tags=["patient"])


@router.get("/me", response_model=PatientProfileResponse)
async def get_patient_profile(
    current_user: User = Depends(get_current_user), db: AsyncSession = Depends(get_db)
):
    stmt = select(PatientProfile).where(PatientProfile.user_id == current_user.id)
    result = await db.execute(stmt)
    profile = result.scalar_one_or_none()

    if not profile:
        raise HTTPException(status_code=404, detail="Patient profile not found")
    return profile


@router.put("/me", response_model=PatientProfileResponse)
async def update_patient_profile(
    profile_data: PatientProfileUpdate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    stmt = select(PatientProfile).where(PatientProfile.user_id == current_user.id)
    result = await db.execute(stmt)
    profile = result.scalar_one_or_none()

    if not profile:
        # Create it if it doesn't exist on PUT? The instructions say PUT.
        # Let's support both create on PUT if not exists, or update.
        profile = PatientProfile(
            user_id=current_user.id, **profile_data.model_dump(exclude_unset=True)
        )
        db.add(profile)
    else:
        for key, value in profile_data.model_dump(exclude_unset=True).items():
            setattr(profile, key, value)

    await db.commit()
    await db.refresh(profile)
    return profile


@router.delete("/me", status_code=status.HTTP_204_NO_CONTENT)
async def delete_account(
    current_user: User = Depends(get_current_user), db: AsyncSession = Depends(get_db)
):
    # This deletes the user and cascades to patient profile and allergies
    await db.delete(current_user)
    await db.commit()
    return None
