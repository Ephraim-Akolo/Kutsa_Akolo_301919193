\pset pager off
SET search_path TO erp, public;

-- Query 1: Multi-table join
SELECT
    sb.booking_id,
    ga.full_name,
    ga.loyalty_tier,
    ru.room_code,
    ru.wing_name,
    ru.room_category,
    sb.check_in_date,
    sb.check_out_date,
    sb.total_charge,
    sb.booking_state,
    COALESCE(
        SUM(fp.amount_paid) FILTER (WHERE fp.payment_state = 'captured'),
        0.00
    ) AS settled_amount,
    sb.total_charge - COALESCE(
        SUM(fp.amount_paid) FILTER (WHERE fp.payment_state = 'captured'),
        0.00
    ) AS outstanding_balance
FROM stay_booking AS sb
INNER JOIN guest_account AS ga
    ON ga.guest_id = sb.guest_id
INNER JOIN room_unit AS ru
    ON ru.room_id = sb.room_id
LEFT JOIN folio_payment AS fp
    ON fp.booking_id = sb.booking_id
GROUP BY
    sb.booking_id,
    ga.full_name,
    ga.loyalty_tier,
    ru.room_code,
    ru.wing_name,
    ru.room_category,
    sb.check_in_date,
    sb.check_out_date,
    sb.total_charge,
    sb.booking_state
ORDER BY sb.booking_id;

-- Query 2: Filtered query
SELECT
    sb.booking_id,
    ga.full_name,
    ga.phone_number,
    ru.room_code,
    ru.wing_name,
    sb.check_in_date,
    sb.check_out_date,
    sb.total_charge,
    sb.booking_state
FROM stay_booking AS sb
INNER JOIN guest_account AS ga
    ON ga.guest_id = sb.guest_id
INNER JOIN room_unit AS ru
    ON ru.room_id = sb.room_id
WHERE sb.booking_state IN ('confirmed', 'checked_in')
  AND sb.check_in_date BETWEEN DATE '2026-10-10' AND DATE '2026-10-25'
  AND sb.total_charge >= 120000.00
ORDER BY sb.check_in_date ASC, sb.booking_id ASC;

-- Query 3: Aggregation query
SELECT
    ru.wing_name,
    ru.room_category,
    COUNT(DISTINCT sb.booking_id) AS non_cancelled_bookings,
    SUM(sb.check_out_date - sb.check_in_date) AS total_room_nights,
    SUM(sb.total_charge) AS billed_revenue,
    COALESCE(
        SUM(fp.amount_paid) FILTER (WHERE fp.payment_state = 'captured'),
        0.00
    ) AS captured_cash,
    ROUND(AVG(sb.total_charge), 2) AS avg_booking_value
FROM room_unit AS ru
INNER JOIN stay_booking AS sb
    ON sb.room_id = ru.room_id
LEFT JOIN folio_payment AS fp
    ON fp.booking_id = sb.booking_id
WHERE sb.booking_state <> 'cancelled'
GROUP BY
    ru.wing_name,
    ru.room_category
ORDER BY billed_revenue DESC, ru.wing_name ASC;
