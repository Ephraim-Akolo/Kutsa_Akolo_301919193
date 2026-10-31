\pset pager off
DROP SCHEMA IF EXISTS erp_perf CASCADE;
CREATE SCHEMA erp_perf;
SET search_path TO erp_perf, public;

CREATE TABLE stay_booking_perf (
    perf_booking_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    guest_id        uuid NOT NULL,
    room_id         uuid NOT NULL,
    check_in_date   date NOT NULL,
    check_out_date  date NOT NULL,
    total_charge    numeric(12, 2) NOT NULL,
    booking_state   varchar(20) NOT NULL,
    booked_at       timestamptz NOT NULL
);

INSERT INTO stay_booking_perf (
    perf_booking_id,
    guest_id,
    room_id,
    check_in_date,
    check_out_date,
    total_charge,
    booking_state,
    booked_at
)
SELECT
    ('33333333-3333-4333-8333-' || LPAD(gs::text, 12, '0'))::uuid AS perf_booking_id,
    ('11111111-1111-4111-8111-' || LPAD((1000 + (gs % 4000))::text, 12, '0'))::uuid AS guest_id,
    ('22222222-2222-4222-8222-' || LPAD((2000 + (gs % 250))::text, 12, '0'))::uuid AS room_id,
    DATE '2026-01-01' + ((gs % 600) * INTERVAL '1 day')::interval AS check_in_date,
    DATE '2026-01-01' + (((gs % 600) + 2 + (gs % 5)) * INTERVAL '1 day')::interval AS check_out_date,
    (45000 + (gs % 8) * 18000)::numeric(12, 2) AS total_charge,
    CASE (((gs / 600) % 2) + ((gs % 2) * 2))
        WHEN 0 THEN 'confirmed'
        WHEN 1 THEN 'checked_out'
        WHEN 2 THEN 'checked_in'
        ELSE 'cancelled'
    END AS booking_state,
    TIMESTAMPTZ '2025-12-01 08:00:00+01' + (gs * INTERVAL '5 minutes') AS booked_at
FROM generate_series(1, 60000) AS gs;

VACUUM ANALYZE stay_booking_perf;

SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (
        WHERE check_in_date = DATE '2027-02-15'
          AND booking_state = 'confirmed'
    ) AS matching_rows
FROM stay_booking_perf;

-- Before index (3 runs)
EXPLAIN (ANALYZE, BUFFERS)
SELECT perf_booking_id, guest_id, room_id, check_in_date, check_out_date, total_charge
FROM stay_booking_perf
WHERE check_in_date = DATE '2027-02-15'
  AND booking_state = 'confirmed'
ORDER BY perf_booking_id;

EXPLAIN (ANALYZE, BUFFERS)
SELECT perf_booking_id, guest_id, room_id, check_in_date, check_out_date, total_charge
FROM stay_booking_perf
WHERE check_in_date = DATE '2027-02-15'
  AND booking_state = 'confirmed'
ORDER BY perf_booking_id;

EXPLAIN (ANALYZE, BUFFERS)
SELECT perf_booking_id, guest_id, room_id, check_in_date, check_out_date, total_charge
FROM stay_booking_perf
WHERE check_in_date = DATE '2027-02-15'
  AND booking_state = 'confirmed'
ORDER BY perf_booking_id;

-- Create composite B-tree index
CREATE INDEX idx_booking_perf_checkin_state
    ON stay_booking_perf (check_in_date, booking_state);

VACUUM ANALYZE stay_booking_perf;

-- After index (3 runs)
EXPLAIN (ANALYZE, BUFFERS)
SELECT perf_booking_id, guest_id, room_id, check_in_date, check_out_date, total_charge
FROM stay_booking_perf
WHERE check_in_date = DATE '2027-02-15'
  AND booking_state = 'confirmed'
ORDER BY perf_booking_id;

EXPLAIN (ANALYZE, BUFFERS)
SELECT perf_booking_id, guest_id, room_id, check_in_date, check_out_date, total_charge
FROM stay_booking_perf
WHERE check_in_date = DATE '2027-02-15'
  AND booking_state = 'confirmed'
ORDER BY perf_booking_id;

EXPLAIN (ANALYZE, BUFFERS)
SELECT perf_booking_id, guest_id, room_id, check_in_date, check_out_date, total_charge
FROM stay_booking_perf
WHERE check_in_date = DATE '2027-02-15'
  AND booking_state = 'confirmed'
ORDER BY perf_booking_id;
