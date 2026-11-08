const dbName = "hotel_erp_nosql";
const targetDb = db.getSiblingDB(dbName);

targetDb.folio_audit_events.drop();

targetDb.createCollection("folio_audit_events", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: [
        "_id",
        "eventCategory",
        "recordedAt",
        "bookingRef",
        "guestSnapshot",
        "roomSnapshot",
        "payload"
      ],
      properties: {
        _id: { bsonType: "string" },
        eventCategory: {
          enum: [
            "booking_checked_in",
            "payment_captured",
            "booking_cancelled"
          ]
        },
        recordedAt: { bsonType: "date" },
        bookingRef: {
          bsonType: "object",
          required: ["booking_id", "booking_state"],
          properties: {
            booking_id: { bsonType: "string" },
            booking_state: { bsonType: "string" }
          }
        },
        guestSnapshot: {
          bsonType: "object",
          required: ["guest_id", "full_name", "loyalty_tier"],
          properties: {
            guest_id: { bsonType: "string" },
            full_name: { bsonType: "string" },
            loyalty_tier: { bsonType: "string" }
          }
        },
        roomSnapshot: {
          bsonType: "object",
          required: ["room_id", "room_code", "wing_name"],
          properties: {
            room_id: { bsonType: "string" },
            room_code: { bsonType: "string" },
            wing_name: { bsonType: "string" }
          }
        },
        payload: { bsonType: "object" }
      }
    }
  },
  validationLevel: "strict",
  validationAction: "error"
});

targetDb.folio_audit_events.createIndex(
  { eventCategory: 1, recordedAt: -1 },
  { name: "idx_category_recordedAt" }
);

const insertResult = targetDb.folio_audit_events.insertMany([
  {
    _id: "evt_2026_3001_checkin",
    eventCategory: "booking_checked_in",
    recordedAt: ISODate("2026-10-10T13:10:00Z"),
    bookingRef: {
      booking_id: "33333333-3333-4333-8333-000000003001",
      booking_state: "checked_in"
    },
    guestSnapshot: {
      guest_id: "11111111-1111-4111-8111-000000001001",
      full_name: "Tunde Adebayo",
      loyalty_tier: "gold"
    },
    roomSnapshot: {
      room_id: "22222222-2222-4222-8222-000000002001",
      room_code: "A-101",
      wing_name: "savannah_wing"
    },
    payload: {
      deskClerk: "stf_402",
      keycardsIssued: 2,
      idVerified: "NIN_SLIP",
      luggageTags: ["LG-101A", "LG-101B"]
    }
  },
  {
    _id: "evt_2026_4001_payment",
    eventCategory: "payment_captured",
    recordedAt: ISODate("2026-10-10T11:05:00Z"),
    bookingRef: {
      booking_id: "33333333-3333-4333-8333-000000003001",
      booking_state: "checked_in"
    },
    guestSnapshot: {
      guest_id: "11111111-1111-4111-8111-000000001001",
      full_name: "Tunde Adebayo",
      loyalty_tier: "gold"
    },
    roomSnapshot: {
      room_id: "22222222-2222-4222-8222-000000002001",
      room_code: "A-101",
      wing_name: "savannah_wing"
    },
    payload: {
      payment_id: "44444444-4444-4444-8444-000000004001",
      receipt_ref: "RCP-2026-8801",
      amount_paid: 90000.0,
      payment_channel: "card_pos",
      posTerminalId: "POS-SAV-02",
      stanCode: "558291"
    }
  },
  {
    _id: "evt_2026_4002_payment",
    eventCategory: "payment_captured",
    recordedAt: ISODate("2026-10-11T07:30:00Z"),
    bookingRef: {
      booking_id: "33333333-3333-4333-8333-000000003001",
      booking_state: "checked_in"
    },
    guestSnapshot: {
      guest_id: "11111111-1111-4111-8111-000000001001",
      full_name: "Tunde Adebayo",
      loyalty_tier: "gold"
    },
    roomSnapshot: {
      room_id: "22222222-2222-4222-8222-000000002001",
      room_code: "A-101",
      wing_name: "savannah_wing"
    },
    payload: {
      payment_id: "44444444-4444-4444-8444-000000004002",
      receipt_ref: "RCP-2026-8802",
      amount_paid: 45000.0,
      payment_channel: "bank_transfer",
      nipSessionId: "0000142610110730991204",
      originBank: "Access Bank"
    }
  },
  {
    _id: "evt_2026_3002_checkin",
    eventCategory: "booking_checked_in",
    recordedAt: ISODate("2026-10-11T14:00:00Z"),
    bookingRef: {
      booking_id: "33333333-3333-4333-8333-000000003002",
      booking_state: "checked_in"
    },
    guestSnapshot: {
      guest_id: "11111111-1111-4111-8111-000000001002",
      full_name: "Zainab Danjuma",
      loyalty_tier: "corporate"
    },
    roomSnapshot: {
      room_id: "22222222-2222-4222-8222-000000002002",
      room_code: "A-204",
      wing_name: "savannah_wing"
    },
    payload: {
      deskClerk: "stf_409",
      keycardsIssued: 1,
      corporateAccountCode: "AREWA-CORP-19",
      airportPickupIncluded: true
    }
  },
  {
    _id: "evt_2026_4003_payment",
    eventCategory: "payment_captured",
    recordedAt: ISODate("2026-10-11T14:10:00Z"),
    bookingRef: {
      booking_id: "33333333-3333-4333-8333-000000003002",
      booking_state: "checked_in"
    },
    guestSnapshot: {
      guest_id: "11111111-1111-4111-8111-000000001002",
      full_name: "Zainab Danjuma",
      loyalty_tier: "corporate"
    },
    roomSnapshot: {
      room_id: "22222222-2222-4222-8222-000000002002",
      room_code: "A-204",
      wing_name: "savannah_wing"
    },
    payload: {
      payment_id: "44444444-4444-4444-8444-000000004003",
      receipt_ref: "RCP-2026-8803",
      amount_paid: 288000.0,
      payment_channel: "corporate_invoice",
      purchaseOrderRef: "PO-AC-2026-774"
    }
  },
  {
    _id: "evt_2026_3005_cancel",
    eventCategory: "booking_cancelled",
    recordedAt: ISODate("2026-09-06T08:45:00Z"),
    bookingRef: {
      booking_id: "33333333-3333-4333-8333-000000003005",
      booking_state: "cancelled"
    },
    guestSnapshot: {
      guest_id: "11111111-1111-4111-8111-000000001001",
      full_name: "Tunde Adebayo",
      loyalty_tier: "gold"
    },
    roomSnapshot: {
      room_id: "22222222-2222-4222-8222-000000002003",
      room_code: "B-301",
      wing_name: "lagoon_wing"
    },
    payload: {
      cancelledBy: "guest_portal",
      reason: "Flight rescheduled",
      refundReceiptRef: "RCP-2026-8805",
      refundAmount: 50000.0
    }
  }
]);

