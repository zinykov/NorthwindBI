# 📘 Data Model Summary

This document provides a structured overview of the data model used in the Northwind Enterprise Data Platform.  
It summarizes dimensions, facts, keys, grain definitions, and modeling conventions to support consistent development and AI‑assisted code generation.

---

## 1. Modeling Approach

The data model follows the **Kimball dimensional modeling methodology**, with:

- Star schema architecture  
- SCD2 dimensions  
- Transaction fact tables  
- Surrogate keys generated via SQL Server **SEQUENCE**  
- DATE‑typed DateKeys (not integer YYYYMMDD)  
- Lineage tracking for auditability  
- Partitioning and Columnstore for performance  

---

## 2. Dimensions Overview

### 2.1 Customer Dimension  
**Table:** `[Dimension].[Customer]`  
**Grain:** One row per customer version (SCD2)  
**Key Characteristics:**

- `CustomerKey` — surrogate key (BIGINT, SEQUENCE‑based)  
- `CustomerAlterKey` — natural key from source (NVARCHAR(5))  
- `AllAttributes` — snapshot used for change detection  
- SCD2 fields: `StartDate`, `EndDate`, `Current`  
- `LineageKey` — reference to ETL lineage  
- Multiple supporting attributes: ContactName, Country, City, Phone, Fax  

**Indexes:**

- NCI on `CustomerAlterKey` (includes SCD2 fields)  
- NCI on `Customer`  
- NCI on `(Country, City)`  
- PAGE compression  

---

### 2.2 Product Dimension  
**Table:** `[Dimension].[Product]`  
**Grain:** One row per product version (SCD2)  
**Characteristics:**  
- Surrogate key via SEQUENCE  
- Natural key from source  
- SCD2 attributes  
- Product metadata (category, supplier, etc.)  
- Lineage tracking  

*(Structure inferred; exact attributes defined in repository.)*

---

### 2.3 Employee Dimension  
**Table:** `[Dimension].[Employee]`  
**Grain:** One row per employee version (SCD2)  
**Characteristics:**  
- Surrogate key via SEQUENCE  
- Natural key from source  
- SCD2 attributes  
- Organizational metadata  
- Lineage tracking  

*(Structure inferred; exact attributes defined in repository.)*

---

### 2.4 Date Dimension  
**Table:** `[Dimension].[Date]`  
**Grain:** One row per calendar date  
**Characteristics:**  
- `DateKey` is of type **DATE**  
- Calendar attributes: Year, Month, Quarter, Week, DayOfWeek  
- Flags: IsWeekend, IsHoliday, IsWorkday  
- Supports Time Intelligence patterns  

---

## 3. Fact Tables Overview

### 3.1 Fact.Order  
**Table:** `[Fact].[Order]`  
**Grain:** One row per **order line**  
**Foreign Keys:**

- `ProductKey` → Dimension.Product  
- `CustomerKey` → Dimension.Customer  
- `EmployeeKey` → Dimension.Employee  
- `OrderDateKey` → Dimension.Date  
- `RequiredDateKey` → Dimension.Date  
- `ShippedDateKey` → Dimension.Date  
- `LineageKey` → Integration.Lineage  

**Measures:**

- `UnitPrice`  
- `Quantity`  
- `Discount`  
- `SalesAmount`  
- `SalesAmountWithDiscount`  

**Performance Features:**

- Clustered Columnstore Index  
- Partitioning on `OrderDateKey`  
- ARCHIVE compression for old partitions  
- PAGE compression for NCI  
- NCI on all FK columns  

---

## 4. Keys and Conventions

### 4.1 Surrogate Keys  
- All dimensions use surrogate keys generated via SQL Server **SEQUENCE**.  
- Naming convention: `<Entity>Key` (e.g., `CustomerKey`, `ProductKey`).  
- Type: BIGINT for dimensions, INT for fact table keys.

### 4.2 Natural Keys  
- Stored as `<Entity>AlterKey` (e.g., `CustomerAlterKey`).  
- Used for SCD2 change detection and source alignment.

### 4.3 Date Keys  
- Type: **DATE**  
- Used directly as FK to `[Dimension].[Date].[DateKey]`.

### 4.4 Lineage Keys  
- All fact and dimension tables include `LineageKey`.  
- References `[Integration].[Lineage]`.  
- Ensures auditability and reproducibility of ETL cycles.

---

## 5. SCD2 Framework

Dimensions follow a consistent SCD2 pattern:

- Detect changes via `AllAttributes` snapshot  
- Close previous version (`EndDate`, `Current = 0`)  
- Insert new version (`StartDate = load date`, `Current = 1`)  
- Maintain metadata and lineage  
- Support unknown members  

SSIS handles detection and routing; T‑SQL procedures finalize updates.

---

## 6. Partitioning Strategy

Partitioning is applied to large fact tables:

- Partition key