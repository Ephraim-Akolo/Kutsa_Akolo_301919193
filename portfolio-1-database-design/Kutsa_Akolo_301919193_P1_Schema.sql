DROP SCHEMA IF EXISTS erp CASCADE;
CREATE SCHEMA erp;
SET search_path TO erp, public;

CREATE TABLE guest_account (
    guest_id      uuid DEFAULT gen_random_uuid(),
    full_name     varchar(100) NOT NULL,
    email_address varchar(150) NOT NULL,
    phone_number  varchar(20) NOT NULL,
    loyalty_tier  varchar(20) NOT NULL DEFAULT 'standard',
    CONSTRAINT pk_guest_account PRIMARY KEY (guest_id),
    CONSTRAINT uq_guest_email UNIQUE (email_address),
    CONSTRAINT uq_guest_phone UNIQUE (phone_number),
    CONSTRAINT ck_guest_tier CHECK (loyalty_tier IN ('standard', 'silver', 'gold', 'corporate'))
);

CREATE TABLE room_unit (
    room_id            uuid DEFAULT gen_random_uuid(),
    room_code          varchar(15) NOT NULL,
    wing_name          varchar(50) NOT NULL,
    room_category      varchar(25) NOT NULL,
    base_rate          numeric(12, 2) NOT NULL,
    operational_status varchar(20) NOT NULL DEFAULT 'available',
    CONSTRAINT pk_room_unit PRIMARY KEY (room_id),
    CONSTRAINT uq_room_code UNIQUE (room_code),
    CONSTRAINT ck_room_category CHECK (room_category IN ('standard', 'deluxe', 'executive', 'suite')),
    CONSTRAINT ck_room_rate_positive CHECK (base_rate > 0),
    CONSTRAINT ck_room_status CHECK (operational_status IN ('available', 'occupied', 'maintenance'))
);

CREATE TABLE stay_booking (
    booking_id     uuid DEFAULT gen_random_uuid(),
    guest_id       uuid NOT NULL,
    room_id        uuid NOT NULL,
    check_in_date  date NOT NULL,
    check_out_date date NOT NULL,
    total_charge   numeric(12, 2) NOT NULL,
    booking_state  varchar(20) NOT NULL DEFAULT 'confirmed',
    booked_at      timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_stay_booking PRIMARY KEY (booking_id),
    CONSTRAINT fk_booking_guest FOREIGN KEY (guest_id)
        REFERENCES guest_account (guest_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_booking_room FOREIGN KEY (room_id)
        REFERENCES room_unit (room_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT ck_booking_dates CHECK (check_out_date > check_in_date),
    CONSTRAINT ck_booking_charge_nonneg CHECK (total_charge >= 0),
    CONSTRAINT ck_booking_state CHECK (booking_state IN ('confirmed', 'checked_in', 'checked_out', 'cancelled'))
);

CREATE UNIQUE INDEX uq_active_room_booking
    ON stay_booking (room_id)
    WHERE booking_state IN ('confirmed', 'checked_in');

CREATE TABLE folio_payment (
    payment_id      uuid DEFAULT gen_random_uuid(),
    booking_id      uuid NOT NULL,
    receipt_ref     varchar(30) NOT NULL,
    amount_paid     numeric(12, 2) NOT NULL,
    payment_channel varchar(25) NOT NULL,
    payment_state   varchar(20) NOT NULL DEFAULT 'captured',
    paid_at         timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_folio_payment PRIMARY KEY (payment_id),
    CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id)
        REFERENCES stay_booking (booking_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT uq_payment_receipt UNIQUE (receipt_ref),
    CONSTRAINT ck_payment_amount_positive CHECK (amount_paid > 0),
    CONSTRAINT ck_payment_channel CHECK (payment_channel IN ('card_pos', 'bank_transfer', 'corporate_invoice', 'wallet')),
    CONSTRAINT ck_payment_state CHECK (payment_state IN ('captured', 'refunded', 'voided'))
);
