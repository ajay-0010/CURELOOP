import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_request_otp(client: AsyncClient):
    response = await client.post(
        "/api/v1/auth/request-otp", json={"phone_number": "+1234567890"}
    )
    assert response.status_code == 200
    assert response.json() == {"message": "OTP sent successfully"}


@pytest.mark.asyncio
async def test_verify_otp(client: AsyncClient):
    # Mock OTP allows 123456 for any number
    response = await client.post(
        "/api/v1/auth/verify-otp", json={"phone_number": "+1234567890", "otp": "123456"}
    )
    assert response.status_code == 200
    data = response.json()
    assert "access_token" in data
    assert "refresh_token" in data
    assert data["token_type"] == "bearer"


@pytest.mark.asyncio
async def test_verify_otp_invalid(client: AsyncClient):
    response = await client.post(
        "/api/v1/auth/verify-otp", json={"phone_number": "+1234567890", "otp": "000000"}
    )
    assert response.status_code == 400
    assert response.json()["detail"] == "Invalid OTP"
