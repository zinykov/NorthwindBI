# 🏛️ Northwind Enterprise Data Platform (EDP)
**A production-grade, end-to-end Enterprise Business Intelligence ecosystem.**

---

### ✍️ About the Author
Architected and deployed a comprehensive Enterprise DWH/BI Platform by integrating disparate Microsoft stack components into a unified ecosystem. Focused on Full-cycle Automation (CI/CD, automated QA) and the practical application of Kimball Methodology to deliver high-integrity, scalable analytical solutions.

---

### 💡 Why choose this solution?

Unlike typical "flat-file" BI projects, **Northwind BI Solution** is a professional framework designed for scalability, manageability, and data integrity. It bridges the gap between raw data and executive insights by implementing a full-stack Enterprise BI lifecycle.

*   **Architected for Growth:** Built with **Partitioning** and **Columnstore** technology to handle datasets that would crush a standard SQL Server instance.
*   **Kimball Methodology at Core:** Strictly follows the **Data Warehouse Lifecycle Toolkit** (Bus Matrix, Conformed Dimensions, and SCD Type 1 & 2 management).
*   **Engineered for Professionals:** Leverages **SSAS Tabular** and **Calculation Groups** (via Tabular Editor) to eliminate measure duplication and ensure a "Single Version of Truth."
*   **Ops-Ready from Day One:** Includes built-in **Monitoring** and **Master Data Management (MDS)**, transforming a simple database into a governed analytical platform.
*   **DevOps Centric:** Designed with environment isolation (Dev/Test/Prod) and CI/CD-ready structure for automated deployments via **Azure DevOps**.

> **This is not just a dashboard — it's a scalable blueprint for modern Enterprise Business Intelligence.**

---

### 📐 Architecture & Design

#### **High-Level System Architecture**
![Main Architecture](Docs/Images/architecture_main.png)
*Full-stack BI lifecycle implementation from source to reporting layer.*

#### **Dimensional Model (DWH)**
![DWH Schema](Docs/Images/dwh_schema.png)
*Star schema design optimized for analytical query performance (Kimball Methodology).*

#### **Scalable Topology**
The solution supports various deployment scenarios, from a single-server setup to a fully distributed enterprise cluster.

<details>
<summary><b>View Enterprise Distributed Topology (Recommended)</b></summary>

![Enterprise Topology](Docs/Images/topology_distributed.png)
*Architecture designed for high availability and workload separation (Dedicated ETL, MDS, and Report Servers).*
</details>

<details>
<summary><b>View Single-Server Setup (PoC)</b></summary>

![Single Server](Docs/Images/topology_single.png)
*Cost-effective deployment for small datasets, development, and automated functional testing.*
</details>

---

### 🛠️ Tech Stack & Tools


| Layer | Technologies |
| :--- | :--- |
| **Database & DWH** | `SQL Server 2022`, `T-SQL`, `Columnstore`, `Partitioning`, `File Groups` |
| **ETL & Integration** | `SSIS (Integration Services)`, `ELT Patterns`, `MDS`, `DQS`, `SHA2 Delta Capture` |
| **Semantic & Analytics**| `SSAS Tabular`, `DAX`, `Calculation Groups`, `Tabular Editor 2/3` |
| **Reporting** | `Power BI Report Server`, `Power BI Reports`, `SSAS`, `Paginated Reports (SSRS)`, `Excel` |
| **DevOps & QA** | `Azure DevOps`, `Azure Pipelines`, `MSTest`, `SQL Unit Testing` |

---

### 🚀 Key Features & Architectural Highlights

#### **1. High-Performance Data Engineering**
*   **Scalable Storage:** Physical and logical **partitioning** leveraging **Clustered Columnstore Indexes** for sub-second query performance.
*   **Delta Capture:** Optimized **SHA2-512 hashing** mechanism to identify changed records in sources without timestamps.
*   **Hybrid ETL/ELT:** Efficient orchestration where **SSIS** handles workflow, while heavy transformations are pushed to the **T-SQL** engine.

