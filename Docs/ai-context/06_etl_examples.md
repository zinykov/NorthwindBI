# 🔬 ETL Examples

This document provides representative ETL examples used in the Northwind Enterprise Data Platform.  
Each example includes a description, transformation logic summary, and a reference to the corresponding file in the repository.  
Full SQL code is intentionally omitted and replaced with file links to keep the AI context lightweight and maintainable.

---

## 1. SCD2 Dimension Update (Customer)

### Procedure  
`/Integration/Store Procedures/UpdateCustomerChangingAttributes.sql`

### Purpose  
Implements SCD2 logic for the Customer dimension by detecting attribute changes and creating new historical versions.

### Key Steps  
- Compare incoming row with existing dimension row using `AllAttributes`.  
- If attributes changed:  
  - Close previous version (`EndDate`, `Current = 0`).  
  - Insert new version (`StartDate`, `Current = 1`).  
- Maintain `LineageKey` for auditability.  
- Handle unknown members.  

### Used In  
- SSIS package: `Load Dim Customers.dtsx`  
- MDS → DWH pipeline  

---

## 2. SCD2 Metadata Update (Customer)

### Procedure  
`/Integration/Store Procedures/UpdateCustomerAttributesAndMetadata.sql`

### Purpose  
Updates non‑changing attributes and metadata for Customer dimension rows without creating new SCD2 versions.

### Key Steps  
- Update metadata fields (e.g., UpdateDate).  
- Refresh non‑historical attributes.  
- Preserve SCD2 versioning.  
- Maintain lineage.  

---

## 3. Fact Load (Order Lines)

### Procedure  
`/Integration/Store Procedures/LoadOrders.sql`

### Purpose  
Loads transactional order line data into the fact table `[Fact].[Order]`.

### Key Steps  
- Resolve surrogate keys for Customer, Product, Employee, and Date.  
- Calculate measures:  
  - `SalesAmount = UnitPrice * Quantity`  
  - `SalesAmountWithDiscount = SalesAmount * (1 - Discount)`  
- Insert new fact rows.  
- Maintain partition alignment on `OrderDateKey`.  
- Assign `LineageKey`.  

### Used In  
- SSIS package: `Load Fact Orders.dtsx`  

---

## 4. Staging Table Creation (Order Load)

### Procedure  
`/Integration/Store Procedures/CreateLoadTableOrder.sql`

### Purpose  
Creates a temporary load table for staging order data before fact loading.

### Key Steps  
- Create table structure matching the fact table.  
- Apply appropriate data types.  
- Include metadata fields (LoadDate, SourceSystem, LineageKey).  
- Ensure the table is isolated per ETL cycle.  

---

## 5. Staging Table Cleanup (Order Load)

### Procedure  
`/Integration/Store Procedures/DropLoadTableOrder.sql`

### Purpose  
Removes the temporary load table after the ETL cycle completes.

### Key Steps  
- Drop the load table if it exists.  
- Ensure no leftover staging objects remain.  
- Maintain idempotency for repeated ETL runs.  

---

## 6. Lineage Key Retrieval

### Procedure  
`/Integration/Store Procedures/GetLineageKey.sql`

### Purpose  
Generates a unique lineage identifier for each ETL cycle.

### Key Steps  
- Insert a new record into `[Integration].[Lineage]`.  
- Return the generated `LineageKey`.  
- Used by all dimension and fact loads.  

---

## 7. SSIS Data Flow Example (Customer Dimension)

### Package  
`/NorthwindETL/Load Dim Customers.dtsx`

### Purpose  
Implements the MDS → DWH pipeline for Customer dimension.

### Key Components  
- **MDS Source**  
- **Data Type Normalization**  
- **DQS Lookup**  
- **Lookup Against Existing Dimension**  
- **Conditional Split**:  
  - New rows  
  - Changed rows  
  - No‑change rows  
  - Unknown members  
- **Insert New Customers**  
- **Update Changing Attributes (SCD2)**  
- **Insert Updated Rows**  
- **Metadata Updates**  

### Notes  
This package demonstrates the hybrid ETL approach:  
SSIS handles routing and transformations, while T‑SQL procedures finalize SCD2 logic.

---

## 8. Landing Layer Change Detection

### Procedure  
`/NorthwindLanding/Landing/Store Procedures/CheckChangedCustomers.sql`

### Purpose  
Detects changes in source data before loading into staging.

### Key Steps  
- Compare Landing vs. previous snapshot.  
- Identify new, changed, and deleted rows.  
- Route changed rows to staging.  

---

## 9. Landing Primary Key Management

### Procedure  
`/NorthwindLanding/Landing/Store Procedures/DropPrimaryKeyCustomers.sql`

### Purpose  
Drops and recreates primary keys in Landing tables to support bulk loads.

### Key Steps  
- Drop PK before bulk insert.  
- Recreate PK after load.  
- Maintain data integrity.  

---

## 10. Summary

These ETL examples illustrate the core patterns used across the platform:

- SCD2 dimension processing  
- Fact table UPSERT logic  
- Staging lifecycle management  
- Lineage tracking  
- SSIS orchestration  
- Landing layer change detection  

Together, they form the backbone of the Northwind EDP ETL framework and provide essential context for AI‑assisted development.

