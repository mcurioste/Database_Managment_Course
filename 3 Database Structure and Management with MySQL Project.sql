-- THE FOLLOWING CODE WILL BE USED TO CREATE THE DATABASE.
-- TASKS WILL BE FOUND AFTER THE DATABASE CREATION.

CREATE DATABASE IF NOT EXISTS LITTLE_LEMON;

USE LITTLE_LEMON;

CREATE TABLE IF NOT EXISTS CUSTOMERS(CUSTOMER_ID INT NOT NULL PRIMARY KEY
					  ,FULL_NAME VARCHAR(100) NOT NULL
                      ,PHONE_NUMBER INT NOT NULL UNIQUE);
                      
CREATE TABLE IF NOT EXISTS BOOKINGS (BOOKING_ID INT
					  ,BOOKING_DATE DATE
                      ,TABLE_NUMBER INT
                      ,NUMBER_OF_GUESTS INT
                      ,CUSTOMER_ID INT);

CREATE TABLE IF NOT EXISTS COURSES(COURSE_NAME VARCHAR(255) PRIMARY KEY
								 ,COST DECIMAL(4,2));


SHOW TABLES;

SHOW COLUMNS FROM BOOKINGS;

INSERT INTO CUSTOMERS (CUSTOMER_ID, FULL_NAME, PHONE_NUMBER) VALUES
	(1, "Vanessa McCarthy", 0757536378), 
	(2, "Marcos Romero", 0757536379), 
	(3, "Hiroki Yamane", 0757536376), 
	(4, "Anna Iversen", 0757536375),
	(5, "Diana Pinto", 0757536374),
	(6, "Altay Ayhan", 0757636378), 
	(7, "Jane Murphy", 0753536379), 
	(8, "Laurina Delgado", 0754536376), 
	(9, "Mike Edwards", 0757236375),
	(10, "Karl Pederson", 0757936374);  
    
-- DELETE FROM CUSTOMERS 
    
INSERT INTO BOOKINGS (BOOKING_ID, BOOKING_DATE, TABLE_NUMBER, NUMBER_OF_GUESTS, CUSTOMER_ID) VALUES
	(10, '2021-11-10', 7, 5, 1), 
	(11, '2021-11-10', 5, 2, 2), 
	(12, '2021-11-10', 3, 2, 4),
	(13, '2021-11-11', 2, 5, 5), 
	(14, '2021-11-11', 5, 2, 6), 
	(15, '2021-11-11', 3, 2, 7),
	(16, '2021-11-11', 3, 5, 1), 
	(17, '2021-11-12', 5, 2, 2), 
	(18, '2021-11-12', 3, 2, 4),
	(19, '2021-11-13', 7, 5, 6), 
	(20, '2021-11-14', 5, 2, 3), 
	(21, '2021-11-14', 3, 2, 4);  
    
-- DELETE FROM BOOKINGS;

INSERT INTO COURSES(COURSE_NAME, COST) VALUES
("Greek salad", 15.50), 
("Bean soup", 12.25), 
("Pizza", 15.00), 
("Carbonara", 12.50), 
("Kabasa", 17.00), 
("Shwarma", 11.30);

SELECT * FROM BOOKINGS;

-- DELETE FROM COURSES

SHOW TABLES;

/*
TODO// Task 1: Filter data using the WHERE clause and logical operators.

Create SQL statement to print all records from Bookings table for the following bookings dates 
using the BETWEEN operator: 2021-11-11, 2021-11-12 and 2021-11-13. 
*/
SHOW COLUMNS FROM BOOKINGS;

SELECT * 
FROM BOOKINGS
WHERE BOOKING_DATE BETWEEN '2021-11-11' AND '2021-11-13'; 

/*
TODO// TASK2: Create a JOIN query.

Create a JOIN SQL statement on the Customers and Bookings tables. 
The statement must print the customers full names and related bookings IDs from the date 2021-11-11.
*/
SHOW COLUMNS FROM CUSTOMERS;
SHOW COLUMNS FROM BOOKINGS;

SELECT FULL_NAME
	  ,BOOKING_ID
FROM CUSTOMERS
INNER JOIN BOOKINGS ON BOOKINGS.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID
WHERE BOOKING_DATE = '2021-11-11';

