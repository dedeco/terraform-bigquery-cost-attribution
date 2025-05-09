sql
-- ############################################
-- Sample Data for customers table
-- Dataset ID will be something like customer_reporting_development
-- Replace 'andresousa-pso-upskilling' and 'customer_reporting_development'

INSERT INTO `andresousa-pso-upskilling.customer_reporting_development.customers` (customer_id, name, signup_date)
VALUES
('cust_001', 'Alice Smith', '2023-01-15'),
('cust_002', 'Bob Johnson', '2023-02-20'),
('cust_003', 'Charlie Brown', '2023-03-10'),
('cust_004', 'Diana Prince', '2023-04-01'),
('cust_005', 'Ethan Hunt', '2023-05-25'),
('cust_006', 'Fiona Gallagher', '2023-06-18'),
('cust_007', 'George Costanza', '2023-07-22'),
('cust_008', 'Hannah Abbott', '2023-08-05'),
('cust_009', 'Ian Malcolm', '2023-09-30'),
('cust_010', 'Jasmine Ali', '2023-10-12'),
('cust_011', 'Kevin Spacey', '2024-01-20'), -- Using a fictional name
('cust_012', 'Luna Lovegood', '2024-02-14'),
('cust_013', 'Mike Ross', '2024-03-03'),
('cust_014', 'Nancy Drew', '2024-04-28'),
('cust_015', 'Oliver Queen', '2024-05-19');

-- ############################################
-- Sample Data for orders table
-- This data references customer_ids from the customers table
-- Replace 'andresousa-pso-upskilling' and 'customer_reporting_development'

INSERT INTO `andresousa-pso-upskilling.customer_reporting_development.orders` (order_id, customer_id, order_date, amount)
VALUES
-- Orders for cust_001
('order_1001', 'cust_001', '2023-01-20 10:00:00 UTC', 55.50),
('order_1002', 'cust_001', '2023-02-01 14:30:00 UTC', 120.00),
('order_1003', 'cust_001', '2023-03-18 09:15:00 UTC', 30.25),

-- Orders for cust_002
('order_1004', 'cust_002', '2023-03-01 11:00:00 UTC', 210.75),
('order_1005', 'cust_002', '2023-04-05 16:45:00 UTC', 95.00),

-- Orders for cust_003
('order_1006', 'cust_003', '2023-03-15 10:30:00 UTC', 15.99),
('order_1007', 'cust_003', '2023-05-01 13:00:00 UTC', 75.00),
('order_1008', 'cust_003', '2023-06-10 17:00:00 UTC', 150.50),

-- Orders for cust_004
('order_1009', 'cust_004', '2023-04-03 08:00:00 UTC', 10.00),
('order_1010', 'cust_004', '2023-05-10 12:00:00 UTC', 25.00),
('order_1011', 'cust_004', '2023-06-01 15:00:00 UTC', 40.00),
('order_1012', 'cust_004', '2023-07-15 18:00:00 UTC', 60.00),

-- Orders for cust_005
('order_1013', 'cust_005', '2023-06-01 09:00:00 UTC', 300.00),

-- Orders for cust_006
('order_1014', 'cust_006', '2023-07-01 14:00:00 UTC', 88.88),
('order_1015', 'cust_006', '2023-08-01 10:00:00 UTC', 111.11),
('order_1016', 'cust_006', '2023-09-01 16:00:00 UTC', 99.99),

-- Orders for cust_007
('order_1017', 'cust_007', '2023-08-01 11:30:00 UTC', 45.60),
('order_1018', 'cust_007', '2023-09-10 15:00:00 UTC', 80.00),

-- Orders for cust_008
('order_1019', 'cust_008', '2023-08-10 10:00:00 UTC', 15.00),

-- Orders for cust_009
('order_1020', 'cust_009', '2023-10-05 14:00:00 UTC', 250.00),
('order_1021', 'cust_009', '2023-11-01 11:00:00 UTC', 350.00),
('order_1022', 'cust_009', '2023-12-20 09:00:00 UTC', 100.00),
('order_1023', 'cust_009', '2024-01-10 16:00:00 UTC', 400.00),

-- Orders for cust_010
('order_1024', 'cust_010', '2023-10-15 13:00:00 UTC', 50.00),
('order_1025', 'cust_010', '2023-11-20 10:00:00 UTC', 75.00),
('order_1026', 'cust_010', '2023-12-05 14:00:00 UTC', 100.00),
('order_1027', 'cust_010', '2024-01-01 11:00:00 UTC', 125.00),
('order_1028', 'cust_010', '2024-02-18 15:00:00 UTC', 150.00),

-- Orders for cust_011
('order_1029', 'cust_011', '2024-01-25 10:00:00 UTC', 99.00),
('order_1030', 'cust_011', '2024-02-10 14:00:00 UTC', 199.00),
('order_1031', 'cust_011', '2024-03-01 11:00:00 UTC', 299.00),

-- Orders for cust_012
('order_1032', 'cust_012', '2024-02-16 08:00:00 UTC', 25.00),
('order_1033', 'cust_012', '2024-03-20 12:00:00 UTC', 50.00),

-- Orders for cust_013
('order_1034', 'cust_013', '2024-03-05 10:00:00 UTC', 75.00),
('order_1035', 'cust_013', '2024-04-01 14:00:00 UTC', 100.00),
('order_1036', 'cust_013', '2024-05-01 11:00:00 UTC', 125.00),

