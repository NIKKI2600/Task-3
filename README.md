# Task_3: SQL FOR DATA ANALYSIS

This project focuses on creating and analyzing a relational database for employee and performance data using MySQL. The data is loaded from three CSV files and explored through various SQL operations.

## 📁 Dataset Tables
- Employee: Contains employee demographic and job details.
- PerformanceRating: Includes performance review metrics.
- ds_salary: Salary and job satisfaction-related data.

## 🛠 Key Tasks Performed

### 🔧 Schema & Table Creation
- Created ElevateLabs schema.
- Designed normalized tables for employee, performance, and salary data.

### 📥 Data Loading
- Used LOAD DATA INFILE to load CSV data into respective tables.
- Parsed and formatted date fields using STR_TO_DATE.

### 🔍 Data Exploration
- Used SELECT, WHERE, and ORDER BY to filter and sort data.
- Aggregated data with GROUP BY, COUNT, SUM, and conditional aggregation.

### 🔗 Joins
- Demonstrated INNER JOIN, LEFT JOIN, and RIGHT JOIN between Employee and ds_salary.

### 🔄 Subqueries
- Identified high-earning employees using average salary comparison.

### 👁 View Creation
- Created a view EmployeeSalaryInfo to simplify frequent analysis.

### ⚡ Indexing
- Added indexes on key columns to optimize query performance.

## 💡 Sample Insights
- Identified job roles with the highest attrition.
- Filtered employees working overtime with high salary hikes.
- Compared employee table salary with reported monthly income.

---

> 📊 *Tech Stack*: MySQL  
> 📂 *Data Source*: Internal HR CSV files  
> ✨ *Focus*: Schema design, SQL joins, aggregates, subqueries, performance optimizationT
