# Music Store Database Analysis

## Overview

This project involves analyzing a music store database using PostgreSQL and SQL. The analysis includes performing queries of various complexities—ranging from basic to advanced levels—to extract meaningful insights from the data.

## Database Schema

The database consists of several tables, including:

- **artist**: Stores information about artists.
- **album**: Stores information about albums. Each album is linked to an artist.
- **track**: Stores information about tracks. Each track is linked to an album.
- **genre**: Stores information about genres.
- **customer**: Stores information about customers.
- **invoice**: Stores information about invoices. Each invoice is linked to a customer.
- **invoice_line**: Stores information about individual items in an invoice. Each invoice line is linked to an invoice and a track.

## Setup

To set up the database and run the queries, follow these steps:

1. **Install PostgreSQL**:
   - Download and install PostgreSQL from the official website: [PostgreSQL Downloads](https://www.postgresql.org/download/)

2. **Create the Database**:
   - Create a new database in PostgreSQL.
   - Load the provided SQL dump file into the database to create the necessary tables and populate them with data.

3. **Connect to the Database**:
   - Use a PostgreSQL client (like pgAdmin, DBeaver, or the `psql` command-line tool) to connect to your database.



## Conclusion

This project demonstrates how to perform various levels of data analysis on a music store database using PostgreSQL and SQL. By executing these queries, we can extract valuable insights about customer behavior, sales trends, and popular genres and artists. This analysis can help inform business decisions and improve overall operations of the music store.

Feel free to explore and modify the queries to suit your specific needs or to gain deeper insights into the data.
