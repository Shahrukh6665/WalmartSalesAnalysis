# WalmartSalesAnalysis

## About

This project's primary objective is to delve into the Walmart Sales dataset, with the goal of gaining insights into the top-performing branches and products, understanding the sales trends across various product categories, and analyzing customer behavior. The ultimate aim is to identify opportunities for enhancing and optimizing sales strategies. The dataset used for this analysis was sourced from the Kaggle Walmart Sales Forecasting Competition.

"In this recruitment competition, participants are provided with historical sales data encompassing 45 Walmart stores situated in diverse regions. Each store is comprised of multiple departments, and participants are tasked with forecasting the sales for each department within each store. Adding complexity to the challenge, the dataset includes selected holiday markdown events, which are known to impact sales. However, predicting which departments are affected and the magnitude of their influence proves to be a challenging aspect of this task." - source

## Purposes Of The Project

The major aim of thie project is to gain insight into the sales data of Walmart to understand the different factors that affect sales of the different branches.

## Adout Data
The dataset was obtained from the Kaggle Walmart Sales Forecasting Competition. This dataset contains sales transactions from a three different branches of Walmart, respectively located in Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows:

Column	Description	Data Type
invoice_id	Invoice of the sales made	VARCHAR(30)
branch	Branch at which sales were made	VARCHAR(5)
city	The location of the branch	VARCHAR(30)
customer_type	The type of the customer	VARCHAR(30)
gender	Gender of the customer making purchase	VARCHAR(10)
product_line	Product line of the product solf	VARCHAR(100)
unit_price	The price of each product	DECIMAL(10, 2)
quantity	The amount of the product sold	INT
VAT	The amount of tax on the purchase	FLOAT(6, 4)
total	The total cost of the purchase	DECIMAL(10, 2)
date	The date on which the purchase was made	DATE
time	The time at which the purchase was made	TIMESTAMP
payment_method	The total amount paid	DECIMAL(10, 2)
cogs	Cost Of Goods sold	DECIMAL(10, 2)
gross_margin_percentage	Gross margin percentage	FLOAT(11, 9)
gross_income	Gross Income	DECIMAL(10, 2)
rating	Rating	FLOAT(2, 1)
