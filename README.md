# Terraform GCP BigQuery Labeling for Cost Attribution

This repository contains Terraform code to set up Google Cloud Platform (GCP) BigQuery resources (datasets, tables, views) with a defined labeling strategy. It also provides guidance and a sample script to demonstrate how to apply these labels to BigQuery jobs (queries, loads) for effective cost attribution in your GCP billing reports.

## Project Goal

The primary goal is to demonstrate how to use GCP labels in conjunction with BigQuery to break down costs and attribute spending to specific teams, projects, environments, or data classifications. This is crucial for cost management, chargeback/showback models, and understanding where your BigQuery spend is going.

## Features

* Creates BigQuery datasets, tables, and views.
* Applies a consistent set of labels (`environment`, `team`, `project`, `data-sensitivity`, `billing-code`, etc.) to BigQuery resources using Terraform.
* Provides a sample bash script to ingest data into the created tables using the `bq` command-line tool, explicitly labeling the ingestion jobs.
* Outlines steps to visualize BigQuery costs by these labels in the GCP Cloud Billing reports and via BigQuery billing export data.

## Prerequisites

Before using this Terraform code, ensure you have the following:

1.  **GCP Project:** An active Google Cloud Platform project.
2.  **Active Billing Account:** Your GCP project must be linked to an active billing account.
3.  **APIs Enabled:** The BigQuery API and Cloud Billing API must be enabled for your GCP project.
4.  **Cloud Billing Export to BigQuery:** **This is essential for cost attribution by label.** You must configure your Cloud Billing account to export detailed usage cost data to a dedicated BigQuery dataset. Follow the [GCP documentation on exporting billing data](https://cloud.google.com/billing/docs/how-to/export-data-bigquery) if you haven't already. Note that it takes time for this export to become active and populated with data (typically several hours).
5.  **Terraform Installed:** Install Terraform on your local machine. ([https://developer.hashicorp.com/terraform/downloads](https://developer.hashicorp.com/terraform/downloads))
6.  **Google Cloud SDK Installed:** Install the `gcloud` command-line tool, which includes the `bq` tool used for running BigQuery jobs. ([https://cloud.google.com/sdk/docs/install](https://cloud.google.com/sdk/docs/install))
7.  **GCP Authentication:** Configure your local environment to authenticate with GCP. The simplest way for development is often using `gcloud auth application-default login`.

## Setup and Configuration

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/YOUR_GITHUB_USER/terraform-gcp-bigquery-cost-attribution.git](https://github.com/YOUR_GITHUB_USER/terraform-gcp-bigquery-cost-attribution.git) # Replace with your actual repo URL
    cd terraform-gcp-bigquery-cost-attribution
    ```
2.  **Initialize Terraform:**
    ```bash
    terraform init
    ```
3.  **Configure Variables:**
    Create a file named `terraform.tfvars` in the root of the repository. This file will hold the specific values for your GCP project and desired setup.

    ```terraform
    # terraform.tfvars

    # The GCP project ID where resources will be created.
    # Replace "your-gcp-project-id" with your actual GCP project ID.
    project_id = "your-gcp-project-id"

    # The GCP region for BigQuery datasets.
    # Choose a region close to you or your users (e.g., "us-central1", "europe-west2").
    # Default is "US" in main.tf, but specifying here is explicit.
    region = "us-central1"

    # The environment for these resources (e.g., development, staging, production).
    # This value is used in dataset IDs and labels. Must be lowercase.
    environment = "development"

    # Replace with your actual GCP user or group email to grant OWNER access to datasets.
    # This email must have permissions to be added to IAM policies.
    user_email = "your-gcp-user@example.com"
    ```
    **Replace the placeholder values** in `terraform.tfvars` with your actual GCP project ID, desired region, environment name (lowercase!), and user email.

## Deployment

1.  **Review the Plan:** Run `terraform plan` to see the infrastructure that Terraform will create based on your configuration.
    ```bash
    terraform plan
    ```
    Review the output carefully to ensure it matches your expectations.

2.  **Apply the Configuration:** If the plan looks correct, apply the changes.
    ```bash
    terraform apply
    ```
    Type `yes` when prompted to confirm the deployment.

Terraform will create the BigQuery datasets, tables, and views with the specified labels.

## Data Ingestion with Labeled Jobs

To ensure the compute costs associated with data loading are attributed correctly, we will use the `bq` command-line tool and explicitly add labels to the ingestion jobs.

Save the following content as a bash script (e.g., `ingest_data.sh`). **Remember to make it executable (`chmod +x ingest_data.sh`) and replace the placeholder values.**

```bash
#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration ---
# !!! REPLACE THESE VALUES !!!
PROJECT_ID="your-gcp-project-id" # Your actual GCP project ID
DATASET_ID="customer_reporting_development" # Your actual dataset ID created by Terraform (e.g., customer_reporting_ + your environment variable)
# --- End Configuration ---

echo "--- Starting data ingestion script ---"
echo "Targeting project: $PROJECT_ID"
echo "Targeting dataset: $DATASET_ID"

# Define common labels for the jobs
JOB_LABELS="environment=development,team=data-analytics,project=customer-reporting"

# --- Ingest data into customers table ---
echo "Inserting sample data into customers table..."

bq query --nouse_legacy_sql \
  --label ${JOB_LABELS},job-type=data-ingestion,table=customers \
  "INSERT INTO \`${PROJECT_ID}.${DATASET_ID}.customers\` (customer_id, name, signup_date)
   VALUES
   ('cust_A1B2', 'Alice Wonderland', '2023-04-10'),
   ('cust_C3D4', 'Bob TheBuilder', '2023-05-22'),
   ('cust_E5F6', 'Charlie Chaplin', '2023-06-01'),
   ('cust_G7H8', 'Diana Ross', '2023-07-15'),
   ('cust_I9J0', 'Ethan Carter', '2023-08-03'),
   ('cust_K1L2', 'Fiona Apple', '2023-09-11'),
   ('cust_M3N4', 'George Orwell', '2023-10-25'),
   ('cust_O5P6', 'Hannah Montana', '2023-11-30'),
   ('cust_Q7R8', 'Ian Fleming', '2024-01-05'),
   ('cust_S9T0', 'Jasmine Guy', '2024-02-29');"

echo "Customers data ingestion job submitted."

# --- Ingest data into orders table ---
echo "Inserting sample data into orders table..."

# Define orders specific job labels, merging with common labels
ORDERS_JOB_LABELS="${JOB_LABELS},job-type=data-ingestion,table=orders"

bq query --nouse_legacy_sql \
  --label ${ORDERS_JOB_LABELS//,/ --label } \
  "INSERT INTO \`${PROJECT_ID}.${DATASET_ID}.orders\` (order_id, customer_id, order_date, amount)
   VALUES
   ('order_001', 'cust_A1B2', '2023-04-15 10:30:00 UTC', 45.75),
   ('order_002', 'cust_A1B2', '2023-05-01 14:00:00 UTC', 120.00),
   ('order_003', 'cust_C3D4', '2023-06-05 09:15:00 UTC', 210.50),
   ('order_004', 'cust_C3D4', '2023-06-10 11:00:00 UTC', 88.00),
   ('order_005', 'cust_C3D4', '2023-07-01 16:30:00 UTC', 55.20),
   ('order_006', 'cust_E5F6', '2023-06-15 10:00:00 UTC', 15.99),
   ('order_007', 'cust_G7H8', '2023-07-20 13:00:00 UTC', 75.00),
   ('order_008', 'cust_G7H8', '2023-08-01 09:45:00 UTC', 150.75),
   ('order_009', 'cust_G7H8', '2023-08-10 17:00:00 UTC', 30.00),
   ('order_010', 'cust_G7H8', '2023-09-01 11:20:00 UTC', 40.50),
   ('order_011', 'cust_I9J0', '2023-08-15 14:00:00 UTC', 300.00),
   ('order_012', 'cust_I9J0', '2023-09-05 10:00:00 UTC', 250.00),
   ('order_013', 'cust_K1L2', '2023-09-18 11:00:00 UTC', 88.88),
   ('order_014', 'cust_K1L2', '2023-10-01 15:00:00 UTC', 111.11),
   ('order_015', 'cust_M3N4', '2023-11-01 10:30:00 UTC', 45.60),
   ('order_016', 'cust_M3N4', '2023-11-15 14:00:00 UTC', 80.00),
   ('order_017', 'cust_M3N4', '2023-12-01 11:00:00 UTC', 90.40),
   ('order_018', 'cust_O5P6', '2023-12-10 10:00:00 UTC', 15.00),
   ('order_019', 'cust_Q7R8', '2024-01-10 14:00:00 UTC', 250.00),
   ('order_020', 'cust_Q7R8', '2024-01-20 11:00:00 UTC', 350.00),
   ('order_021', 'cust_Q7R8', '2024-02-05 09:00:00 UTC', 100.00),
   ('order_022', 'cust_S9T0', '2024-03-01 13:00:00 UTC', 50.00),
   ('order_023', 'cust_S9T0', '2024-03-15 10:00:00 UTC', 75.00),
   ('order_024', 'cust_S9T0', '2024-04-01 14:00:00 UTC', 100.00);
   "

echo "Orders data ingestion job submitted."
echo "--- Data ingestion script finished ---"


bq query --nouse_legacy_sql \
--label environment:development \
--label team:data-analytics \
--label project:customer-reporting \
--label job-type:data-ingestion \
'INSERT INTO `andresousa-pso-upskilling.customer_reporting_development.customers` (customer_id, name, signup_date) VALUES ("cust_A1B2", "Alice Wonderland", "2023-04-10"), ("cust_C3D4", "Bob TheBuilder", "2023-05-22") ;'


bq query --nouse_legacy_sql \
--label environment:development \
--label team:data-analytics \
--label project:customer-reporting \
--label job-type:data-ingestion \
'INSERT INTO `andresousa-pso-upskilling.customer_reporting_development.orders` (order_id, customer_id, order_date, amount) VALUES ("order_001", "cust_A1B2", "2023-04-15 10:30:00 UTC", 45.75), ("order_002", "cust_A1B2", "2023-05-01 14:00:00 UTC", 120.00) ;'
# terraform-bigquery-cost-attribution
