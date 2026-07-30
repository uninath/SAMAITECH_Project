/*======================================================================================================
TASK 5: VOTE ANALYSIS
Dataset: Zomato Restaurant Datatset(Kaggle)
Goal: Identify restaurants with the highest and lowest number of votes and determine whether votes
	  correlate with rating.
======================================================================================================*/
USE zomato_db
/* Step 1: Highest-voted restaurants*/

select Top 10 Restaurant_Name, City, Votes
from zomato
order by votes desc;

/* Step 2: Lowest-voted restaurants*/

select Top 10 Restaurant_Name, City, Votes
from zomato
order by votes asc

/* Step 3: How many restaurants have zero votes at all?*/

select COUNT(*) as zero_vote_restaurants
from zomato
where Votes = 0;

/* Step 4: Votes vs Rating correlation
Restaurants are grouped into votes "buckests" so we can see 
whether average rating increases as vote count increases.*/

select
	case
		when votes = 0 then '0 votes'
		when votes between 1 and 100 then '1-100'
		when votes between 101 and 500 then '101-500'
		when votes between 501 and 1000 then '501-1000'
		else '1000+'
	end as vote_bucket,
	AVG(Aggregate_rating) as avg_rating,
	COUNT(*) as num_restaurants
from zomato
group by
	case
		when votes = 0 then '0 votes'
		when votes between 1 and 100 then '1-100'
		when votes between 101 and 500 then '101-500'
		when votes between 501 and 1000 then '501-1000'
		else '1000+'
	end
order by MIN(votes);

/*==================================================================================================
FINDINGS SUMMARY
-Highest voted: Toit (Bangalore, 10,934 votes), followed by Truffles (9,667) and Hauz Khas Social (7,931).
Bangalore appears 4 times in th top 10, suggesting a high-engagement dining market.
-Lowest voted: 1,094 restaurant (-11.5% of the dataset) have exactly 0 votes, meaning no customer feedback recorded yet.
-Clear positive correlation between votes and rating:
0 votes ->avg rating 0.00 (n = 1,094)
1-100   ->avg rating 2.60 (n = 5,652)
101-500 ->avg rating 3.74 (n = 2,100)
501-1000->avg rating 4.08 (n = 409)
1000+ ->avg rating 4.20 (n = 296)

CONCLUSION: Restaurants with more votes consistently have higher average ratings 
-- popularity and satisfaction move together in this dataset.
===================================================================================================*/