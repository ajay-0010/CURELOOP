from uuid import UUID

from pydantic import BaseModel, ConfigDict

from app.models.user import UserRole


class OTPRequest(BaseModel):
    phone_number: str


class OTPVerify(BaseModel):
    phone_number: str
    otp: str


class Token(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"


class UserBase(BaseModel):
    phone_number: str
    role: UserRole = UserRole.PATIENT


class UserResponse(UserBase):
    id: UUID
    is_active: bool
    model_config = ConfigDict(from_attributes=True)
