# Configure the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# --- Variable Declarations ---

variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "region" {
  description = "The GCP region for BigQuery datasets."
  type        = string
  default     = "US" # Change to your desired region (e.g., "europe-west2")
}

variable "environment" {
  description = "The environment for these resources (e.g., development, staging, production)."
  type        = string
  # You could add a default here, but requiring it in tfvars or via -var is also an option
}

variable "user_email" {
  description = "The email of a user or group to grant OWNER access to the datasets."
  type        = string
  # You could add a default here, but requiring it in tfvars or via -var is also an option
}


# --- Label Definitions ---
# Define standard labels as local variables for consistency
locals {
  common_labels = {
    environment = var.environment # Use the declared variable here
    team        = "data-analytics"
    billing-code = "da-789"
  }

  dataset1_labels = merge(local.common_labels, {
    project = "customer-reporting"
  })

  dataset2_labels = merge(local.common_labels, {
    team    = "finance" # Override team for this dataset
    project = "financial-data"
  })

  table1_labels = merge(local.dataset1_labels, {
    data-sensitivity = "confidential"
  })

  table2_labels = merge(local.dataset1_labels, {
    data-sensitivity = "internal"
    # Example of adding a specific table label
    processing-frequency = "daily"
  })

  view1_labels = merge(local.dataset1_labels, {
    data-sensitivity = "internal"
    view-purpose     = "aggregated-report"
  })
}

# --- BigQuery Resources ---

# Dataset 1: For Customer Reporting (Data Analytics Team)
resource "google_bigquery_dataset" "customer_reporting" {
  dataset_id = "customer_reporting_${lower(var.environment)}" # Use the declared variable
  project    = var.project_id
  location   = var.region
  labels     = local.dataset1_labels

  access {
    role          = "OWNER"
    user_by_email = var.user_email # Use the declared variable
  }
  # Add other access entries as needed for your teams/service accounts

  delete_contents_on_destroy = true # WARNING: This will delete data! Set to false in production
}

# Dataset 2: For Financial Data (Finance Team)
resource "google_bigquery_dataset" "financial_data" {
  dataset_id = "finance_data_${lower(var.environment)}" # Use the declared variable
  project    = var.project_id
  location   = var.region
  labels     = local.dataset2_labels

  access {
    role          = "OWNER"
    user_by_email = var.user_email # Use the declared variable
  }
  # Add other access entries as needed

  delete_contents_on_destroy = true # WARNING: This will delete data! Set to false in production
}

# Table 1 in customer_reporting dataset
resource "google_bigquery_table" "customers" {
  dataset_id = google_bigquery_dataset.customer_reporting.dataset_id
  table_id   = "customers"
  project    = var.project_id
  labels     = local.table1_labels

  schema = <<EOF
[
  {
    "name": "customer_id",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "name",
    "type": "STRING"
  },
  {
    "name": "signup_date",
    "type": "DATE"
  }
]
EOF
}

# Table 2 in customer_reporting dataset
resource "google_bigquery_table" "orders" {
  dataset_id = google_bigquery_dataset.customer_reporting.dataset_id
  table_id   = "orders"
  project    = var.project_id
  labels     = local.table2_labels

  schema = <<EOF
[
  {
    "name": "order_id",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "customer_id",
    "type": "STRING"
  },
  {
    "name": "order_date",
    "type": "TIMESTAMP"
  },
  {
    "name": "amount",
    "type": "BIGNUMERIC"
  }
]
EOF
}

# View 1 in customer_reporting dataset
resource "google_bigquery_table" "customer_order_summary_view" {
  dataset_id = google_bigquery_dataset.customer_reporting.dataset_id
  table_id   = "customer_order_summary"
  project    = var.project_id
  labels     = local.view1_labels

  view {
    query = <<-EOF
      SELECT
        c.customer_id,
        c.name,
        COUNT(o.order_id) as total_orders,
        SUM(o.amount) as total_amount_spent
      FROM
        `${var.project_id}.${google_bigquery_dataset.customer_reporting.dataset_id}.customers` AS c
      JOIN
        `${var.project_id}.${google_bigquery_dataset.customer_reporting.dataset_id}.orders` AS o
      ON
        c.customer_id = o.customer_id
      GROUP BY
        c.customer_id, c.name
    EOF
    use_legacy_sql = false
  }
}

# Note: Terraform does NOT manage BigQuery Jobs (query, load, export) directly as persistent resources for cost attribution.
# Job labeling is applied at the time of job execution. See explanation in previous response.