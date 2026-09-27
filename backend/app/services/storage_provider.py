import os
import uuid
from abc import ABC, abstractmethod

import aiofiles


class StorageProvider(ABC):
    @abstractmethod
    async def upload(
        self, file_content: bytes, filename: str, content_type: str
    ) -> str:
        """Uploads a file and returns the object key."""

    @abstractmethod
    async def delete(self, object_key: str) -> bool:
        """Deletes a file by object key."""

    @abstractmethod
    async def generate_secure_access_url(
        self, object_key: str, expires_in: int = 3600
    ) -> str:
        """Generates a secure, temporary URL for accessing the file."""


class LocalDevelopmentStorage(StorageProvider):
    """
    DEVELOPMENT ONLY.
    Stores files securely in a local directory that is NOT publicly exposed via FastAPI static files.
    Requires an authenticated proxy endpoint to serve files securely.
    """

    def __init__(self, base_dir: str = "./storage_dev"):
        self.base_dir = base_dir
        os.makedirs(self.base_dir, exist_ok=True)

    async def upload(
        self, file_content: bytes, filename: str, content_type: str
    ) -> str:
        # Generate safe UUID object key to prevent path traversal and collisions
        ext = os.path.splitext(filename)[1]
        object_key = f"{uuid.uuid4()}{ext}"

        file_path = os.path.join(self.base_dir, object_key)

        # In a real async environment, we should use aiofiles to avoid blocking
        async with aiofiles.open(file_path, "wb") as f:
            await f.write(file_content)

        return object_key

    async def delete(self, object_key: str) -> bool:
        # Prevent path traversal
        if ".." in object_key or "/" in object_key or "\\" in object_key:
            return False

        file_path = os.path.join(self.base_dir, object_key)
        if os.path.exists(file_path):
            os.remove(file_path)
            return True
        return False

    async def generate_secure_access_url(
        self, object_key: str, expires_in: int = 3600
    ) -> str:
        # For local dev, we will route this through an authenticated FastAPI endpoint
        # The URL itself isn't a pre-signed cloud URL, but an API path that enforces token auth.
        return f"/api/v1/prescriptions/documents/{object_key}"

    def get_local_path(self, object_key: str) -> str | None:
        if ".." in object_key or "/" in object_key or "\\" in object_key:
            return None
        path = os.path.join(self.base_dir, object_key)
        return path if os.path.exists(path) else None


# For Phase 4, we instantiate the local provider.
# In production, this would switch based on settings.py (e.g. settings.STORAGE_PROVIDER == 's3')
storage_provider = LocalDevelopmentStorage()
