CREATE DATABASE Jomato;
USE Jomato;

---------------------------------Tasks to be performed:------------------------------------
--------------1. Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. 
-------------Eg: ‘Quick Chicken Bites’.
--------Answer 1
CREATE FUNCTION dbo.StuffChicken
(
    @RestaurantName NVARCHAR(MAX)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    RETURN STUFF(@RestaurantName, 6, 0, ' Chicken');
END;

SELECT dbo.StuffChicken('Quick Bites') AS Result;





---------------------2. Use the function to display the restaurant name and 
---------------------cuisine type which has the maximum number of rating.
----------Answer 2
SELECT TOP 1
    dbo.StuffChicken(RestaurantName) AS RestaurantName,
    CuisinesType AS CuisineType,
    Rating
FROM Jomato
WHERE Rating IS NOT NULL
ORDER BY Rating DESC;





---------------3. Create a Rating Status column to display the rating as ‘Excellent’ if it has more the 4
---------------start rating, ‘Good’ if it has above 3.5 and below 5 star rating, ‘Average’ if it is above 3
---------------and below 3.5 and ‘Bad’ if it is below 3 start rating.
--------Answer 3
SELECT
    RestaurantName,
    Rating,
    CASE
        WHEN Rating > 4 THEN 'Excellent'
        WHEN Rating > 3.5 AND Rating <= 4 THEN 'Good'
        WHEN Rating > 3 AND Rating <= 3.5 THEN 'Average'
        WHEN Rating <= 3 THEN 'Bad'
        ELSE 'Not Rated'
    END AS RatingStatus
FROM Jomato;





-----------------------4. Find the Ceil, floor and absolute values of the rating column and 
-----------------------display the current date and separately display the year, month_name and date.
-----------Answer 4 
SELECT
    Rating,
    CEILING(Rating) AS Ceil_Rating,
    FLOOR(Rating) AS Floor_Rating,
    ABS(Rating) AS Absolute_Rating,
    GETDATE() AS TodayDate,
    YEAR(GETDATE()) AS Year,
    DATENAME(MONTH, GETDATE()) AS Month_Name,
    DAY(GETDATE()) AS Date_Value
FROM Jomato;





-------------------5. 5. Display the restaurant type and total average cost using rollup.
---------Answer 5
SELECT
    RestaurantType,
    AVG(AverageCost) AS Total_Average_Cost
FROM Jomato
GROUP BY ROLLUP(RestaurantType);

