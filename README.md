## 🎓 Project Overview

This is a comprehensive University Course Registration Data Warehouse system that demonstrates the complete implementation of a data warehouse from operational database to analytical dashboard. It's designed as an educational project showcasing data warehousing concepts, OLAP operations, and modern web development.

## 🏗 Architecture & Components

### 1. Operational Database (Source System)
- 8 core tables: Students, Courses, Faculty, Departments, Semesters, Course Sections, Enrollments
- Normalized structure (3NF) for transactional operations
- Complete SQL scripts for table creation and sample data loading

### 2. Data Warehouse (Star Schema)
- 7 Dimension Tables: Students, Courses, Faculty, Departments, Semesters, Sections, Date
- 1 Fact Table: fact_enrollments with comprehensive measures
- Slowly Changing Dimensions (SCD) implementation
- Aggregate tables for performance optimization

### 3. Web Application (Next.js + React)
- Interactive Dashboard with real-time analytics
- Data Entry Forms for testing and demonstration
- Visual Documentation with ER diagrams and star schema
- Modern UI using shadcn/ui components and Tailwind CSS

## �� Key Features

### Analytics & Reporting
- Student Performance Analysis (GPA, grades, completion rates)
- Course Enrollment Trends by department, semester, faculty
- Data Quality Metrics (completeness, accuracy, consistency)
- Interactive Charts using Recharts library

### OLAP Operations
- Roll-up: Aggregating data to higher levels (course → department → college)
- Drill-down: Breaking down to detailed levels (department → course → student)
- Slice & Dice: Filtering and cross-tabulation analysis
- Time Series Analysis: Enrollment trends over time

### Data Management
- ETL Process with complete SQL scripts
- Data Quality Monitoring with validation queries
- Sample Data for demonstration purposes
- Manual Data Entry for testing scenarios

## 🛠 Technology Stack

- Frontend: Next.js 15, React 18, TypeScript
- UI Components: shadcn/ui, Tailwind CSS
- Charts: Recharts library
- Database: MySQL (with complete SQL scripts)
- Icons: Lucide React
- State Management: React hooks

## 📚 Educational Value

This project serves as a comprehensive learning resource for:
- Data Warehousing concepts (star schema, dimensions, facts)
- OLAP operations (roll-up, drill-down, slice & dice)
- ETL processes and data transformation
- Modern web development with React/Next.js
- Database design and SQL optimization
- Data visualization and dashboard creation

## 🎯 Use Cases

1. Academic Analytics: Track student performance, course popularity, faculty effectiveness
2. Administrative Reporting: Enrollment trends, resource allocation, capacity planning
3. Educational Research: Cohort analysis, retention studies, learning outcome assessment
4. Data Science Projects: Foundation for machine learning and predictive analytics

The project demonstrates a complete data pipeline from operational systems to analytical insights, making it an excellent example for students learning about data warehousing, business intelligence, and modern web development.
