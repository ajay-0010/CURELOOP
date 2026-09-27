from abc import ABC, abstractmethod


class OTPProvider(ABC):
    @abstractmethod
    async def send_otp(self, phone_number: str) -> str:
        pass

    @abstractmethod
    async def verify_otp(self, phone_number: str, otp: str) -> bool:
        pass


class MockOTPProvider(OTPProvider):
    # In a real system, this would be an interface to Twilio/AWS SNS etc.
    # We store mock OTPs in memory for development phase.
    import typing
    _store: typing.ClassVar[dict] = {}

    async def send_otp(self, phone_number: str) -> str:
        # Generate a fixed OTP for dev, or a random one.
        # We will use '123456' for all numbers in development.
        mock_otp = "123456"
        self._store[phone_number] = mock_otp
        # print(f"MOCK OTP sent to {phone_number}: {mock_otp}")
        return mock_otp

    async def verify_otp(self, phone_number: str, otp: str) -> bool:
        if phone_number in self._store and self._store[phone_number] == otp:
            del self._store[phone_number]
            return True
        # For ease of testing allow 123456 always
        return otp == "123456"


otp_provider = MockOTPProvider()
