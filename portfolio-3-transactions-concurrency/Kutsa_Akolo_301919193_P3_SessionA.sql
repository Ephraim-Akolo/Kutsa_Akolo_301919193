-- Session A
SET search_path TO erp, public;

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT booking_id, total_charge
FROM stay_booking
WHERE booking_id = '33333333-3333-4333-8333-000000003001'
FOR UPDATE;

UPDATE stay_booking
SET total_charge = 160000.00
WHERE booking_id = '33333333-3333-4333-8333-000000003001';

SELECT pg_sleep(3);

COMMIT;

SELECT booking_id, total_charge AS session_a_after_commit
FROM stay_booking
WHERE booking_id = '33333333-3333-4333-8333-000000003001';
