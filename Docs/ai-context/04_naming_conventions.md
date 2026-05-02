# 🏷️ Naming Conventions

This document defines the naming conventions used across the Northwind Enterprise Data Platform.  
Consistent naming ensures clarity, maintainability, and predictable behavior for both developers and AI‑assisted tooling.

---

## 1. General Rules

- Names must be **PascalCase** (e.g., `CustomerKey`, `LoadOrders`).
- Avoid abbreviations unless industry‑standard.
- Use **singular** names for tables (e.g., `Customer`, not `Customers`).
- Use **schema‑based classification** instead of prefixes (e.g., `[Dimension].[Customer]`, not `DimCustomer`).
- Use **descriptive, business‑meaningful names** for all objects.

---

## 2. Schema Naming

| Schema        | Purpose |
|---------------|---------|
| `Landing`     | Raw ingestion tables |
| `Staging`     | Normalized staging tables |
| `DQS`         | Data Quality Services staging |
| `MDS`         | Master Data Services entities |
| `Integration` | Lineage, metadata, ETL control |
| `Dimension`   | SCD2 dimensions |
| `Fact`        | Transaction fact tables |
| `Reference`   | Reference and lookup tables |

---

## 3. Table Naming

### 3.1 Dimensions
Format:
```
[Dimension].[<Entity>]
```

Examples:
- `[Dimension].[Customer]`
- `[Dimension].[Product]`
- `[Dimension].[Employee]`
- `[Dimension].[Date]`

### 3.2 Facts
Format:
```
[Fact].[<BusinessProcess>]
```

Examples:
- `[Fact].[Order]` (grain: order line)

### 3.3 Reference Tables
Format:
```
[Reference].[<Entity>]
```

### 3.4 Integration Tables
Format:
```
[Integration].[<Entity>]
```

Examples:
- `[Integration].[Lineage]`
- `[Integration].[ErrorLog]`

---

## 4. Column Naming

### 4.1 Surrogate Keys
Format:
```
<Entity>Key
```

Examples:
- `CustomerKey`
- `ProductKey`
- `EmployeeKey`
- `OrderKey`

Rules:
- Dimensions → BIGINT  
- Facts → INT (fact surrogate key), BIGINT for FK references  
- Generated via SQL Server **SEQUENCE**

### 4.2 Natural Keys
Format:
```
<Entity>AlterKey
```

Examples:
- `CustomerAlterKey`
- `ProductAlterKey`

### 4.3 Date Keys
- Type: **DATE**
- Name: `<Role>DateKey`

Examples:
- `OrderDateKey`
- `RequiredDateKey`
- `ShippedDateKey`

### 4.4 SCD2 Columns
- `StartDate`
- `EndDate`
- `Current` (BIT)
- `AllAttributes` (NVARCHAR(MAX))

### 4.5 Lineage Columns
- `LineageKey` (BIGINT)
- FK to `[Integration].[Lineage]`

---

## 5. Index Naming

### 5.1 Primary Keys
Format:
```
PK_<Schema>_<Table>
```

Example:
```
PK_Dimension_Customer
```

### 5.2 Foreign Keys
Format:
```
FK_<Schema><Table><Column><ReferencedSchema><ReferencedTable>
```

Example:
```
FK_Fact_Order_Customer_Key_Dimension_Customer
```

### 5.3 Nonclustered Indexes
Format:
```
IX_<Schema><Table><ColumnList>
```

Examples:
- `IX_Dimension_Customer_Alter_Key`
- `IX_Fact_Order_Order_Date_Key`
- `IX_Fact_Order_Product_Key`

---

## 6. Filegroup Naming

### 6.1 Dimensions
- `Dimention_Data`
- `Dimention_Index`

*(Note: spelling preserved intentionally to match existing repository.)*

### 6.2 Facts (Partitioned)
- `PS_Order_Date_Data`
- `PS_Order_Date_Index`

---

## 7. Stored Procedure Naming

### 7.1 ETL Procedures
Format:
```
<Verb><Entity><Action>
```

Examples:
- `LoadOrders`
- `UpdateCustomerChangingAttributes`
- `UpdateCustomerAttributesAndMetadata`
- `CreateLoadTableOrder`
- `DropLoadTableOrder`
- `GetLineageKey`

### 7.2 Landing Procedures
Format:
```
CheckChanged<Entity>
DropPrimaryKey<Entity>
```

Examples:
- `CheckChangedCustomers`
- `DropPrimaryKeyOrders`

---

## 8. SSIS Package Naming

Format:
```
Load <Entity>.dtsx
```

Examples:
- `Load Dim Customers.dtsx`
- `Load Dim Employees.dtsx`
- `Load Fact Orders.dtsx`

---

## 9. File Naming (Documentation)

Format:
```
NN_<topic>.md
```

Examples:
- `00_project_overview.md`
- `01_data_model_summary.md`
- `02_etl_pipeline.md`
- `03_transformation_rules.md`
- `04_naming_conventions.md`

---

## 10. Summary

These naming conventions ensure:

- Consistency across all layers  
- Predictable object discovery  
- Clean integration with SSIS and T‑SQL  
- Clear lineage and auditability  
- AI‑friendly structure for GitHub Copilot  

They form the foundation for maintainable, scalable, and automated development within the Northwind EDP.