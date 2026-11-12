# MIT 8103 Advanced Database Systems Portfolio

- **Student Name:** Akolo Kutsa
- **Student ID:** 301919193
- **Submission Prefix:** `Kutsa_Akolo_301919193`
- **Selected Case Study:** Crestview Hospitality ERP (Hotel ERP System)
- **Repository URL:** https://github.com/Ephraim-Akolo/Kutsa_Akolo_301919193

---

## 1. Case Study Overview

**Crestview Hospitality ERP** is an enterprise resource planning database designed for hotel front-desk receptionists, finance and billing clerks, and property operations managers. The system combines:
1. **PostgreSQL 17 (`erp` schema):** Four normalised 3NF tables (`guest_account`, `room_unit`, `stay_booking`, and `folio_payment`) using native `uuid` primary and foreign keys (`DEFAULT gen_random_uuid()`) and bounded `varchar(n)` columns for transactional booking, room inventory, and billing records.
2. **MongoDB 8 (`hotel_erp_nosql` database):** A schema-validated document collection (`folio_audit_events`) for append-only operational and payment audit events.

---

## 2. Repository Structure

```text
Kutsa_Akolo_301919193/
├── README.md
├── Kutsa_Akolo_301919193_README.txt
├── Kutsa_Akolo_301919193_FinalSummary.pdf
├── portfolio-1-database-design/
│   ├── Kutsa_Akolo_301919193_P1_Documentation.pdf
│   ├── Kutsa_Akolo_301919193_P1_Schema.sql
│   ├── Kutsa_Akolo_301919193_P1_SampleData.sql
│   ├── Kutsa_Akolo_301919193_P1_ConstraintTests.sql
│   └── screenshots/
│       ├── Kutsa_Akolo_301919193_P1_ERDiagram.png
│       └── Kutsa_Akolo_301919193_P1_DatabaseResults.png
├── portfolio-2-query-optimisation/
│   ├── Kutsa_Akolo_301919193_P2_Documentation.pdf
│   ├── Kutsa_Akolo_301919193_P2_Queries.sql
│   ├── Kutsa_Akolo_301919193_P2_Optimisation.sql
│   └── screenshots/
│       ├── Kutsa_Akolo_301919193_P2_QueryResults.png
│       └── Kutsa_Akolo_301919193_P2_IndexComparison.png
├── portfolio-3-transactions-concurrency/
│   ├── Kutsa_Akolo_301919193_P3_Documentation.pdf
│   ├── Kutsa_Akolo_301919193_P3_Transactions.sql
│   ├── Kutsa_Akolo_301919193_P3_SessionA.sql
│   ├── Kutsa_Akolo_301919193_P3_SessionB.sql
│   └── screenshots/
│       ├── Kutsa_Akolo_301919193_P3_CommitRollback.png
│       └── Kutsa_Akolo_301919193_P3_ConcurrencyResult.png
├── portfolio-4-nosql/
│   ├── Kutsa_Akolo_301919193_P4_Documentation.pdf
│   ├── Kutsa_Akolo_301919193_P4_MongoDB.js
│   └── screenshots/
│       └── Kutsa_Akolo_301919193_P4_DocumentsAndQueries.png
└── portfolio-5-distributed-cloud/
    ├── Kutsa_Akolo_301919193_P5_Documentation.pdf
    └── screenshots/
        └── Kutsa_Akolo_301919193_P5_ProposedDesign.png
```

---

## 3. Execution Instructions

### Portfolio 1: Database Design and Modelling
```bash
psql -U postgres -d hotel_erp_db -f portfolio-1-database-design/Kutsa_Akolo_301919193_P1_Schema.sql
psql -U postgres -d hotel_erp_db -f portfolio-1-database-design/Kutsa_Akolo_301919193_P1_SampleData.sql
psql -U postgres -d hotel_erp_db -f portfolio-1-database-design/Kutsa_Akolo_301919193_P1_ConstraintTests.sql
```

### Portfolio 2: Query Processing and Optimisation
```bash
psql -U postgres -d hotel_erp_db -f portfolio-2-query-optimisation/Kutsa_Akolo_301919193_P2_Queries.sql
psql -U postgres -d hotel_erp_db -f portfolio-2-query-optimisation/Kutsa_Akolo_301919193_P2_Optimisation.sql
```

### Portfolio 3: Transactions and Concurrency
```bash
psql -U postgres -d hotel_erp_db -f portfolio-3-transactions-concurrency/Kutsa_Akolo_301919193_P3_Transactions.sql
```

### Portfolio 4: NoSQL and Advanced Data Models
```bash
mongosh --quiet portfolio-4-nosql/Kutsa_Akolo_301919193_P4_MongoDB.js
```
