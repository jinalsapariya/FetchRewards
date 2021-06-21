# FetchRewards

Take home Assessment


## First: Review Existing Unstructured Data and Diagram a New Structured Relational Data Model

I have used MySQL Workbench for creating the ERD. File name: ERDFetchRewards.pdf

Data Source: Received 3 files 
  1. Users.json
  2. Receipts.json
  3. Brands.json 
  
I used jupyter notebook for analyzing the unstructured data. After exploration, I found that Receipt.json have nested receiptItemList thus, I have used transformation to separate the receiptItemList from receipts and store it in a different table. 


## Second: Write a query that directly answers a predetermined question from a business stakeholder

For the data load, I have developed transformation scripts which converts the unstructured json to csv files. I have attached the transformation code in the DataAnalysis.ipynb python file.

I have used MySQL Workbench for the loading the csv dumps and have performed all the given queries and have attached the Queries.sql file in the folder. 

## Third: Evaluate Data Quality Issues in the Data Provided

For Evaluating the data quality issues, I have created a python notebook DataAnalysis.ipynb. 
Findings: 
  1. From the above analysis, we found that lot of NULL data is present in the Users, Receipts, ReceiptItemList and Brands table.
  2. Duplicate values are present for User_id, Thus we cannot keep user_id as a primary key in the Users table as it is not unique
  3. Date Format is not present in Date atrributes 
 
## Fourth: Communicate with Stakeholders, Email/Slack Message

I have attahed the word document - FetchRewardsEmail.docx which explains few business related questions and data quality issues that were discovered during initial stages of exploration of data.

