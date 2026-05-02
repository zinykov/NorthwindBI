# 🔄 ETL Pipeline Overview

This document describes the end‑to‑end ETL pipeline of the Northwind Enterprise Data Platform.  
It outlines the flow of data across layers, the hybrid SSIS + T‑SQL architecture, key stored procedures, lineage tracking, and operational patterns.

---

## 1. ETL Architecture Summary

The ETL pipeline follows a **layered, modular, and auditable** design:

```
Source Systems → Landing → Staging → DQS → MDS → Integration → DWH → Semantic Layer
```


Two technologies are used together:

- **SSIS** for data movement, lookups, branching, and orchestration  
- **T‑SQL stored procedures** for SCD2 logic, fact loads, staging lifecycle, lineage, and partition maintenance  

This hybrid approach provides both flexibility and performance.

---

## 2. Data Flow Across Layers

### 2.1 Landing Layer
- Raw ingestion from MDS, CSV, or simulated sources  
- Minimal transformations  
- Primary purpose: preserve source fidelity  

### 2.2 Staging Layer
- Type normalization  
- Basic cleansing  
- Structural alignment  
- Preparation for DQS/MDS validation  

### 2.3 DQS Layer
- Data quality checks  
- Validation rules  
- Standardization of reference values  

### 2.4 MDS Layer
- Master data management  
- Business rules and stewardship  
- Versioned entities (Customer, Product, Employee)  

### 2.5 Integration Layer
- Lineage tracking  
- Metadata management  
- ETL cycle control  
- Load auditing  

### 2.6 DWH Layer
- SCD2 dimensions  
- Transaction facts  
- Partitioned and columnstore‑optimized tables  
- Reference data  

---

## 3. SSIS Pipelines

SSIS packages implement the **data flow logic** for dimensions and facts.

### Example: *Load Dim Customers.dtsx*
Key components:

- **MDS Source**  
- **Data type normalization**  
- **DQS lookup**  
- **Lookup against existing dimension**  
- **Split unknown member**  
- **Insert new customers**  
- **Detect historical attribute changes**  
- **Update changing attributes (SCD2)**  
- **Insert updated rows**  
- **No‑change path**  

SSIS handles orchestration and routing; T‑SQL procedures finalize updates.

---

## 4. T‑SQL ETL Procedures

Stored procedures implement the **core business logic** of the ETL framework.

### 4.1 SCD2 Updates  
Examples:  
- `UpdateCustomerChangingAttributes.sql`  
- `UpdateCustomerAttributesAndMetadata.sql`  

Responsibilities:

- Compare `AllAttributes` snapshot  
- Detect attribute changes  
- Close previous version (`EndDate`, `Current = 0`)  
- Insert new version (`StartDate`, `Current = 1`)  
- Maintain lineage and metadata  

---

### 4.2 Fact Loads (UPSERT)  
Example:  
- `LoadOrders.sql`  

Responsibilities:

- Prepare staging data  
- Resolve foreign keys  
- Calculate measures (SalesAmount, Discount)  
- Insert new fact rows  
- Update lineage  
- Maintain partition alignment  

---

### 4.3 Staging Lifecycle  
Examples:  
- `CreateLoadTableOrder.sql`  
- `DropLoadTableOrder.sql`  
- `TruncateLanding.sql`  

Responsibilities:

- Create temporary load tables  
- Drop or truncate staging objects  
- Ensure clean ETL cycles  

---

### 4.4 Lineage Framework  
Example:  
- `GetLineageKey.sql`  

Responsibilities:

- Generate a unique lineage identifier per ETL cycle  
- Track data provenance  
- Support auditability and reproducibility  

---

## 5. Partitioning and Performance

Partitioning is applied to large fact tables:

- Partition key: `OrderDateKey` (DATE)  
- Filegroups:  
  - `PS_Order_Date_Data`  
  - `PS_Order_Date_Index`  
- Compression strategy:  
  - Recent partitions → COLUMNSTORE  
  - Historical partitions → COLUMNSTORE_ARCHIVE  

ETL procedures maintain partition health via:

- Sliding window operations  
- Partition‑aligned indexes  
- Automated cleanup  

---

## 6. Error Handling and Logging

The ETL pipeline includes:

- Lineage‑based auditing  
- SSIS error paths  
- Logging of rejected rows  
- Metadata tracking in Integration schema  
- Consistent error codes and messages  

This ensures traceability and simplifies troubleshooting.

---

## 7. Scheduling and Orchestration

ETL execution is orchestrated via:

- SQL Server Agent jobs  
- SSIS package scheduling  
- Dependency‑based execution order  
- Load windows aligned with partition strategy  

---

## 8. Summary

The ETL pipeline of Northwind EDP is:

- **Hybrid** (SSIS + T‑SQL)  
- **Layered** (Landing → Staging → DQS → MDS → Integration → DWH)  
- **Auditable** (lineage tracking)  
- **Scalable** (partitioning + columnstore)  
- **Consistent** (SCD2 framework, naming conventions)  

This document provides the structural foundation for AI‑assisted ETL development and ensures consistent implementation across the project.