SELECT * FROM ftn.listings;
-- 2. Write a query to show names from Listings table
select name from listings;

-- 3.Write a query to fetch total listings from the listings table
select count(*) as total_listings from listings;

-- 4.Write a query to fetch total listing_id from the booking_details table
select count(listing_id) from booking_details; 

-- 5.Write a query to fetch host ids from listings table
select host_id from listings;

-- 6.Write a query to fetch all unique host name from listings table
select distinct(host_name) from listings;

-- 7. Write a query to show all unique neighbourhood_group from listings table
select distinct(neighbourhood_group) from listings;

-- 8.Write a query to show all unique neighbourhood from listings table
select distinct(neighbourhood) from listings;

-- 9.Write a query to fetch unique room_type from listings tables
select distinct(room_type) from listings;

-- 10.Write a query to show all values of Brooklyn & Manhattan from listings tables
select * from listings where neighbourhood_group in ('Brooklyn' ,'Manhattan');

-- 11.Write a query to show maximum price from booking_details table
select max(price) as maximum_price from booking_details;

-- 12.Write a query to show minimum price from booking_details table
select min(price) as minimum_price from booking_details;

-- 13.Write a query to show average  price from booking_details table
select avg(price) as average_price from booking_details;

-- 14.Write a query to show minimum value of minimum_nights from booking_details table
select min(minimum_nights)  from booking_details;

-- 15.Write a query to show maximum value of minimum_nights from booking_details table
select max(minimum_nights)  from booking_details;

-- 16. Write a query to show average availability_365
select avg(availability_365) from booking_details;

-- 17.Write a query to show id , availability_365 and all availability_365 values greater than 300
select listing_id,availability_365 from booking_details where availability_365 > 300;

-- 18,Write a query to show count of id where price is in between 300 to 400
select count(*) from booking_details where price between 300 and 400;

-- 19.Write a query to show count of id where minimum_nights spend is less than 5
select count(*) from booking_details where minimum_nights < 5;

-- 20.Write a query to show count where minimum_nights spend is greater than 100
select count(*) from booking_details where minimum_nights > 100;

-- 21.Write a query to show all data of listings & booking_details
select * from listings,booking_details;

-- 22.Write a query to show host name and price
select l.host_name,b.price from listings l join booking_details b on l.id=b.listing_id;

-- 23.Write a query to show room_type and price
select l.room_type,b.price from listings l join booking_details b on l.id=b.listing_id;

-- 24.Write a query to show neighbourhood_group & minimum_nights spend
select l.neighbourhood_group,b.minimum_nights from listings l join booking_details b on l.id=b.listing_id;

-- 25.Write a query to show neighbourhood & availability_365
select l.neighbourhood,b.availability_365 from listings l join booking_details b on  l.id=b.listing_id;

-- 26.Write a query to show total price by neighbourhood_group
select sum(b.price) as total_price,l.neighbourhood_group from listings l join booking_details b on l.id=b.listing_id
group by l.neighbourhood_group
order by total_price;

-- 27.Write a query to show maximum price by neighbourhood_group
select max(b.price) as maximum_price,l.neighbourhood_group from listings l join booking_details b on l.id=b.listing_id
group by l.neighbourhood_group
order by maximum_price desc ;

-- 28.Write a query to show maximum night spend by neighbourhood_group
select max(b.minimum_nights) as maximum_nights,l.neighbourhood_group from listings l join booking_details b on l.id=b.listing_id
group by l.neighbourhood_group
order by maximum_nights desc ;

-- 29.Write a query to show maximum reviews_per_month spend by neighbourhood
select max(b.reviews_per_month) as maximum_reviews,l.neighbourhood_group from listings l join booking_details b on l.id=b.listing_id
group by l.neighbourhood_group
order by maximum_reviews;	

-- 30.Write a query to show maximum price by room type
select max(b.price) as maximum_price,l.room_type from listings l join booking_details b on l.id=b.listing_id 
group by l.room_type
order by maximum_price;

-- 31.Write a query to show average number_of_reviews by room_type
select avg(b.number_of_reviews) as avg_review,l.room_type from listings l join booking_details b on l.id=b.listing_id 
group by l.room_type
order by avg_review;

-- 32.Write a query to show average price by room type
select avg(b.price) as avg_price,l.room_type from listings l join booking_details b on l.id=b.listing_id 
group by l.room_type
order by avg_price;

