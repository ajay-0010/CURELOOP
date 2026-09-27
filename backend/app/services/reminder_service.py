from datetime import timedelta

from app.models.appointment import Appointment, AppointmentStatus
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
            body = f"Time to take {med.medicine_name} - {med.dosage}"
            if med.food_timing and med.food_timing != "no_instruction":
                body += f" - {med.food_timing.replace('_', ' ')}."

            await notification_provider.schedule_notification(
                patient_id=str(prescription.patient_id),
                title=title,
                body=body,
                scheduled_at_utc=str(dose.scheduled_at),
            )

    @staticmethod
    async def cancel_reminders_for_prescription(prescription_id):
        """
        Cancels all future reminders for a prescription.
        """
        await notification_provider.cancel_notification(
            patient_id="unknown",
            notification_id=f"all_for_prescription_{prescription_id}",
        )

    @staticmethod
    async def schedule_appointment_reminders(appointment: Appointment):
        if appointment.status != AppointmentStatus.SCHEDULED:
            return

        title = "Appointment Reminder"
        clinic_text = (
            f" at {appointment.clinic_name}" if appointment.clinic_name else ""
        )

        # 24h reminder
        t24h = appointment.appointment_datetime - timedelta(hours=24)
        body_24h = f"Appointment reminder: Dr. {appointment.doctor_name}{clinic_text} tomorrow at {appointment.appointment_datetime.strftime('%I:%M %p')}."
        await notification_provider.schedule_notification(
            patient_id=str(appointment.patient_id),
            title=title,
            body=body_24h,
            scheduled_at_utc=str(t24h),
        )

        # 2h reminder
        t2h = appointment.appointment_datetime - timedelta(hours=2)
        body_2h = f"Appointment reminder: Dr. {appointment.doctor_name}{clinic_text} today at {appointment.appointment_datetime.strftime('%I:%M %p')}."
        await notification_provider.schedule_notification(
            patient_id=str(appointment.patient_id),
            title=title,
            body=body_2h,
            scheduled_at_utc=str(t2h),
        )

    @staticmethod
    async def cancel_appointment_reminders(appointment_id: str, patient_id: str):
        await notification_provider.cancel_notification(
            patient_id=patient_id,
            notification_id=f"all_for_appointment_{appointment_id}",
        )
