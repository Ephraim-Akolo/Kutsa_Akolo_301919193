SET search_path TO erp, public;

INSERT INTO guest_account (guest_id, full_name, email_address, phone_number, loyalty_tier) VALUES
    ('11111111-1111-4111-8111-000000001001', 'Tunde Adebayo',  'tunde.adebayo@lagosmail.ng',   '+2348032104511', 'gold'),
    ('11111111-1111-4111-8111-000000001002', 'Zainab Danjuma', 'zainab.danjuma@arewacorp.ng',  '+2348094418820', 'corporate'),
    ('11111111-1111-4111-8111-000000001003', 'Chinedu Okafor', 'chinedu.okafor@enugutech.com', '+2348027739104', 'silver'),
    ('11111111-1111-4111-8111-000000001004', 'Amina Bello',    'amina.bello@abujapro.org',     '+2348056623098', 'standard');

INSERT INTO room_unit (room_id, room_code, wing_name, room_category, base_rate, operational_status) VALUES
    ('22222222-2222-4222-8222-000000002001', 'A-101', 'savannah_wing', 'standard',  45000.00, 'occupied'),
    ('22222222-2222-4222-8222-000000002002', 'A-204', 'savannah_wing', 'deluxe',    72000.00, 'occupied'),
    ('22222222-2222-4222-8222-000000002003', 'B-301', 'lagoon_wing',   'executive', 110000.00, 'available'),
    ('22222222-2222-4222-8222-000000002004', 'C-401', 'ambassador_wing', 'suite',   185000.00, 'available'),
    ('22222222-2222-4222-8222-000000002005', 'A-105', 'savannah_wing', 'standard',  45000.00, 'maintenance');

INSERT INTO stay_booking (booking_id, guest_id, room_id, check_in_date, check_out_date, total_charge, booking_state, booked_at) VALUES
    ('33333333-3333-4333-8333-000000003001', '11111111-1111-4111-8111-000000001001', '22222222-2222-4222-8222-000000002001', '2026-10-10', '2026-10-13', 135000.00, 'checked_in',  '2026-10-08 09:15:00+01'),
    ('33333333-3333-4333-8333-000000003002', '11111111-1111-4111-8111-000000001002', '22222222-2222-4222-8222-000000002002', '2026-10-11', '2026-10-15', 288000.00, 'checked_in',  '2026-10-09 14:20:00+01'),
    ('33333333-3333-4333-8333-000000003003', '11111111-1111-4111-8111-000000001003', '22222222-2222-4222-8222-000000002003', '2026-10-01', '2026-10-04', 330000.00, 'checked_out', '2026-09-25 11:05:00+01'),
    ('33333333-3333-4333-8333-000000003004', '11111111-1111-4111-8111-000000001004', '22222222-2222-4222-8222-000000002004', '2026-10-20', '2026-10-22', 370000.00, 'confirmed',   '2026-10-10 16:40:00+01'),
    ('33333333-3333-4333-8333-000000003005', '11111111-1111-4111-8111-000000001001', '22222222-2222-4222-8222-000000002003', '2026-09-12', '2026-09-14', 220000.00, 'cancelled',   '2026-09-05 18:10:00+01');

INSERT INTO folio_payment (payment_id, booking_id, receipt_ref, amount_paid, payment_channel, payment_state, paid_at) VALUES
    ('44444444-4444-4444-8444-000000004001', '33333333-3333-4333-8333-000000003001', 'RCP-2026-8801',  90000.00, 'card_pos',          'captured', '2026-10-10 12:05:00+01'),
    ('44444444-4444-4444-8444-000000004002', '33333333-3333-4333-8333-000000003001', 'RCP-2026-8802',  45000.00, 'bank_transfer',     'captured', '2026-10-11 08:30:00+01'),
    ('44444444-4444-4444-8444-000000004003', '33333333-3333-4333-8333-000000003002', 'RCP-2026-8803', 288000.00, 'corporate_invoice', 'captured', '2026-10-11 15:10:00+01'),
    ('44444444-4444-4444-8444-000000004004', '33333333-3333-4333-8333-000000003003', 'RCP-2026-8804', 330000.00, 'card_pos',          'captured', '2026-10-01 13:45:00+01'),
    ('44444444-4444-4444-8444-000000004005', '33333333-3333-4333-8333-000000003005', 'RCP-2026-8805',  50000.00, 'wallet',            'refunded', '2026-09-06 10:00:00+01');

SELECT guest_id, full_name, email_address, phone_number, loyalty_tier
FROM guest_account
ORDER BY guest_id;

SELECT room_id, room_code, wing_name, room_category, base_rate, operational_status
FROM room_unit
ORDER BY room_id;

SELECT booking_id, guest_id, room_id, check_in_date, check_out_date, total_charge, booking_state
FROM stay_booking
ORDER BY booking_id;

SELECT payment_id, booking_id, receipt_ref, amount_paid, payment_channel, payment_state
FROM folio_payment
ORDER BY payment_id;