/*
TODO// TASK 3: Create a GROUP BY query.

Create a SQL statement to print the bookings dates from Bookings table. 
The statement must show the total number of bookings placed on each of the printed dates using the GROUP BY BookingDate
*/
SHOW COLUMNS FROM BOOKINGS;

SELECT BOOKING_DATE, COUNT(BOOKING_DATE) BOOKING_COUNT
FROM BOOKINGS
GROUP BY BOOKING_DATE;


/*
TODO// Create a REPLACE statement.

Create a SQL REPLACE statement that updates the cost of the Kabsa course from $17.00 to $20.00. 
The expected output result should be the same as that shown in the following screenshot:
*/
SHOW COLUMNS FROM COURSES;

REPLACE INTO COURSES (COURSE_NAME, COST)
VALUES('Kabasa', 20.00);
-- OR
REPLACE INTO COURSES 
SET COURSE_NAME = 'Kabasa', COST = 20.00;

SELECT * FROM COURSES;

/*
TODO// TASK 5:Create constraints

Create a new table called "DeliveryAddress" in the Little Lemon database with the following columns and constraints:

ID: INT PRIMARY KEY
Address: VARCHAR(255) NOT NULL
Type: NOT NULL DEFAULT "Private"
CustomerID: INT NOT NULL FOREIGN KEY referencing CustomerID in the Customers table
*/
CREATE TABLE IF NOT EXISTS ADDRESS (ID INT PRIMARY KEY
								   ,ADDRESS VARCHAR(255) NOT NULL
                                   ,ADDRESS_TYPE VARCHAR(50) NOT NULL DEFAULT "Private"
                                   ,CUSTOMER_ID INT NOT NULL 
                                   ,FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS(CUSTOMER_ID));
                                   
SHOW TABLES;

SHOW COLUMNS FROM ADDRESS;

/*
TODO: TASK 6: Create an ALTER TABLE statement

Create a SQL statement that adds a new column called 'Ingredients' to the Courses table.

Ingredients: VARCHAR(255)
*/

ALTER TABLE COURSES
ADD INGREDIENTS VARCHAR (255);

SHOW COLUMNS FROM COURSES;

/*
TODO// TASK 7: Create a subquery

Create a SQL statement with a subquery that prints the full names of all customers who made bookings 
in the restaurant on the following date: 2021-11-11.
*/
SHOW COLUMNS FROM CUSTOMERS;
SHOW COLUMNS FROM BOOKINGS; 

SELECT FULL_NAME 
FROM CUSTOMERS
WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID
						  FROM BOOKINGS
                          WHERE BOOKING_DATE = '2021-11-11');

/*
TODO// Task 8: Create a virtual table

Create the "BookingsView" virtual table to print all bookings IDs, bookings dates and the number of guests for 
bookings made in the restaurant before 2021-11-13 and where number of guests is larger than 3.
*/
SHOW COLUMNS FROM BOOKINGS;

CREATE VIEW BOOKINGSVIEW AS (
SELECT BOOKING_ID, BOOKING_DATE, NUMBER_OF_GUESTS
FROM BOOKINGS
WHERE 1=1
	AND BOOKING_DATE < '2021-11-13'
	AND NUMBER_OF_GUESTS > 3
);

SELECT * FROM BOOKINGSVIEW;

/*
TODO Task 9: Create a stored procedure

Create a stored procedure called 'GetBookingsData'. The procedure must contain one date parameter called "InputDate". 
This parameter retrieves all data from the Bookings table based on the user input of the date.

After executing the query, call the "GetBookingsData" with '2021-11-13' as the 
input date passed to the stored procedure to show all bookings made on that date. 
*/
SHOW COLUMNS FROM BOOKINGS;

CREATE PROCEDURE GETBOOKINGSDATA (INPUT_DATE DATE)
SELECT *
FROM BOOKINGS
WHERE BOOKING_DATE = INPUT_DATE;

CALL GETBOOKINGSDATA('2021-11-13');

/*
TODO Task 10: Use the String function

Create a SQL SELECT query using appropriate MySQL string function to list "Booking Details" including booking ID, 
booking date and number of guests. The data must be listed in the same format as the following example:

ID: 10, 
Date: 2021-11-10, 
Number of guests: 5 
*/

SELECT CONCAT('ID: ',BOOKING_ID, ', Date: ',BOOKING_DATE,', Number of guests', NUMBER_OF_GUESTS)
FROM BOOKINGS;