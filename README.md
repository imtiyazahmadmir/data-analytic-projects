SQL_resume_project: Relational E-Commerce Architecture

An implementation portfolio focused on executing relational database design with a suite of 30 production-grade analytical business intelligence queries using **Oracle SQL**.
Contact & Developer Information
Name: [IMTIYAZ AHMAD MIR]
Email:[imtiyazahmad3143@gmail.com]

Tech Stack & Environment
Database Platform:Oracle Autonomous Database (OCI Cloud)
Execution Interface: Oracle Database Actions / SQL Developer Web Workbench
Language Specification: ANSI SQL compliance with Oracle PL/SQL extensions

Database Architecture
The system utilizes a 3-tier normalized relational schema designed with explicit primary-foreign key relationships to maintain backend data integrity:
`Books` (Inventory Entity): Tracks product unique catalog IDs, titles, authors, genres, unit prices, and stock inventory.
`Customers` (Demographic Entity): Stores customer accounts, distinct emails, and global geolocation data (`City`, `Country`).
`Orders` (Central Transactional Ledger): A high-throughput bridge table linking customer purchase patterns with live inventory metrics, tracking timestamps (`Order_Date`), physical counts (`Quantity`), and computed values (`Total_Amount`).

Analytical Capabilities (Business Intelligence Showcase)
This project features a suite of 30 targeted database queries designed to simulate enterprise-level operational tracking and behavioral analytics:

Drop-off Analysis (Cohort Segmentation): Utilized custom `LEFT JOIN` layouts filtering out missing records (`WHERE foreign_key IS NULL`) to systematically isolate inactive customer segments.
High-Yield Aggregations: Applied multi-level `GROUP BY` configurations paired with post-aggregation data filters (`HAVING`) to isolate high-value VIP customer blocks based on transactional frequencies.
Window / Analytic Functions: Leveraged `ROW_NUMBER() OVER(PARTITION BY...)` to partition regional datasets and extract localized sales revenue leaders within separate countries.
Cumulative Financial Ledgers: Formulated chronological rolling calculations (`SUM() OVER`) to display continuous running revenue growth.
Dense Ranking Operations: Applied `DENSE_RANK()` sorting matrices to eliminate ranking gaps during product inventory pricing ties.

 Repository Directory Structure
