## Storage Systems

The hospital network has four distinct goals, each requiring a different storage technology:

**Goal 1 — Predict patient readmission risk (ML on historical data)**
For this goal, I chose a **Data Lakehouse** (Apache Iceberg on cloud object storage such as AWS S3, with Spark for processing). Historical treatment data — diagnoses, medications, lab results, discharge summaries — accumulates in large volumes over years. A Lakehouse allows raw historical records to be stored cheaply while enabling large-scale batch ML training jobs to run directly on that data without moving it to a separate system. The trained model is then served via an ML platform such as SageMaker or Databricks MLflow.

**Goal 2 — Allow doctors to query patient history in plain English**
For this goal, I chose a **Vector Database** (such as Pinecone or Weaviate) combined with a large language model. Patient history records — clinical notes, discharge summaries, doctor observations — are converted into vector embeddings and stored in the vector DB. When a doctor asks "Has this patient had a cardiac event before?", the question is also embedded and a similarity search retrieves the most relevant records. The LLM then summarizes the result in plain English. This is a Retrieval-Augmented Generation (RAG) architecture.

**Goal 3 — Generate monthly management reports (bed occupancy, department costs)**
For this goal, I chose an **OLAP Data Warehouse** (such as Google BigQuery or Amazon Redshift). Management reports require fast aggregations over structured, clean data — total beds used per month, cost per department, average length of stay. These are classic analytical queries that a columnar data warehouse handles extremely efficiently. Data is loaded from the OLTP system into the warehouse nightly via an ETL pipeline.

**Goal 4 — Stream and store real-time ICU vitals**
For this goal, I chose a **Time-Series Database** (such as InfluxDB or TimescaleDB) combined with a streaming layer (Apache Kafka). ICU devices emit vitals (heart rate, blood pressure, oxygen levels) every few seconds. A time-series database is purpose-built for this type of data — it handles high write throughput, compresses time-stamped data efficiently, and supports alerting queries like "has this patient's heart rate exceeded 120 bpm in the last 5 minutes." Kafka acts as the real-time ingestion buffer between devices and the database.

---

## OLTP vs OLAP Boundary

The transactional system (OLTP layer) covers everything that happens in real time during patient care: registrations, appointment bookings, prescriptions, billing, and ICU vital readings. This data lives in a **PostgreSQL relational database** (for structured patient records) and **InfluxDB** (for vitals). These systems are optimized for fast, row-level reads and writes — a doctor looking up one patient's record, a nurse recording a medication. They are not designed for running reports across millions of records.

The analytical system (OLAP layer) begins where reporting and intelligence are needed. Nightly or hourly ETL jobs extract data from the OLTP databases, clean and transform it, and load it into the **Data Warehouse (BigQuery/Redshift)**. The Data Lakehouse also receives historical dumps for ML training. The boundary is clear: operational data flows into OLTP first; analytics and reporting draw from OLAP. The two systems are never queried simultaneously for the same workload.

---

## Trade-offs

The most significant trade-off in this design is **data duplication and synchronization lag**. Because data exists in the OLTP system first and is only copied to the OLAP warehouse on a scheduled basis (e.g., every hour or nightly), management reports will always reflect data that is slightly out of date. A bed occupancy report run at 2pm may reflect the state from 1am.

To mitigate this, the ETL pipeline can be replaced with a **Change Data Capture (CDC)** tool such as Debezium, which streams row-level changes from PostgreSQL to the warehouse in near real-time (seconds to minutes rather than hours). For critical metrics like real-time ICU monitoring, the time-series database (InfluxDB) bypasses the warehouse entirely and feeds dashboards directly — so clinical staff always see live vitals while management sees reports from the warehouse. This hybrid approach balances operational accuracy with analytical performance.
