/*=====================================================================================================
TASK 4: RESTAURANT CHAINS
Dataset: Zomato Restaurant Dataset (Kaggle)
Goal: Identify restaurant chains present in the dataset and analyze their rating and popularity(votes)
======================================================================================================*/

create DATABASE zomato_db;

USE zomato_db;

create TABLE Restaurants (
Restaurant_ID BIGINT,
Restaurant_Name VARCHAR(255),
Country_Code INT,
City VARCHAR(100),
Address VARCHAR(500),
Locality VARCHAR(255),
Locality_Verbose VARCHAR(255),
Longitude FLOAT,
Latitude FLOAT,
Cuisines VARCHAR(500),
Avg_Cost_For_Two INT,
Currency VARCHAR(50),
Has_Table_Booking VARCHAR(10),
Has_Online_Delivery VARCHAR(10),
Is_Delivery_Now VARCHAR(10),
Switch_to_order_Menu VARCHAR(10),
Price_Range INT,
Aggregate_Rating DECIMAL(3,1),
Rating_Color VARCHAR(50),
Rating_Text VARCHAR(50),
Votes INT
);

/*Step 1: Confirm the dataloaded correctly*/
select count(*) as total_rows from zomato;
select Top 5 * from zomato;

/* Step 2: Count how many locations each restaurant name has
A restaurant name that appears more than once across different rows*/

select Top 20 Restaurant_Name, count(*) as location_count
from zomato
Group by Restaurant_Name
order by Location_count desc;

/* Step 3: To confirmed chains(2+ locations),I calculated their
average rating and total votes across all branches.*/

select
	Restaurant_Name,
	COUNT(*) as location_count,
	AVG(Aggregate_rating) as avd_rating,
	SUM(Votes) as total_votes
	from zomato
	group by Restaurant_Name
	having COUNT(*) > 1
	order by location_count desc;

/*FINDINGS SUMMARY
----------------------------------------------------------------------------------------------------------------
-Restaurant chains are clearly present:top chains include
Cafe Coffee Day(83 location), Dominos Pizza (79), Subway (63),Green Chick Chop (51), McDonald's (48).

- More locations does NOT mean a hiher rating:
	Cafe Coffee Day(83 location) -> avg rating only 2.42
	Barbeque Nation -> 26 locations, avg rating 4.35 (highest) and 28,142 total votes (highest by far)

-Baskin Robbins has the lowest average rating (1.86) in the group of major chains, despite moderate popularity.
CONCLUSION: Scale (number of branches) and customer satisfaction (rating) are not directly related in this data.*/





