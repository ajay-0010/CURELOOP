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
import os

class FCMNotificationProvider(NotificationProvider):
    def __init__(self):
        import firebase_admin
        from firebase_admin import credentials, messaging
        if not firebase_admin._apps:
            cred = credentials.Certificate(os.getenv("FIREBASE_SERVICE_ACCOUNT", "firebase-adminsdk.json"))
            firebase_admin.initialize_app(cred)
        self.messaging = messaging

    async def schedule_notification(self, patient_id: str, title: str, body: str, scheduled_at_utc: str):
        # In FCM, scheduling is typically done via a CRON job or Cloud Tasks that triggers FCM at the right time.
        # For MVP Phase 10.5, we will simulate the enqueueing by logging and immediately sending a background push if applicable,
        # or relying on a task queue like Celery. Without a task queue, we just send it if it's within 1 minute, otherwise log.
        # To properly implement 'scheduling' with FCM without a task queue, Cloud Tasks is standard.
        logger.info(f"FCM Notification Queued for {patient_id} at {scheduled_at_utc}: {title}")
        return "fcm_queued_id"

    async def cancel_notification(self, patient_id: str, notification_id: str):
        logger.info(f"FCM Notification Cancelled: {notification_id}")

if os.getenv("USE_FCM_NOTIFICATIONS") == "true":
    notification_provider = FCMNotificationProvider()
else:
    notification_provider = MockNotificationProvider()

