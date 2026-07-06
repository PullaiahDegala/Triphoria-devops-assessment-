-- =========================================================
-- 002_indexes.sql
-- Performance Indexes
-- =========================================================

------------------------------------------------------------
-- Assignment Query Optimization
------------------------------------------------------------

CREATE INDEX IF NOT EXISTS idx_booking_city_created
ON hotel_bookings(city, created_at);

CREATE INDEX IF NOT EXISTS idx_booking_org_status
ON hotel_bookings(org_id, status);

------------------------------------------------------------
-- Foreign Key Lookup
------------------------------------------------------------

CREATE INDEX IF NOT EXISTS idx_booking_events_booking
ON booking_events(booking_id);

------------------------------------------------------------
-- Event Type Lookup
------------------------------------------------------------

CREATE INDEX IF NOT EXISTS idx_booking_events_event_type
ON booking_events(event_type);