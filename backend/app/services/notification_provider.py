import logging
from abc import ABC, abstractmethod

logger = logging.getLogger(__name__)


class NotificationProvider(ABC):
    @abstractmethod
    async def schedule_notification(
        self, patient_id: str, title: str, body: str, scheduled_at_utc: str
    ):
        pass

    @abstractmethod
    async def cancel_notification(self, patient_id: str, notification_id: str):
        pass


class MockNotificationProvider(NotificationProvider):
    def __init__(self):
        self.scheduled_notifications = []

    async def schedule_notification(
        self, patient_id: str, title: str, body: str, scheduled_at_utc: str
    ):
        # In a real app, this would queue a background task or register with Firebase
        notif = {
            "patient_id": str(patient_id),
            "title": title,
            "body": body,
            "scheduled_at_utc": scheduled_at_utc,
        }
        self.scheduled_notifications.append(notif)
        logger.info(f"Mock Notification Scheduled: {notif}")
        return f"mock_id_{len(self.scheduled_notifications)}"

    async def cancel_notification(self, patient_id: str, notification_id: str):
        logger.info(f"Mock Notification Cancelled: {notification_id}")


# Switch based on environment
notification_provider = MockNotificationProvider()
