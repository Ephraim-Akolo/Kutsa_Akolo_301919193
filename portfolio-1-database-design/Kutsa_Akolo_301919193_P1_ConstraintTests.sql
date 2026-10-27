\set ON_ERROR_STOP off
\pset pager off
SET search_path TO erp, public;

-- 1. pk_guest_account
INSERT INTO guest_account (guest_id, full_name, email_address, phone_number, loyalty_tier)
VALUES ('11111111-1111-4111-8111-000000001001', 'Duplicate ID Guest', 'dup.id@lagosmail.ng', '+2348030000001', 'standard');

-- 2. uq_guest_email
INSERT INTO guest_account (guest_id, full_name, email_address, phone_number, loyalty_tier)
VALUES ('11111111-1111-4111-8111-000000001099', 'Email Clash Guest', 'tunde.adebayo@lagosmail.ng', '+2348030000002', 'standard');

-- 3. uq_guest_phone
INSERT INTO guest_account (guest_id, full_name, email_address, phone_number, loyalty_tier)
VALUES ('11111111-1111-4111-8111-000000001098', 'Phone Clash Guest', 'unique.mail@lagosmail.ng', '+2348032104511', 'standard');

-- 4. guest_account NOT NULL
INSERT INTO guest_account (guest_id, full_name, email_address, phone_number, loyalty_tier)
VALUES ('11111111-1111-4111-8111-000000001097', NULL, 'null.name@lagosmail.ng', '+2348030000003', 'standard');

-- 5. ck_guest_tier
INSERT INTO guest_account (guest_id, full_name, email_address, phone_number, loyalty_tier)
VALUES ('11111111-1111-4111-8111-000000001096', 'Invalid Tier Guest', 'tier.bad@lagosmail.ng', '+2348030000004', 'platinum_plus');

-- 6. uq_room_code
INSERT INTO room_unit (room_id, room_code, wing_name, room_category, base_rate, operational_status)
VALUES ('22222222-2222-4222-8222-000000002099', 'A-101', 'savannah_wing', 'standard', 45000.00, 'available');

-- 7. ck_room_rate_positive
INSERT INTO room_unit (room_id, room_code, wing_name, room_category, base_rate, operational_status)
VALUES ('22222222-2222-4222-8222-000000002098', 'B-999', 'lagoon_wing', 'deluxe', 0.00, 'available');

-- 8. ck_room_category
INSERT INTO room_unit (room_id, room_code, wing_name, room_category, base_rate, operational_status)
VALUES ('22222222-2222-4222-8222-000000002097', 'B-998', 'lagoon_wing', 'penthouse', 250000.00, 'available');

-- 9. ck_room_status
INSERT INTO room_unit (room_id, room_code, wing_name, room_category, base_rate, operational_status)
VALUES ('22222222-2222-4222-8222-000000002096', 'B-997', 'lagoon_wing', 'standard', 45000.00, 'demolished');

-- 10. fk_booking_guest
INSERT INTO stay_booking (booking_id, guest_id, room_id, check_in_date, check_out_date, total_charge, booking_state)
VALUES ('33333333-3333-4333-8333-000000003099', '11111111-1111-4111-8111-000000009999', '22222222-2222-4222-8222-000000002003', '2026-11-01', '2026-11-03', 220000.00, 'confirmed');

-- 11. fk_booking_room
INSERT INTO stay_booking (booking_id, guest_id, room_id, check_in_date, check_out_date, total_charge, booking_state)
VALUES ('33333333-3333-4333-8333-000000003098', '11111111-1111-4111-8111-000000001001', '22222222-2222-4222-8222-000000009999', '2026-11-01', '2026-11-03', 90000.00, 'confirmed');

-- 12. ck_booking_dates
INSERT INTO stay_booking (booking_id, guest_id, room_id, check_in_date, check_out_date, total_charge, booking_state)
VALUES ('33333333-3333-4333-8333-000000003097', '11111111-1111-4111-8111-000000001001', '22222222-2222-4222-8222-000000002003', '2026-11-10', '2026-11-05', 110000.00, 'confirmed');

-- 13. uq_active_room_booking
INSERT INTO stay_booking (booking_id, guest_id, room_id, check_in_date, check_out_date, total_charge, booking_state)
VALUES ('33333333-3333-4333-8333-000000003096', '11111111-1111-4111-8111-000000001003', '22222222-2222-4222-8222-000000002001', '2026-10-12', '2026-10-14', 90000.00, 'confirmed');

-- 14. fk_payment_booking
INSERT INTO folio_payment (payment_id, booking_id, receipt_ref, amount_paid, payment_channel, payment_state)
VALUES ('44444444-4444-4444-8444-000000004099', '33333333-3333-4333-8333-000000009999', 'RCP-2026-9991', 45000.00, 'card_pos', 'captured');

-- 15. uq_payment_receipt
INSERT INTO folio_payment (payment_id, booking_id, receipt_ref, amount_paid, payment_channel, payment_state)
VALUES ('44444444-4444-4444-8444-000000004098', '33333333-3333-4333-8333-000000003001', 'RCP-2026-8801', 15000.00, 'card_pos', 'captured');

-- 16. ck_payment_amount_positive
INSERT INTO folio_payment (payment_id, booking_id, receipt_ref, amount_paid, payment_channel, payment_state)
VALUES ('44444444-4444-4444-8444-000000004097', '33333333-3333-4333-8333-000000003001', 'RCP-2026-9992', -5000.00, 'card_pos', 'captured');

SELECT 'guest_account' AS table_name, COUNT(*) AS row_count FROM guest_account
UNION ALL
SELECT 'room_unit', COUNT(*) FROM room_unit
UNION ALL
SELECT 'stay_booking', COUNT(*) FROM stay_booking
UNION ALL
SELECT 'folio_payment', COUNT(*) FROM folio_payment;
