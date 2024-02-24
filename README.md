# Airbnb Data Warehouse Project

## Project Overview

This project focuses on constructing a comprehensive data warehouse for Airbnb listings in Barcelona, providing a robust framework for data storage, organization, and analysis. The objective was to centralize data related to Airbnb properties, including listings, bookings, reviews, and host information, to facilitate in-depth analytical insights and decision-making processes.

The project involved several key stages:

1. **Data Scraping**: Utilizing Python scripts to scrape Airbnb data.
2. **Data Loading**: Employing pandas and SQLAlchemy to load the scraped data into a PostgreSQL database, setting the foundation for further processing and analysis.
3. **Data Profiling**: Conducting an initial assessment of the data using the Airbnb Data Dictionary as a reference to identify data quality issues and understand the dataset's structure and content.
4. **Data Warehouse Design**: Developing a data warehouse schema tailored to the needs of Airbnb data analysis, featuring two fact tables for reviews and bookings, alongside dimension tables for dates, listings, reviewers, locations, and hosts.
5. **Data Transformation**: Applying SQL statements to transform the raw data, ensuring it is properly formatted and aligned with the data warehouse schema.
6. **Data Loading into Data Warehouse**: Executing SQL scripts with insert statements to populate the data warehouse, making the data ready for analysis.

![Data Warehouse Schema](schema.png)

## Data Sources

- **Airbnb Dataset**: The primary dataset for this project was obtained from Inside Airbnb ([Get the Data](http://insideairbnb.com/get-the-data/)), which provides detailed data on Airbnb listings and activities.
- **Airbnb Data Dictionary**: The [Airbnb Data Dictionary](https://docs.google.com/spreadsheets/d/1iWCNJcSutYqpULSQHlNyGInUvHg2BoUGoNRIGa6Szc4/edit#gid=1322284596) was instrumental in understanding the dataset's attributes and guiding the data profiling stage.

## Technologies Used

- **Python**: For data scraping and initial data processing.
- **Pandas & SQLAlchemy**: For data manipulation and loading the data into PostgreSQL.
- **PostgreSQL**: As the relational database management system to store the initial datasets.
- **SQL**: For data transformation, schema creation, and data loading processes in the data warehouse.

## Data Warehouse Structure

The data warehouse is designed with analytical queries in mind, structured around two fact tables:
- **Reviews Fact Table**: Captures details about reviews made by guests.
- **Bookings Fact Table**: Contains information on bookings.

The supporting dimension tables are:
- **Date Dimension**: Holds information on dates to enable time-based analyses.
- **Listings Dimension**: Contains detailed information about the listings.
- **Reviewers Dimension**: Stores information about the reviewers.
- **Location Dimension**: Captures geographical information about the listings.
- **Hosts Dimension**: Contains details about the hosts of the listings.
