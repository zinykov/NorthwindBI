# 🏛️ Northwind Enterprise Data Platform (EDP)
**A production-grade, end-to-end Enterprise Business Intelligence ecosystem.**

---

## ✍️ About the Author
Architected and deployed a comprehensive Enterprise DWH/BI Platform by integrating disparate Microsoft stack components into a unified ecosystem. Focused on Full-cycle Automation (CI/CD, automated QA) and the practical application of Kimball Methodology to deliver high-integrity, scalable analytical solutions.

---

## 💡 Why choose this solution?

Unlike typical "flat-file" BI projects, **Northwind BI Solution** is a professional framework designed for scalability, manageability, and data integrity. It bridges the gap between raw data and executive insights by implementing a full-stack Enterprise BI lifecycle.

*   **Architected for Growth:** Built with **Partitioning** and **Columnstore** technology to handle datasets that would crush a standard SQL Server instance.
*   **Kimball Methodology at Core:** Strictly follows the **Data Warehouse Lifecycle Toolkit** (Bus Matrix, Conformed Dimensions, and SCD Type 1 & 2 management).
*   **Engineered for Professionals:** Leverages **SSAS Tabular** and **Calculation Groups** (via Tabular Editor) to eliminate measure duplication and ensure a "Single Version of Truth."
*   **Ops-Ready from Day One:** Includes built-in **Monitoring** and **Master Data Management (MDS)**, transforming a simple database into a governed analytical platform.
*   **DevOps Centric:** Designed with environment isolation (Dev/Test/Prod) and CI/CD-ready structure for automated deployments via **Azure DevOps**.

> **This is not just a dashboard — it's a scalable blueprint for modern Enterprise Business Intelligence.**

---

## 📐 Architecture & Design

### High-Level System Architecture
![Main Architecture](Docs/Images/architecture_main.png)
*Full-stack BI lifecycle implementation from source to reporting layer.*

### Dimensional Model (DWH)
![DWH Schema](Docs/Images/dwh_schema.png)
*Star schema design optimized for analytical query performance (Kimball Methodology).*

### Scalable Topology
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

## 🛠️ Tech Stack & Tools


| Layer | Technologies |
| :--- | :--- |
| **Database & DWH** | `SQL Server 2022`, `T-SQL`, `Columnstore`, `Partitioning`, `File Groups` |
| **ETL & Integration** | `SSIS (Integration Services)`, `ELT Patterns`, `MDS`, `DQS`, `SHA2 Delta Capture` |
| **Semantic & Analytics**| `SSAS Tabular`, `DAX`, `Calculation Groups`, `Tabular Editor 2/3` |
| **Reporting** | `Power BI Report Server`, `Power BI Reports`, `SSAS`, `Paginated Reports (SSRS)`, `Excel` |
| **DevOps & QA** | `Azure DevOps`, `Azure Pipelines`, `MSTest`, `SQL Unit Testing` |

---

## 🚀 Key Features & Architectural Highlights

### 1. End-to-End Automated Testing (Project Know-How)
**The primary technological advantage of this project.** A unique, custom automated testing framework is integrated directly into the DWH development lifecycle.
*   **For Business:** Guarantees 100% data accuracy in reports. Data anomalies are localized at the earliest stages, completely eliminating the risk of making critical management decisions based on incorrect information.
*   **For IT:** Automated Unit Testing and business logic validation are executed "in one click," radically reducing time spent on regression testing, debugging, and system maintenance.

### 2. High-Performance Data Engineering (Scale-with-Business)
The architecture is designed on a "Scale-with-Business" principle: the DWH scales seamlessly alongside the company, supporting both vertical power scaling and horizontal distribution of services (SSIS, MDS, SSRS) across cluster nodes.
*   **Autonomous Storage:** Full database physics automation — the system independently manages filegroup creation on SSD/HDD based on data recency, configures compression (PAGE/COLUMNSTORE), and manages partition slicing via a "Sliding Window" strategy.
*   **ETL performance:** Dynamic creation and dropping of indexes and constraints in the Landing Zone (LZ) to ensure peak performance for both bulk inserts and delta selection.
*   **Shadow Loading:**  Implementation of the Switch Partition pattern and MERGE logic to ensure millions of rows are loaded without locking out business users, while maintaining correct handling of late-arriving data.
*   **Operational Automation:** Zero-routine maintenance via **Automated Maintenance Plans** — intelligent index maintenance, statistics updates, and full server backups (including system databases) run autonomously via SQL Agent scheduling.

