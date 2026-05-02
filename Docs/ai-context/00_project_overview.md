# 🏛️ Northwind Enterprise Data Platform — Project Overview

## 1. Purpose of the Project
Northwind EDP is a learning‑oriented but architecturally complete Enterprise Data Warehouse designed to practice:

- **Ralph Kimball methodology** (star schema, SCD, grain definition, surrogate keys)
- **Microsoft SQL Server engineering practices** (DWH, ETL, SSIS, Columnstore, Partitioning)
- Building an **end‑to‑end BI platform**:
  *Landing → Staging → DQS → MDS → DWH → Semantic Layer*
- DevOps practices: CI/CD, automated testing, maintenance, monitoring

The project simulates a real corporate DWH using the Northwind dataset.

---

## 2. Architectural Concept
The architecture follows the classical Kimball approach.

### Core Layers
1. **Landing**  
   Raw ingestion from source systems (MDS, CSV, simulated sources).  
   Minimal transformations, raw data preservation.

2. **Staging**  
   Type normalization, basic cleansing, structural alignment.  
   Pre‑processing before DQS/MDS.

3. **DQS (Data Quality Services)**  
   Data validation rules.  
   Reference data and quality checks.

4. **MDS (Master Data Services)**  
   Master data management for Customer, Product, Employee.  
   Business rules, versioning, stewardship.

5. **Integration**  
   Lineage, metadata, ETL cycle control.  
   Auditability and load tracking.

6. **DWH (Data Warehouse)**  
   - SCD2 dimensions  
   - Transaction facts  
   - Reference data  
   - Partitioning and Columnstore  
   - Dedicated filegroups for data and indexes

7. **Semantic Layer / Data Analysis**  
   - Power BI  
   - DAX models  
   - Row‑level security  
   - Time Intelligence patterns

---

## 3. Data Modeling

### Dimensions (SCD2)
- Customer  
- Product  
- Employee  
- Date  

Key characteristics:

- Surrogate keys generated via **SEQUENCE**
- Natural keys stored as **AlterKey**
- SCD2 attributes: StartDate, EndDate, Current
- `AllAttributes` used for change detection
- `LineageKey` included for auditability

### Facts
- **Fact.Order** (grain: one row per order line)
- Measures: UnitPrice, Quantity, Discount, SalesAmount
- Multiple date keys (Order, Required, Shipped)
- Partitioning by OrderDateKey
- Clustered Columnstore Index + NCI on foreign keys

---

## 4. ETL Framework
ETL is implemented using a hybrid approach:

### SSIS (Data Flow)
- MDS → DWH dimension pipelines
- DQS lookups
- Unknown member handling
- New row insertion
- SCD2 change detection
- Updated row insertion

### T‑SQL (Stored Procedures)
- SCD2 updates
- Fact loads (UPSERT)
- Staging lifecycle (create/drop load tables)
- Lineage management
- Partition maintenance

### Key Procedures
- `UpdateCustomerChangingAttributes.sql`
- `UpdateCustomerAttributesAndMetadata.sql`
- `LoadOrders.sql`
- `CreateLoadTableOrder.sql`
- `DropLoadTableOrder.sql`
- `GetLineageKey.sql`

---

## 5. Performance and Scalability
- **Partitioning** by date
- **Columnstore** for fact tables
- **PAGE compression** for dimensions
- **ARCHIVE compression** for historical partitions
- Sliding window maintenance
- Automated index and statistics management
- MCR performance testing

---

## 6. DevOps and Operations
- SQL Server Database Projects
- Automated deployment scripts
- T‑SQL unit tests
- ETL monitoring
- Lineage tracking
- Environment management (DEV/TEST/PROD)

---

## 7. Constraints and Assumptions
- Northwind is a learning dataset
- Some architectural elements are intentionally more complex
- No real SLA requirements
- Security and compliance simplified
- Data volume partially simulated

---

## 8. Purpose of the AI Context
This document is part of `/docs/ai-context` and is intended to:

- Provide GitHub Copilot with a high‑level understanding of the project
- Ensure consistent code generation
- Enable Copilot to follow the ETL framework
- Improve architectural awareness
- Support AI‑first development workflows