-- 33.Write a query to show average night spend by room type
select avg(b.minimum_nights) as avg_night_spend,l.room_type from listings l join booking_details b on l.id=b.listing_id 
group by l.room_type
order by avg_night_spend;

-- 34.Write a query to show average price by room type but average price is less than 100
select avg(b.price) as avg_price,l.room_type from listings l join booking_details b on l.id=b.listing_id 
group by l.room_type
having avg(b.price) < 100;

-- 35.Write a query to show average night by neighbourhood and average_nights is greater than 5
select avg(b.minimum_nights) as avg_night,l.neighbourhood from listings l join booking_details b on l.id=b.listing_id 
group by l.room_type
having  avg(b.minimum_nights) > 5;

-- 36.Write a query to show all data from listings where price is greater than 200 using sub-query.
select * from listings l where l.id in (select b.listing_id from booking_details b join listings l on l.id=b.listing_id
where b.price > 200);

-- 37.Write a query to show all values from booking_details table where host id is 314941 using sub-query.
select * from booking_details b where b.listing_id in(select l.id from listings l join booking_details b on l.id=b.listing_id
where l.host_id=314941);

-- 38.Find all pairs of id having the same host id, each pair coming once only.
select a.id as id1 ,b.id as id2,a.host_id from listings a join listings b on a.host_id=b.host_id and a.id < b.id;

-- 39.Write an sql query to show fetch all records that have the term cozy in name
select * from listings where name like '%cozy%';

-- 40.Write an sql query to show price, host id, neighbourhood_group of manhattan neighbourhood_group
select b.price,l.host_id,l.neighbourhood_group from listings l join booking_details b on l.id=b.listing_id where l.neighbourhood_group='manhattan';

-- 41.Write a query to show id , host name, neighbourhood and price but only for Upper West Side & Williamsburg neighbourhood, also make sure price is greater than 100
select b.price,l.host_id,l.neighbourhood from listings l join booking_details b on l.id=b.listing_id where
l.neighbourhood in ('Upper West Side','Williamburg') and b.price > 100;

-- 42.Write a query to show id , host name, neighbourhood and price for host name Elise and neighbourhood is Bedford-Stuyvesant
select l.id,l.host_name,l.neighbourhood,b.price from listings l join booking_details b on l.id=b.listing_id  where l.host_name='Elise' and 
l.neighbourhood='Bedford-Stuyvesant';

-- 43.Write a query to show host_name, availability_365,minimum_nights only for 100+ availability_365 and minimum_nights
select l.host_name,b.availability_365,b.minimum_nights from booking_details b join listings l on b.listing_id=l.id where 
b.availability_365 > 100 and b.minimum_nights > 100;

-- 44.Write a query to show to fetch id , host_name , number_of_reviews, and reviews_per_month but show only that records where number of reviews are 500+ and review per month is 5+
select l.id,l.host_name,b.number_of_reviews,b.reviews_per_month from listings l join booking_details b on b.listing_id=l.id where 
b.number_of_reviews > 500 and b.reviews_per_month > 5 ;

-- 45.Write a query to show neighbourhood_group which have most total number of review
select l.neighbourhood_group,sum(b.number_of_reviews)as total_reveiws  from listings l join booking_details b on l.id=b.listing_id group by l.neighbourhood_group
order by total_reveiws desc
limit 1;

-- 46.Write a query to show host name which have most cheaper total price
select l.host_name,sum(b.price) as cheap_price from booking_details b join listings l on b.listing_id=l.id group by l.host_name
order by cheap_price asc
limit 1;

-- 47.Write a query to show host name which have most costly total price
select l.host_name,sum(b.price) as costly_price from booking_details b join listings l on b.listing_id=l.id group by l.host_name
order by costly_price desc
limit 1;

-- 48.Write a query to show host name which have max price using sub-query
select l.host_name,b.price from listings l join booking_details b on l.id=b.listing_id
where b.price=(select max(price) from booking_details);

-- 49.Write a query to show neighbourhood_group where price is less than 100
select l.neighbourhood_group,b.price from listings l join booking_details b on l.id=b.listing_id where b.price < 100;

-- 50.Write a query to find max price, average availability_365 for each room type and order in ascending by maximum price.
select max(b.price) as maximum_price,avg(b.availability_365) as avg_availability,l.room_type from listings l join booking_details b
on l.id=b.listing_id 
group by l.room_type
order by maximum_price asc;