### 3. Multi-level Data Quality Control
A comprehensive, multi-layered quality filter that ensures the purity and transparency of corporate information.
*   **Master Data & Cleansing:** Deep integration with **Master Data Services (MDS)** for "Golden Record" management and **Data Quality Services (DQS)** for automated attribute cleansing and enrichment.
*   **Deep Traceability:** **Lineage** technology and the hybrid **AllAttributes** field preserve a complete audit trail for every record, allowing the context of any transformation to be reconstructed directly within the semantic model.

### 4. Modern Developer Experience (DX)
Applying **Software Engineering** best practices to the data world for accelerated development and release stability.
*   **Engineering Culture:** Development via Database Projects (SSDT), full Git version control, isolated debugging environments, and a pre-configured **CI/CD pipeline**.
*   **Efficiency:** A single entry point for developers and "one-click" local test execution minimize the "human factor" during deployment and significantly reduce Time-to-Market.

---

## 🗺️ Project Roadmap

The project is evolving from a local BI prototype to a distributed Enterprise Data Platform. Current development is focused on:

*   **[In Progress] Semantic Layer Migration:** Transitioning the data model from Power BI Desktop to a dedicated **SSAS Tabular** instance to support multiple reporting clients and centralized measure management.
*   **[In Progress] Advanced Metadata Catalog:** Implementation of a dedicated `Metadata` schema for automated **Lineage** tracking and a Business Glossary (Data Dictionary) in Azure Wiki.
*   **[Planned] Full E2E Test Coverage:** Extending the **MSTest framework** to include the **Extract** layer, ensuring robust data contracts and automated handling of source schema changes (Schema Drift).
*   **[Planned] Data Tiering (TCO Optimization):** Automated movement of historical data partitions between high-performance SSD and cost-effective HDD storage groups.

---

## 📖 Documentation & Links
Detailed architectural decisions, schemas, and implementation guides are available here: [**Solution Architecture Document**](Docs/Solution%20Architecture%20Document.docx)

---

## 🛡️ Project Badges & CI/CD Status

### **Project Management**
[![Board Status](https://dev.azure.com/zinykov/e6e8a805-df55-4da4-b1f8-d290e73529c6/3660f141-eb17-455f-80e6-f5580788fd8b/_apis/work/boardbadge/f3221562-8345-4080-8a57-9776d148c41b?columnOptions=1)](https://dev.azure.com/zinykov/e6e8a805-df55-4da4-b1f8-d290e73529c6/_boards/board/t/3660f141-eb17-455f-80e6-f5580788fd8b/Stories/)

### **Deployment Status**

| CD: Databases | CD: SSIS | CD: Reports | CD: Functional ETL test |
| :--- | :--- | :--- | :--- |
| [![Databases](https://vsrm.dev.azure.com/zinykov/_apis/public/Release/badge/e6e8a805-df55-4da4-b1f8-d290e73529c6/5/11)](https://dev.azure.com/zinykov/NorthwindBI/_release?_a=releases&view=mine&definitionId=5) | [![SSIS](https://vsrm.dev.azure.com/zinykov/_apis/public/Release/badge/e6e8a805-df55-4da4-b1f8-d290e73529c6/5/12)](https://dev.azure.com/zinykov/NorthwindBI/_release?_a=releases&view=mine&definitionId=5) | [![Reports](https://vsrm.dev.azure.com/zinykov/_apis/public/Release/badge/e6e8a805-df55-4da4-b1f8-d290e73529c6/5/13)](https://dev.azure.com/zinykov/NorthwindBI/_release?_a=releases&view=mine&definitionId=5) | [![Test](https://vsrm.dev.azure.com/zinykov/_apis/public/Release/badge/e6e8a805-df55-4da4-b1f8-d290e73529c6/5/15)](https://dev.azure.com/zinykov/NorthwindBI/_release?_a=releases&view=mine&definitionId=5) |

---