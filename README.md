# Ali DBT — Data Transformation Project

A hands-on dbt + Databricks project focused on learning and practicing modern data transformation workflows, including SQL modeling, Jinja templating, data testing, source management, seeds, macros, and Git-based development.

The project follows a layered data transformation approach using Bronze, Silver, and Gold layers.

---

## Tech Stack

- dbt Core
- Databricks
- SQL
- Python
- Jinja
- Git
- GitHub

---

## Project Structure

```text
ali_dbt/
├── analyses/
│   ├── 01_explore.sql
│   └── jinja-01.sql
│
├── macros/
│   └── generate_schema.sql
│
├── models/
│   ├── bronze/
│   │   ├── bronze_customer.sql
│   │   ├── bronze_date.sql
│   │   ├── bronze_product.sql
│   │   ├── bronze_returns.sql
│   │   ├── bronze_sales.sql
│   │   ├── bronze_store.sql
│   │   └── properties.yml
│   │
│   ├── silver/
│   └── gold/
│
├── seeds/
│   └── lookup.csv
│
├── tests/
│   └── ...
│
├── dbt_project.yml
├── .gitignore
└── README.md
```

## Project Architecture

The project follows a layered transformation approach:

Source Data
     │
     ▼
  Bronze
     │
     ▼
  Silver
     │
     ▼
   Gold
     │
     ▼
Analytics / Reporting

### Bronze Layer

The Bronze layer contains the initial dbt models used to bring source data into the transformation pipeline.

Current models include:

- bronze_customer
- bronze_date
- bronze_product
- bronze_returns
- bronze_sales
- bronze_store

### Silver Layer

The Silver layer is used for cleaned, standardized, and transformed datasets that are ready for further analytical processing.

### Gold Layer

The Gold layer is intended for business-facing analytical models and reporting.

---

## dbt Concepts Practiced

This project is designed to explore the core concepts behind dbt rather than simply learning commands.

### Models

SQL transformations are implemented as dbt models.

Example:

SELECT *
FROM {{ source('source', 'fact_sales') }}

dbt compiles the Jinja code and executes the resulting SQL in Databricks.

---

### Sources

Source tables are referenced using dbt's source() function.

Example:

{{ source('source', 'fact_sales') }}

Using sources allows dbt to understand where the data originates and establish dependencies between source data and downstream models.

---

### Model References

dbt's ref() function is used to create dependencies between models.

Example:

SELECT *
FROM {{ ref('bronze_sales') }}

Conceptually:

Source
  │
  ▼
Bronze Model
  │
  ▼
Silver Model
  │
  ▼
Gold Model

dbt uses these dependencies to build the correct execution order and generate lineage.

---

## Jinja

Jinja is used to make SQL dynamic and reusable.

Example:

{% set var_name = 'ali' %}

SELECT '{{ var_name }}' AS name

The Jinja expression is evaluated during dbt compilation before the SQL is sent to Databricks.

This project explores concepts such as:

- Variables
- Jinja expressions
- ref()
- source()
- Macros
- Conditional logic
- Dynamic SQL

---

## Macros

The project includes custom dbt macros for reusable SQL logic.

Macros allow commonly used logic to be defined once and reused across multiple models.

Example location:

macros/generate_schema.sql

---

## Seeds

The project uses a CSV seed for static reference data:

seeds/lookup.csv

Seeds allow small, static datasets to be version-controlled alongside the dbt project and loaded into Databricks through dbt.

Load seeds with:

dbt seed

For a full refresh:

dbt seed --full-refresh

---

## Data Quality Testing

dbt tests are used to validate data quality and enforce assumptions about the data.

Tests currently explored include:

- unique
- not_null
- accepted_values
- Custom generic tests
- Singular SQL tests

Example:

- name: store_sk
  data_tests:
    - unique
    - not_null

An accepted_values test is also used to validate permitted store names.

---

## Singular Tests

The project also explores SQL-based singular tests.

A singular test is simply a SQL query that should return zero rows when the data is valid.

Example:

SELECT *
FROM {{ ref('bronze_sales') }}
WHERE gross_amount < 0
   OR net_amount < 0

If the query returns rows, dbt considers the test to have failed.

---

## Compilation

One of the important concepts explored in this project is the difference between dbt code and the SQL that is actually sent to Databricks.

For example:

{{ target.schema }}

may compile to:

dbt_dev

while:

SELECT '{{ target.schema }}' AS schema_name

compiles to:

SELECT 'dbt_dev' AS schema_name

dbt compilation can be performed using:

dbt compile

Compiled SQL can be inspected in:

target/compiled/

---

## Databricks Integration

Databricks is used as the execution platform for the dbt transformations.

The workflow is:

Local dbt Project
       │
       ▼
dbt Compilation
       │
       ▼
Generated SQL
       │
       ▼
Databricks
       │
       ▼
Tables / Views

---

## Git & GitHub Workflow

Git is used to version-control the dbt project.

The basic workflow is:

Local Changes
     │
     ▼
git add
     │
     ▼
git commit
     │
     ▼
git push
     │
     ▼
GitHub

The project is maintained as a Git repository and hosted remotely on GitHub.

---

## Common dbt Commands

### Check the dbt installation

dbt --version

### Check the connection

dbt debug

### Install dependencies

dbt deps

### Parse the project

dbt parse

### Compile SQL

dbt compile

### Run models

dbt run

### Run tests

dbt test

### Build models and tests

dbt build

### Load seeds

dbt seed

### Full-refresh seeds

dbt seed --full-refresh

### Run a specific model

dbt run --select bronze_sales

### Run a specific test

dbt test --select <test_name>

---

## Development Workflow

The general development workflow is:

1. Create or modify a dbt model.
2. Use Jinja, ref(), source(), or macros where required.
3. Run dbt compile to verify compilation.
4. Run the model with dbt run or dbt build.
5. Run data quality tests.
6. Review the generated SQL and results.
7. Commit the changes to Git.
8. Push the changes to GitHub.

---

## Configuration

Project-level configuration is stored in:

dbt_project.yml

Database connection credentials are kept outside the repository in:

~/.dbt/profiles.yml

Sensitive credentials such as Databricks API tokens should never be committed to Git or GitHub.

The repository therefore excludes sensitive and generated files through .gitignore.

---

## Learning Objectives

The main goal of this project is to develop a practical understanding of dbt and modern data transformation.

Key concepts being explored:

- dbt project structure
- SQL transformations
- Data modeling
- Bronze / Silver / Gold architecture
- Sources
- ref()
- source()
- Jinja
- Variables
- Macros
- Seeds
- Generic tests
- Singular tests
- Data quality
- SQL compilation
- Databricks integration
- Git and GitHub workflows

---

## Future Improvements

Planned areas for further development include:

- Expand Silver transformations
- Build Gold analytical models
- Add more comprehensive data quality tests
- Add model and column documentation
- Explore incremental models
- Explore dbt snapshots
- Improve lineage documentation
- Add CI/CD
- Automate dbt testing with GitHub Actions
- Add more advanced macros
- Implement production-style deployment workflows

---

## Author

Ali Jabbar

BS Computer Science | Data Engineering

This repository represents my hands-on learning journey into Data Engineering, dbt, SQL, Databricks, and modern analytics engineering workflows.
