# Construct_postgreSQL

Use code and data to construct PostgreSQL database on PC.
1. Download all csv files in data folder. Save it in user defined /path/.
2. Download PostgreSQL from https://www.postgresql.org/download/ if you use windows,
please download from https://www.postgresql.org/download/windows/
3. Find pgAdmin4 in windows, right click Database to use it to
create a database. Or you can use the default database
called postgres.
4. Please remember your password and port name, host name.
5. Create table use SQL codes. Codes are saved in code folder
with .txt file according to table names. To create table, go
Servers  PostgreSQL 9.6  Databases  postgres (or your
own database name) Schemas public Tables right
click and select Query Tool (Attention, don’t click Create
table!!!)
6.By copy and paste codes in each txt files to the query page
(see picture 3) and click the lightning icon, table will be
created.
7. Open Rstudio (download from https://www.rstudio.com/)
also, you need to download R to use Rstudio. Open
database_construction_nov_22.R, change working
directory, password, dbname, host, port and user to your
own name. If you don’t have package RPostgreSQL,
RMySQL and dplyr, please use command
install.packages(“ ”) in Rstudio to install them.
8. Then, just run the .r file line by line, the database with data
downloaded from here will be constructed on your
computer.
