## Architecture Recommendation

For a fast-growing food delivery startup that collects GPS location logs, customer text reviews, payment transactions, and restaurant menu images, I would recommend a **Data Lakehouse** architecture.

A Data Lakehouse combines the best of both a Data Lake and a Data Warehouse. Here are three specific reasons why it is the right choice for this startup:

**1. The data is fundamentally multi-format and cannot fit a single warehouse schema.**
GPS logs are structured time-series data. Payment transactions are structured relational records. Customer text reviews are unstructured text. Restaurant menu images are binary files. A traditional Data Warehouse (like Redshift or BigQuery) is designed for structured, pre-defined schemas only — it cannot natively store images or raw text reviews. A pure Data Lake would store everything but would make it difficult to run fast, reliable SQL analytics on the payment data. A Lakehouse (using platforms like Databricks or Apache Iceberg on cloud storage) handles all formats in one place, allowing the startup to store raw images in object storage while running structured queries on transactions in the same system.

**2. The startup needs both real-time analytics and batch ML — simultaneously.**
Food delivery businesses make time-sensitive decisions: surge pricing, delivery partner allocation, and fraud detection all need near real-time data. At the same time, training machine learning models on customer reviews for sentiment analysis or GPS logs for route optimization requires large-scale batch processing. A Data Lakehouse supports both workloads through a unified storage layer. A Data Warehouse alone cannot handle ML pipelines on unstructured data, and a pure Data Lake lacks the query performance needed for operational dashboards.

**3. The startup is growing fast and needs a schema-flexible, cost-effective storage tier.**
A Lakehouse stores raw data cheaply in cloud object storage (like S3 or GCS) without requiring upfront schema definitions. As the business evolves — adding new cities, new restaurant categories, new features — the data model can evolve without costly migrations. This agility is critical for early-stage startups where data requirements change rapidly.

In summary, the Lakehouse architecture provides the storage flexibility of a Data Lake, the query reliability of a Data Warehouse, and the ML-readiness needed for a modern AI-driven food delivery platform.