print("=== INSERTED DOCUMENTS COUNT ===");
printjson({ insertedCount: Object.keys(insertResult.insertedIds).length });

print("\n=== QUERY 1: FILTER BY EVENT CATEGORY (payment_captured) ===");
printjson(
  targetDb.folio_audit_events
    .find(
      { eventCategory: "payment_captured" },
      { _id: 1, recordedAt: 1, "bookingRef.booking_id": 1, "payload.receipt_ref": 1, "payload.amount_paid": 1 }
    )
    .sort({ recordedAt: -1 })
    .toArray()
);

print("\n=== QUERY 2: NESTED FIELD LOOKUP (bookingRef.booking_id = 33333333-3333-4333-8333-000000003001) ===");
printjson(
  targetDb.folio_audit_events
    .find(
      { "bookingRef.booking_id": "33333333-3333-4333-8333-000000003001" },
      { _id: 1, eventCategory: 1, recordedAt: 1, "guestSnapshot.full_name": 1, "roomSnapshot.room_code": 1 }
    )
    .sort({ recordedAt: 1 })
    .toArray()
);

print("\n=== QUERY 3: DATE RANGE FILTER (OCTOBER 2026 EVENTS) ===");
printjson(
  targetDb.folio_audit_events
    .find(
      {
        recordedAt: {
          $gte: ISODate("2026-10-01T00:00:00Z"),
          $lt: ISODate("2026-11-01T00:00:00Z")
        }
      },
      { _id: 1, eventCategory: 1, recordedAt: 1, "roomSnapshot.wing_name": 1 }
    )
    .sort({ recordedAt: 1 })
    .toArray()
);

print("\n=== QUERY 4: AGGREGATION BY EVENT CATEGORY ===");
printjson(
  targetDb.folio_audit_events
    .aggregate([
      {
        $group: {
          _id: "$eventCategory",
          eventCount: { $sum: 1 },
          earliestEvent: { $min: "$recordedAt" },
          latestEvent: { $max: "$recordedAt" },
          totalCapturedAmount: {
            $sum: { $ifNull: ["$payload.amount_paid", 0] }
          }
        }
      },
      { $sort: { eventCount: -1, _id: 1 } }
    ])
    .toArray()
);

print("\n=== NEGATIVE TEST 1: SCHEMA VALIDATION FAILURE (STRING recordedAt) ===");
try {
  targetDb.folio_audit_events.insertOne({
    _id: "evt_invalid_date_type",
    eventCategory: "booking_checked_in",
    recordedAt: "2026-10-12-not-a-date",
    bookingRef: { booking_id: "33333333-3333-4333-8333-000000003004", booking_state: "confirmed" },
    guestSnapshot: { guest_id: "11111111-1111-4111-8111-000000001004", full_name: "Amina Bello", loyalty_tier: "standard" },
    roomSnapshot: { room_id: "22222222-2222-4222-8222-000000002004", room_code: "C-401", wing_name: "ambassador_wing" },
    payload: { note: "Should fail schema validation" }
  });
} catch (err) {
  print("Expected Validation Error Code: " + err.code + " | Message: " + err.message);
}

print("\n=== NEGATIVE TEST 2: DUPLICATE _id FAILURE ===");
try {
  targetDb.folio_audit_events.insertOne({
    _id: "evt_2026_3001_checkin",
    eventCategory: "booking_checked_in",
    recordedAt: ISODate("2026-10-10T13:10:00Z"),
    bookingRef: { booking_id: "33333333-3333-4333-8333-000000003001", booking_state: "checked_in" },
    guestSnapshot: { guest_id: "11111111-1111-4111-8111-000000001001", full_name: "Tunde Adebayo", loyalty_tier: "gold" },
    roomSnapshot: { room_id: "22222222-2222-4222-8222-000000002001", room_code: "A-101", wing_name: "savannah_wing" },
    payload: { note: "Duplicate primary key test" }
  });
} catch (err) {
  print("Expected Duplicate Key Error Code: " + err.code + " | Message: " + err.message);
}

print("\n=== FINAL COLLECTION COUNT ===");
printjson({ totalValidDocuments: targetDb.folio_audit_events.countDocuments() });
