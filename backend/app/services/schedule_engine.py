from datetime import time

from app.models.prescription import MedicineSchedule

# Default times for slots
SLOT_TIMES = [
    time(8, 0),  # Morning
    time(13, 0),  # Afternoon
    time(18, 0),  # Evening
    time(21, 0),  # Night
]


def generate_schedules_for_frequency(frequency: str) -> list[MedicineSchedule]:
    """
    Parses a frequency string like '1-0-1' or '1-1-1'
    and generates MedicineSchedule objects for each time slot.
    """
    schedules = []
    parts = frequency.split("-")

    for i, part in enumerate(parts):
        try:
            count = int(part)
        except ValueError:
            continue

        if count > 0:
            # Pick a time from SLOT_TIMES based on index, defaulting to last slot if out of bounds
            slot_time = SLOT_TIMES[i] if i < len(SLOT_TIMES) else time(22, 0)

            # If count > 1 for a slot, we could technically generate multiple.
            # But for simple '1-0-1', count is usually 1.
            # We'll just generate one schedule for that slot for now.
            schedule = MedicineSchedule(scheduled_time=slot_time)
            schedules.append(schedule)

    return schedules
