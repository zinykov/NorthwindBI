# ⚠️ Limitations

This document outlines the known limitations of the Northwind Enterprise Data Platform.  
These constraints reflect architectural choices, dataset characteristics, and the educational nature of the project.  
They help set realistic expectations for development, testing, and AI‑assisted code generation.

---

## 1. Dataset Limitations

### 1.1 Northwind Is a Synthetic Dataset
- Not representative of real enterprise data volumes.  
- Lacks complex business rules found in production systems.  
- Contains simplified relationships and limited attribute depth.

### 1.2 Limited Data Variety
- No streaming data.  
- No semi‑structured or unstructured data.  
- No multi‑source integration beyond MDS and simulated inputs.

### 1.3 Static Business Model
- No evolving business processes.  
- No seasonal patterns or realistic time‑series behavior.  
- No real customer lifecycle or churn dynamics.

---

## 2. Architectural Limitations

### 2.1 Single‑Server SQL Architecture
- No distributed compute.  
- No cloud‑native components.  
- No horizontal scaling.

### 2.2 Simplified Security Model
- No row‑level security in the database layer.  
- No enterprise‑grade authentication/authorization.  
- No encryption at rest or in transit (beyond defaults).

### 2.3 Simplified DevOps
- No automated CI/CD pipelines.  
- No environment promotion workflows.  
- No automated rollback or drift detection.

---

## 3. ETL Limitations

### 3.1 Hybrid SSIS + T‑SQL Approach
- SSIS packages are not parameterized for multi‑environment deployment.  
- No orchestration engine (e.g., ADF, Airflow).  
- No retry logic or advanced error recovery.

### 3.2 Limited Error Handling
- Errors are logged but not automatically remediated.  
- No automated alerting or monitoring.  
- No dead‑letter queues.

### 3.3 Staging Lifecycle
- Staging tables are recreated per load but not optimized for concurrency.  
- No incremental load patterns beyond change detection.

---

## 4. Modeling Limitations

### 4.1 SCD2 Only
- No support for SCD1 or SCD3.  
- No hybrid SCD patterns.  
- No attribute‑level change tracking.

### 4.2 Single Fact Table
- Only one major fact (`Fact.Order`).  
- No snapshot facts.  
- No accumulating snapshot facts.

### 4.3 Limited Conformed Dimensions
- Only Customer, Product, Employee, Date are conformed.  
- No enterprise‑wide conformance model.

---

## 5. Performance Limitations

### 5.1 Partitioning Strategy
- Partitioning only on `OrderDateKey`.  
- No automated partition sliding window.  
- No partition‑level statistics maintenance.

### 5.2 Compression Strategy
- ARCHIVE compression may reduce query performance.  
- No adaptive compression strategy based on data temperature.

### 5.3 Columnstore Constraints
- No rowgroup health monitoring.  
- No automated index rebuild/reorganize logic.

---

## 6. Semantic Layer Limitations

### 6.1 Power BI Only
- No SSAS Tabular or Multidimensional.  
- No semantic model versioning.  
- No enterprise‑grade RLS implementation.

### 6.2 Limited DAX Patterns
- Basic Time Intelligence only.  
- No advanced analytical models