#### **2. Advanced Quality Assurance (The "QA Gate")**
The solution features a unique **E2E Functional Testing framework** built with **MSTest**:
*   **Sandboxed Lifecycle Testing:** Automated deployment of DB/SSIS projects followed by iterative load cycles.
*   **Incremental Validation:** Simulates "time-travel" by running multiple incremental loads to verify **SCD Type 2** logic and data accumulation.
*   **Data Poisoning Resilience:** Automated testing of "dirty data" (duplicates in source) to ensure the **DQS/MDS** layer correctly filters or quarantines records.
*   **E2E Coverage:** Recent updates extended coverage to the **Extract Layer**, ensuring robust data contracts between source and DWH.

#### **3. Enterprise Semantic Layer**
*   **Centralized Truth:** Semantic layer based on **SSAS Tabular**, enforcing logic consistency across all BI tools.
*   **Calculation Groups:** Advanced use of **Tabular Editor** to implement complex analytical scenarios while eliminating "Measure Explosion."

#### **4. Data Governance & Lineage (WWI Standard)**
*   **End-to-End Traceability:** Every record is tagged with a `LineageKey`, allowing users to trace any data point back to its specific loading session.
*   **Metadata Repository:** A dedicated `Metadata` schema acting as a "Navigation Map" for both business users and IT staff.

---

### 🗺️ Project Roadmap

The project is evolving from a local BI prototype to a distributed Enterprise Data Platform. Current development is focused on:

*   **[In Progress] Semantic Layer Migration:** Transitioning the data model from Power BI Desktop to a dedicated **SSAS Tabular** instance to support multiple reporting clients and centralized measure management.
*   **[In Progress] Advanced Metadata Catalog:** Implementation of a dedicated `Metadata` schema for automated **Lineage** tracking and a Business Glossary (Data Dictionary) in Azure Wiki.
*   **[Planned] Full E2E Test Coverage:** Extending the **MSTest framework** to include the **Extract** layer, ensuring robust data contracts and automated handling of source schema changes (Schema Drift).
*   **[Planned] Data Tiering (TCO Optimization):** Automated movement of historical data partitions between high-performance SSD and cost-effective HDD storage groups.

---

### 📖 Documentation & Links
Detailed architectural decisions, schemas, and implementation guides are available here: [**Solution Architecture Document**](Docs/Solution%20Architecture%20Document.docx)

---

### 🛡️ Project Badges & CI/CD Status

#### **Project Management**
[![Board Status](https://dev.azure.com/zinykov/e6e8a805-df55-4da4-b1f8-d290e73529c6/3660f141-eb17-455f-80e6-f5580788fd8b/_apis/work/boardbadge/f3221562-8345-4080-8a57-9776d148c41b?columnOptions=1)](https://dev.azure.com/zinykov/e6e8a805-df55-4da4-b1f8-d290e73529c6/_boards/board/t/3660f141-eb17-455f-80e6-f5580788fd8b/Stories/)

#### **Deployment Status**

| CD: Databases | CD: SSIS | CD: Reports | CD: Functional ETL test |
| :--- | :--- | :--- | :--- |
| [![Databases](https://vsrm.dev.azure.com/zinykov/_apis/public/Release/badge/e6e8a805-df55-4da4-b1f8-d290e73529c6/5/11)](https://dev.azure.com/zinykov/NorthwindBI/_release?_a=releases&view=mine&definitionId=5) | [![SSIS](https://vsrm.dev.azure.com/zinykov/_apis/public/Release/badge/e6e8a805-df55-4da4-b1f8-d290e73529c6/5/12)](https://dev.azure.com/zinykov/NorthwindBI/_release?_a=releases&view=mine&definitionId=5) | [![Reports](https://vsrm.dev.azure.com/zinykov/_apis/public/Release/badge/e6e8a805-df55-4da4-b1f8-d290e73529c6/5/13)](https://dev.azure.com/zinykov/NorthwindBI/_release?_a=releases&view=mine&definitionId=5) | [![Test](https://vsrm.dev.azure.com/zinykov/_apis/public/Release/badge/e6e8a805-df55-4da4-b1f8-d290e73529c6/5/15)](https://dev.azure.com/zinykov/NorthwindBI/_release?_a=releases&view=mine&definitionId=5) |

---