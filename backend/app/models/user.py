from sqlalchemy import Column, String, Boolean, Enum
from sqlalchemy import Uuid as UUID
from app.db.base_class import Base
import uuid
import enum


class UserRole(str, enum.Enum):
    PATIENT = "patient"
    ADMIN = "admin"


class User(Base):
    __tablename__ = "users"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    phone_number = Column(String, unique=True, index=True, nullable=False)
    role = Column(Enum(UserRole), default=UserRole.PATIENT)
    is_active = Column(Boolean, default=True)
