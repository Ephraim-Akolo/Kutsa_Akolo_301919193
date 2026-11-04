\set ON_ERROR_STOP off
\pset pager off
SET search_path TO erp, public;

UPDATE stay_booking
SET total_charge = 135000.00
WHERE booking_id = '33333333-3333-4333-8333-000000003001';

-- 1. COMMIT test
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT booking_id, total_charge, booking_state
FROM stay_booking
WHERE booking_id = '33333333-3333-4333-8333-000000003001';

UPDATE stay_booking
SET total_charge = total_charge + 15000.00
WHERE booking_id = '33333333-3333-4333-8333-000000003001';

SELECT booking_id, total_charge AS uncommitted_charge_in_tx1
FROM stay_booking
WHERE booking_id = '33333333-3333-4333-8333-000000003001';

\! psql -U postgres -d hotel_erp_db -c "SELECT booking_id, total_charge AS concurrent_reader_before_commit FROM erp.stay_booking WHERE booking_id = '33333333-3333-4333-8333-000000003001';"

COMMIT;

SELECT booking_id, total_charge AS committed_charge_after_tx1
FROM stay_booking
WHERE booking_id = '33333333-3333-4333-8333-000000003001';

-- 2. ROLLBACK test
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

UPDATE stay_booking
SET total_charge = -5000.00
WHERE booking_id = '33333333-3333-4333-8333-000000003001';

SELECT booking_id, total_charge
FROM stay_booking
WHERE booking_id = '33333333-3333-4333-8333-000000003001';

ROLLBACK;

SELECT booking_id, total_charge AS charge_after_rollback
FROM stay_booking
WHERE booking_id = '33333333-3333-4333-8333-000000003001';
