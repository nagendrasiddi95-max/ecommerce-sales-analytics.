# E-commerce Sales Analytics

## Project Overview

This project analyzes sample e-commerce order data to explore sales
performance, product demand, customer spending, and city-wise revenue.
SQL is used to prepare and analyze the data, while Power BI is used to
present the results in an interactive dashboard.

## Objectives

-   Calculate total revenue, quantity sold, and number of orders.
-   Identify top-performing products.
-   Compare spending across customers.
-   Analyze revenue by city, product category, and month.
-   Build an interactive Power BI dashboard with slicers and KPI cards.

## Tools Used

-   **MySQL** --- database creation and SQL analysis
-   **Power BI Desktop** --- dashboard and data visualization
-   **DAX** --- measures for revenue, quantity, and orders

## Database Structure

The database contains three tables:

  Table         Purpose
  ------------- ---------------------------------------------
  `Customers`   Customer name and city
  `Products`    Product name, category, and unit price
  `Orders`      Order date, customer, product, and quantity

Relationships: - `Orders.customer_id` references
`Customers.customer_id` - `Orders.product_id` references
`Products.product_id`

## Key SQL Analysis

-   Overall sales KPIs
-   Top three products by revenue
-   Customer spending analysis
-   City-wise revenue
-   Category-wise revenue and units sold
-   Monthly revenue trends

## Dashboard Features

-   KPI cards for total revenue and quantity sold
-   City slicer
-   Revenue by city chart
-   Revenue by customer chart
-   Interactive filtering

## How to Run

1.  Open `SQL_Scripts.sql` in MySQL Workbench.
2.  Run the script to create the `ecommerce` database, create tables,
    and insert the sample data.
3.  Run the analysis queries at the end of the script.
4.  In Power BI Desktop, connect to the MySQL database named
    `ecommerce`.
5.  Load `Customers`, `Products`, and `Orders`, then build or refresh
    the dashboard.

## Validation Results

For the included sample data, with no report filters applied, expected
totals are:

-   **Total orders:** 15
-   **Total units sold:** 27
-   **Total revenue:** 228,400

These values are based on the sample data included in the SQL script. If
you change the data or apply slicers, your dashboard totals may differ.

## Project Files

-   `README.md` --- project documentation
-   `SQL_Scripts.sql` --- database setup, sample data, and analysis
    queries
-   `Ecommerce_Sales_Analytics.pbix` --- add your Power BI report file
    here

## Author

Data Analytics Portfolio Project