-- Orders for cust_014
('order_1037', 'cust_014', '2024-05-01 09:00:00 UTC', 10.00),
('order_1038', 'cust_014', '2024-05-10 13:00:00 UTC', 20.00),

-- Orders for cust_015
('order_1039', 'cust_015', '2024-05-20 10:00:00 UTC', 500.00),
('order_1040', 'cust_015', '2024-05-21 11:00:00 UTC', 750.00);

-- ############################################
```

**How to run this in BigQuery:**

1.  Go to the **BigQuery Studio** in the Google Cloud Console.
2.  Click **+ Compose new query**.
3.  Copy and paste the SQL statements into the query editor.
4.  **Crucially, replace** `andresousa-pso-upskilling` and `customer_reporting_development` with your actual project ID and the dataset ID created by Terraform (e.g., `customer_reporting_development`).
5.  Click **Run**.

You can run the `INSERT` statement for `customers` first, and then the `INSERT` statement for `orders`. BigQuery allows multiple statements in one query window, but running them separately might be clearer.

Remember that running these `INSERT` statements are BigQuery **jobs**, and to see their costs attributed by label, you would ideally submit them with labels using the `bq` command or client libraries as described in the previous response. Running them directly in the console query editor might not automatically apply the dataset/table labels to the job itself, depending on the console's behavior. To guarantee cost attribution, use the `bq` command with the `--labels` flag.<ctrl98>
Okay, I understand. It seems there was an issue with the previous attempt to generate the SQL within the tool.

Let's generate the sample SQL `INSERT` statements directly. These statements will populate your `customers` and `orders` tables with some random-like data, ensuring the relationship between customers and their orders is maintained.

Remember to replace `andresousa-pso-upskilling` and `customer_reporting_development` with your actual GCP project ID and the dataset ID created by Terraform (which will be in the format `customer_reporting_development` or similar based on your `environment` variable).

```sql
-- ############################################
-- Sample Data for customers table
-- Dataset ID will be something like customer_reporting_development
-- Replace 'andresousa-pso-upskilling' and 'customer_reporting_development' below

INSERT INTO `andresousa-pso-upskilling.customer_reporting_development.customers` (customer_id, name, signup_date)
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
('cust_S9T0', 'Jasmine Guy', '2024-02-29');


-- ############################################
-- Sample Data for orders table
-- This data references customer_ids from the customers table above.
-- Replace 'andresousa-pso-upskilling' and 'customer_reporting_development' below.

INSERT INTO `andresousa-pso-upskilling.customer_reporting_development.orders` (order_id, customer_id, order_date, amount)
VALUES
-- Orders for cust_A1B2
('order_001', 'cust_A1B2', '2023-04-15 10:30:00 UTC', 45.75),
('order_002', 'cust_A1B2', '2023-05-01 14:00:00 UTC', 120.00),

-- Orders for cust_C3D4
('order_003', 'cust_C3D4', '2023-06-05 09:15:00 UTC', 210.50),
('order_004', 'cust_C3D4', '2023-06-10 11:00:00 UTC', 88.00),
('order_005', 'cust_C3D4', '2023-07-01 16:30:00 UTC', 55.20),

-- Orders for cust_E5F6
('order_006', 'cust_E5F6', '2023-06-15 10:00:00 UTC', 15.99),

-- Orders for cust_G7H8
('order_007', 'cust_G7H8', '2023-07-20 13:00:00 UTC', 75.00),
('order_008', 'cust_G7H8', '2023-08-01 09:45:00 UTC', 150.75),
('order_009', 'cust_G7H8', '2023-08-10 17:00:00 UTC', 30.00),
('order_010', 'cust_G7H8', '2023-09-01 11:20:00 UTC', 40.50),

-- Orders for cust_I9J0
('order_011', 'cust_I9J0', '2023-08-15 14:00:00 UTC', 300.00),
('order_012', 'cust_I9J0', '2023-09-05 10:00:00 UTC', 250.00),

-- Orders for cust_K1L2
('order_013', 'cust_K1L2', '2023-09-18 11:00:00 UTC', 88.88),
('order_014', 'cust_K1L2', '2023-10-01 15:00:00 UTC', 111.11),

-- Orders for cust_M3N4
('order_015', 'cust_M3N4', '2023-11-01 10:30:00 UTC', 45.60),
('order_016', 'cust_M3N4', '2023-11-15 14:00:00 UTC', 80.00),
('order_017', 'cust_M3N4', '2023-12-01 11:00:00 UTC', 90.40),

-- Orders for cust_O5P6
('order_018', 'cust_O5P6', '2023-12-10 10:00:00 UTC', 15.00),

-- Orders for cust_Q7R8
('order_019', 'cust_Q7R8', '2024-01-10 14:00:00 UTC', 250.00),
('order_020', 'cust_Q7R8', '2024-01-20 11:00:00 UTC', 350.00),
('order_021', 'cust_Q7R8', '2024-02-05 09:00:00 UTC', 100.00),

-- Orders for cust_S9T0
('order_022', 'cust_S9T0', '2024-03-01 13:00:00 UTC', 50.00),
('order_023', 'cust_S9T0', '2024-03-15 10:00:00 UTC', 75.00),
('order_024', 'cust_S9T0', '2024-04-01 14:00:00 UTC', 100.00);

-- ############################################
