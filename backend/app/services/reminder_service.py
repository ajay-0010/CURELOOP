from app.models.prescription import DoseEvent, Prescription
from app.services.notification_provider import notification_provider
from app.services.safety_engine import can_activate_reminders


class ReminderService:
    @staticmethod
    async def schedule_reminders_for_prescription(
        prescription: Prescription, doses: list[DoseEvent]
    ):
        """
        Schedules notifications for all generated doses.
        MUST verify safety check first.
        """
        if not can_activate_reminders(prescription):
            return  # Safety boundary violation

        for dose in doses:
            # Reconstruct the text
            med = dose.medicine
            title = "Medicine Reminder"
            body = f"Time to take {med.medicine_name} â€” {med.dosage}"
            if med.food_timing and med.food_timing != "no_instruction":
                body += f" â€” {med.food_timing.replace('_', ' ')}."

            await notification_provider.schedule_notification(
                patient_id=prescription.patient_id,
                title=title,
                body=body,
                scheduled_at_utc=str(dose.scheduled_at),
            )

    @staticmethod
    async def cancel_reminders_for_prescription(prescription_id):
        """
        Cancels all future reminders for a prescription.
        """
        # In a fully developed app, we would query the scheduled notification IDs and cancel them.
        # For MVP, we log the cancellation.
        await notification_provider.cancel_notification(
            patient_id="unknown", notification_id=f"all_for_{prescription_id}"
        )

