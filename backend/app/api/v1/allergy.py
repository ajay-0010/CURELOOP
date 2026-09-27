from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from typing import List
from uuid import UUID

from app.db.database import get_db
from app.models.user import User
from app.models.patient import PatientProfile
from app.models.allergy import Allergy
from app.schemas.allergy import AllergyCreate, AllergyResponse
from app.core.security import get_current_user

router = APIRouter(prefix="/patient/allergies", tags=["allergy"])


async def get_patient_profile_or_404(
    current_user: User, db: AsyncSession
) -> PatientProfile:
    stmt = select(PatientProfile).where(PatientProfile.user_id == current_user.id)
    result = await db.execute(stmt)
    profile = result.scalar_one_or_none()
    if not profile:
        raise HTTPException(
            status_code=404, detail="Patient profile must be created first"
        )
    return profile


@router.get("", response_model=List[AllergyResponse])
async def get_allergies(
    current_user: User = Depends(get_current_user), db: AsyncSession = Depends(get_db)
):
    profile = await get_patient_profile_or_404(current_user, db)
    stmt = select(Allergy).where(Allergy.patient_id == profile.id)
    result = await db.execute(stmt)
    allergies = result.scalars().all()
    return allergies


@router.post("", response_model=AllergyResponse, status_code=status.HTTP_201_CREATED)
async def create_allergy(
    allergy_data: AllergyCreate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    profile = await get_patient_profile_or_404(current_user, db)
    allergy = Allergy(patient_id=profile.id, **allergy_data.model_dump())
    db.add(allergy)
    await db.commit()
    await db.refresh(allergy)
    return allergy


@router.delete("/{allergy_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_allergy(
    allergy_id: UUID,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    profile = await get_patient_profile_or_404(current_user, db)
    stmt = select(Allergy).where(
        Allergy.id == allergy_id, Allergy.patient_id == profile.id
    )
    result = await db.execute(stmt)
    allergy = result.scalar_one_or_none()

    if not allergy:
        raise HTTPException(status_code=404, detail="Allergy not found")

    await db.delete(allergy)
    await db.commit()
    return None
