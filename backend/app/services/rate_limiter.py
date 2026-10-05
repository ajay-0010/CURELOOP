from datetime import datetime, timezone, timedelta
from typing import Dict, List

class RateLimiter:
    def __init__(self, limit: int, window_minutes: int):
        self.limit = limit
        self.window = timedelta(minutes=window_minutes)
        self.requests: Dict[str, List[datetime]] = {}

    def is_allowed(self, key: str) -> bool:
        now = datetime.now(timezone.utc)
        if key not in self.requests:
            self.requests[key] = []
        
        # Remove old requests
        self.requests[key] = [t for t in self.requests[key] if now - t < self.window]
        
        if len(self.requests[key]) >= self.limit:
            return False
        
        self.requests[key].append(now)
        return True

    def clear(self, key: str):
        if key in self.requests:
            del self.requests[key]
