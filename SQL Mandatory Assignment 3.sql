CREATE DATABASE Jomato;
USE Jomato;

----------------------------Tasks to be performed:----------------------------------
-------------1. Create a stored procedure to display the restaurant name, type and cuisine 
-------------where the table booking is not zero.
-------Answer 1
CREATE PROCEDURE GetRestaurantDetails
AS
BEGIN
    SELECT
        RestaurantName,
        RestaurantType,
        cuisinesType
    FROM Jomato
    WHERE TableBooking <> 0;
END;

EXEC GetRestaurantDetails;





---------------------2. Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. 
---------------------Check the result and rollback it.
--------Answer 2
-- Start the transaction
BEGIN TRANSACTION;

-- Update Cafe to Cafeteria
UPDATE Jomato
SET CuisinesType = 'Cafeteria'
WHERE CuisinesType = 'Cafe';

-- Check the result after update
SELECT * FROM Jomato
WHERE CuisinesType = 'Cafeteria';

-- Rollback the transaction
ROLLBACK TRANSACTION;





--------------------3. Generate a row number column and find the top 5 areas with the highest rating of
--------------------restaurants.
--------Answer 3
SELECT TOP 5
    ROW_NUMBER() OVER (ORDER BY Rating DESC) AS RowNumber,
    localAddress,
    RestaurantName,
    Rating
FROM Jomato
ORDER BY Rating DESC;





-------------------4. Use the while loop to display the 1 to 50.
------Answer 4
DECLARE @i INT = 1;

WHILE @i <= 50
BEGIN
    PRINT @i;
    SET @i = @i + 1;
END;





------------------5. Write a query to Create a Top rating view to store the generated top 5 highest 
------------------rating of restaurants.
-------Answer 5
CREATE VIEW TopRating
AS
SELECT TOP 5
    RestaurantName,
    RestaurantType,
    CuisinesType,
    LocalAddress,
    Rating
FROM Jomato
ORDER BY Rating DESC;

SELECT *
FROM TopRating;





----------------------6. Create a trigger that give an message whenever a new record is inserted.
--------Answer 6
-----Create the trigger
CREATE TRIGGER trg_NewRestaurant
ON Jomato
AFTER INSERT
AS
BEGIN
    PRINT 'New restaurant record has been inserted successfully.';
END;

-------Test the trigger
INSERT INTO Jomato
(
    OrderID,
    RestaurantName,
    RestaurantType,
    Rating,
    No_of_Rating,
    AverageCost,
    OnlineOrder,
    TableBooking,
    CuisinesType,
    Area,
    LocalAddress,
    Delivery_time
)
VALUES
(
    30000,
    'Test Restaurant',
    'Casual Dining',
    4.5,
    100,
    500,
    1,
    1,
    'North Indian',
    'BTM',
    'BTM Layout',
    30
);

