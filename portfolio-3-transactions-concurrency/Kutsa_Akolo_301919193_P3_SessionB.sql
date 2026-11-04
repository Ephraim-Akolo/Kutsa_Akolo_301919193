-- Session B
SET search_path TO erp, public;

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT booking_id, total_charge AS session_b_locked_read
FROM stay_booking
WHERE booking_id = '33333333-3333-4333-8333-000000003001'
FOR UPDATE;

UPDATE stay_booking
SET total_charge = total_charge + 10000.00
WHERE booking_id = '33333333-3333-4333-8333-000000003001';

COMMIT;

SELECT booking_id, total_charge AS final_charge_after_both_sessions
FROM stay_booking
WHERE booking_id = '33333333-3333-4333-8333-000000003001';
