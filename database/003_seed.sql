-- =========================================================
-- Seed 100 Hotel Bookings
-- =========================================================

INSERT INTO hotel_bookings
(
    org_id,
    hotel_id,
    city,
    checkin_date,
    checkout_date,
    amount,
    status,
    created_at
)

SELECT

gen_random_uuid(),

'HTL-' || gs,

(
ARRAY[
'delhi',
'hyderabad',
'chennai',
'mumbai',
'bangalore'
]
)[floor(random()*5+1)],

CURRENT_DATE + (random()*20)::INT,

CURRENT_DATE + ((random()*20)+2)::INT,

ROUND((1000 + random()*9000)::numeric,2),

(
ARRAY[
'BOOKED',
'COMPLETED',
'PENDING',
'CANCELLED'
]
)[floor(random()*4+1)],

NOW() - ((random()*40)::INT || ' days')::INTERVAL

FROM generate_series(1,100) gs;
-- =========================================================
-- Seed Booking Events
-- =========================================================

INSERT INTO booking_events
(
    booking_id,
    event_type,
    payload,
    created_at
)
SELECT
    id,
    CASE
        WHEN random() < 0.5 THEN 'BOOKING_CREATED'
        ELSE 'PAYMENT_SUCCESS'
    END,
    jsonb_build_object(
        'source', 'system',
        'status', status,
        'city', city
    ),
    NOW() - ((random() * 20)::INT || ' days')::INTERVAL
FROM hotel_bookings
LIMIT 50;