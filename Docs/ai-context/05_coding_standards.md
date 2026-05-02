# 🧩 Coding Standards

This document defines the coding standards for SQL, SSIS, and ETL development within the Northwind Enterprise Data Platform.  
These standards ensure consistency, readability, maintainability, and predictable behavior for both developers and AI‑assisted tooling.

---

## 1. General Principles

- Code must be **readable**, **consistent**, and **self‑documenting**.
- Prefer **explicitness** over cleverness.
- Avoid unnecessary complexity.
- Follow **Kimball‑aligned** modeling and ETL patterns.
- All code must be **idempotent** where possible.
- All ETL logic must be **auditable** via `LineageKey`.

---

## 2. SQL Coding Standards

### 2.1 Formatting

- Use **PascalCase** for object names.
- Use **UPPERCASE** for SQL keywords.
- Indent using **4 spaces**, no tabs.
- Align JOIN and WHERE clauses vertically.
- Place commas **at the end of lines**, not the beginning.

Example:

```sql
SELECT
    CustomerKey,
    Customer,
    Country
FROM Dimension.Customer
WHERE Current = 1;
```
### 2.2 Stored Procedure Structure

All stored procedures must follow this structure:
1. Header comment
    - Purpose
    - Author
    - Dependencies
    - Expected inputs/outputs
2. SET options
    - `SET NOCOUNT ON;`
    - `SET XACT_ABORT ON;`
3. Transaction block (if needed)
    - Main logic
    - Error handling (TRY/CATCH)
    - Return code

### 2.3 Naming Conventions
- Procedures: `<Verb><Entity><Action>`  
Example: `UpdateCustomerChangingAttributes`

- Variables: `@PascalCase`  
Example: `@LoadDate`, `@LineageKey`

- Temporary tables: `#Temp<Entity>`  
Example: `#TempCustomer`

- Table aliases: short, meaningful  
Example: `c` for `Customer`, `o` for `Order`

### 2.4 SCD2 Coding Standards

- Always compare using `AllAttributes`.
- Always close previous version before inserting a new one.
- Always set:
    - StartDate
    - EndDate
    - Current
    - LineageKey
- Use MERGE only when safe; otherwise use explicit UPDATE + INSERT.

### 2.5 Fact Load Standards
- Resolve all FK lookups before inserting.
- Use Unknown members when lookup fails.
- Calculate measures explicitly.
- Maintain partition alignment.
- Never update fact rows except lineage metadata.

---

## 3. SSIS Coding Standards

### 3.1 Package Naming
Format:
```
Load <Entity>.dtsx
```
Examples:
- `Load Dim Customers.dtsx`
- `Load Fact Orders.dtsx`

### 3.2 Data Flow Standards

- Use descriptive names for components.
- Use Lookup transformations for surrogate key resolution.
- Use Conditional Split for SCD2 routing.
- Use Derived Column for:
    - Type conversions
    - Metadata fields
    - AllAttributes construction
- Redirect errors to error outputs with full metadata.

### 3.3 Logging and Auditing

- Capture row counts for:
    - Input
    - Inserted
    - Updated
    - Rejected
- Log errors with:
    - Source component
    - Column lineage
    - Error description
    - LineageKey

---

## 4. Staging Layer Standards
### 4.1 Load Table Creation

- Use dedicated procedures:
    - `CreateLoadTable<Entity>`
    - `DropLoadTable<Entity>`
- Load tables must:
    - Match DWH structure
    - Use appropriate data types
    - Include metadata fields

### 4.2 Cleanup
- Always drop or truncate staging tables after use.
- Never leave temporary objects in the database.

## 5. Lineage Standards
- Every ETL cycle must request a new LineageKey via GetLineageKey.
- All dimension and fact rows must store the lineage of the load that created or updated them.
- Lineage must be propagated through all layers.

---

## 6. Error Handling Standards
### 6.1 SQL Error Handling
Use TRY/CATCH:
```sql
BEGIN TRY
    -- logic
END TRY
BEGIN CATCH
    -- log error
    THROW;
END CATCH;
```

### 6.2 SSIS Error Handling
- Use error outputs for all critical transformations.
- Store rejected rows in Integration error tables.
- Include:
    - ErrorCode
    - ErrorColumn
    - ErrorDescription
    - LineageKey

---

## 7. Performance Standards
- Use **Clustered Columnstore Index** for large fact tables.
- Use **PAGE compression** for dimensions.
- Use **ARCHIVE compression** for historical partitions.
- Avoid scalar functions in SELECT.
- Avoid cursors; use set‑based logic.
- Use partition‑aligned indexes.

## 8. Code Review Standards
Every change must be reviewed for:
- Correctness
- Consistency with naming conventions
- SCD2 compliance
- Performance impact
- Lineage propagation
- Error handling completeness

## 9. Summary

These coding standards ensure:

- High‑quality, maintainable SQL and SSIS code
- Consistent SCD2 and fact load behavior
- Predictable ETL execution
- Full auditability via lineage
- AI‑friendly structure for GitHub Copilot

They form the foundation for reliable and scalable development within the Northwind EDP.