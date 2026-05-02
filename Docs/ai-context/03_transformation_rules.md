# 🔧 Transformation Rules

This document defines the transformation rules used across the Northwind Enterprise Data Platform.  
It describes how data is validated, standardized, enriched, conformed, historized, and loaded into the DWH.  
These rules ensure consistency across SSIS pipelines, T‑SQL stored procedures, and semantic models.

---

## 1. General Transformation Principles

All transformations follow these core principles:

- **Deterministic logic** — same input always produces the same output  
- **Idempotency** — repeated ETL runs do not create duplicates  
- **Auditability** — every transformation is traceable via `LineageKey`  
- **Minimal staging** — staging layer performs only essential normalization  
- **Business‑driven modeling** — transformations reflect business semantics  
- **Kimball compliance** — conformed dimensions, SCD2, grain consistency  

---

## 2. Landing → Staging Transformations

### 2.1 Type Normalization
- Convert source types to SQL Server canonical types  
- Trim strings, normalize whitespace  
- Convert empty strings to NULL  
- Standardize date formats to `DATE` or `DATETIME2`  

### 2.2 Structural Alignment
- Align column names with staging schema  
- Add missing technical fields (LoadDate, SourceSystem, etc.)  
- Validate mandatory fields  

### 2.3 Basic Data Quality Rules
- Remove invalid dates  
- Validate numeric ranges  
- Enforce primary key uniqueness (via temporary constraints)  

---

## 3. Staging → DQS Transformations

### 3.1 Data Quality Validation
- Apply DQS domain rules  
- Standardize country, city, category names  
- Validate phone number formats  
- Normalize casing (e.g., Title Case for names)  

### 3.2 Error Routing
- Invalid rows → DQS error tables  
- Valid rows → MDS or Integration layer  

---

## 4. MDS → DWH Transformations (Dimensions)

Dimensions follow a consistent **SCD2 transformation framework**.

### 4.1 Change Detection
Changes are detected using:

- `AllAttributes` snapshot (NVARCHAR(MAX))  
- Hash or concatenated attribute string  
- Comparison with existing dimension row  

### 4.2 SCD2 Rules
If attributes **did not change**:
- No new version created  
- Metadata updated if needed  

If attributes **changed**:
- Close previous version:  
  - `EndDate = LoadDate`  
  - `Current = 0`  
- Insert new version:  
  - `StartDate = LoadDate`  
  - `EndDate = NULL`  
  - `Current = 1`  

### 4.3 Unknown Member Handling
If lookup fails:
- Route to “Unknown” member  
- Insert unknown member if not present  
- Maintain consistent surrogate key  

### 4.4 Metadata and Lineage
- `LineageKey` assigned for each ETL cycle  
- Load metadata updated (LoadDate, UpdateDate)  

---

## 5. Staging → DWH Transformations (Facts)

### 5.1 Foreign Key Resolution
- Lookup surrogate keys for all dimensions  
- If lookup fails → use Unknown member  
- Ensure referential integrity  

### 5.2 Measure Calculations
Examples:

- `SalesAmount = UnitPrice * Quantity`  
- `SalesAmountWithDiscount = SalesAmount * (1 - Discount)`  

### 5.3 UPSERT Logic
- Insert new fact rows  
- Update lineage for existing rows if needed  
- Maintain partition alignment  

### 5.4 DateKey Handling
- Convert source dates to `DATE`  
- Map to `[Dimension].[Date].[DateKey]`  
- Support multiple date roles (Order, Required, Shipped)  

---

## 6. Integration Layer Transformations

### 6.1 Lineage Assignment
- Each ETL cycle receives a unique `LineageKey`  
- Stored in `[Integration].[Lineage]`  
- Used across all dimensions and facts  

### 6.2 Metadata Tracking
- Load start/end timestamps  
- Row counts (inserted, updated, rejected)  
- Error codes and messages  

---

## 7. Partitioning and Compression Rules

### 7.1 Partitioning
- Partition by `OrderDateKey` (DATE)  
- New partitions created automatically  
- Old partitions archived  

### 7.2 Compression
- Dimensions → PAGE compression  
- Facts → Columnstore  
- Historical partitions → COLUMNSTORE_ARCHIVE  

---

## 8. Error Handling and Rejection Rules

### 8.1 SSIS Error Paths
- Redirect invalid rows to error outputs  
- Capture error description and column lineage  

### 8.2 T‑SQL Validation
- Check for NULLs in mandatory fields  
- Validate FK lookups  
- Validate numeric ranges  

### 8.3 Rejected Rows
- Stored in Integration error tables  
- Include LineageKey, SourceSystem, ErrorMessage  

---

## 9. Conformance Rules

### 9.1 Conformed Dimensions
- Customer, Product, Employee, Date  
- Shared across all fact tables  
- Same surrogate key used across subject areas  

### 9.2 Naming Conventions
- Surrogate keys: `<Entity>Key`  
- Natural keys: `<Entity>AlterKey`  
- Date keys: `DATE` type  
- SCD2 fields: StartDate, EndDate, Current  

---

## 10. Summary

Transformation rules in Northwind EDP ensure:

- Consistent SCD2 behavior  
- Reliable fact loading  
- Strong data quality  
- Full lineage and auditability  
- High performance via partitioning and compression  
- Alignment with semantic models  

These rules form the backbone of the ETL framework and guide all data movement and processing across the platform.