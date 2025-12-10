- 1.Display all details of EV charging stations.
select * from ev_charging_stations;
-- 3.List all distinct LGAs where charging stations are located.
select distinct(LGA) from ev_charging_stations;
-- 2.Show only the station name and address for all records.
select Station_name,Station_address from ev_charging_stations;
-- 4.Count the total number of charging stations in the dataset.
select count(Station_name) from ev_charging_stations;
-- 5.Retrieve the names of stations located in the suburb "Cessnock".
select Station_name from ev_charging_stations where  Suburbs="Cessnock";
-- 6.Show all stations that are marked as "Existing".
select Station_name from ev_charging_stations where  Status="Existing";
-- 7.Display stations that are open 24/7.
select Station_name from ev_charging_stations where Opening_hours="open 24/7";
-- 8.List the first 5 stations by station ID.
select Station_name from ev_charging_stations order by EV_Station_ID limit 5;
-- 9.Retrieve all stations with more than 2 plugs.
select Station_name from ev_charging_stations where Number_of_plugs >= 2;
-- 10.Find the number of stations per suburb.
select Suburbs,count(*) as station_count from ev_charging_stations group by Suburbs 
order by Station_name;
-- 11.Find the top 5 suburbs with the most charging stations.
select Suburbs,count(*) as station_count from ev_charging_stations group by Suburbs 
order by Station_name limit 5;
-- 12.Calculate the average number of plugs across all stations.
select avg(Number_of_plugs),Station_name from ev_charging_stations group by Station_name;
-- 13.Show all stations that provide Tesla charging points.

-- 14.	Identify all operators along with the number of stations they manage.
select Operator,count(*) as station_count from ev_charging_stations group by Operator order by station_count;

-- 15.	Find the maximum and minimum number of plugs available across stations.
select max(Number_of_plugs) as maximum_plug ,min(Number_of_plugs) as minimum_plug from ev_charging_stations;

-- 16.	Count the number of stations in each LGA and order them by station count.
select LGA,count(*) as station_count from ev_charging_stations group by LGA  order by station_count; 

-- 17.Retrieve all stations without specified opening hours.
select Station_name from ev_charging_stations where Opening_hours is NULL;

-- 18.	Identify suburbs that host multiple charging stations.
select Suburbs,count(*) as station_count from ev_charging_stations group by Suburbs 
having count(*) > 1 ;

-- 19.	List all unique combinations of station type and LGA.
select distinct Type,LGA  from ev_charging_stations order by Type,LGA; 

-- 20.Show the total number of plugs available in each postcode.
select Postcode,sum(Number_of_plugs) as totalplugs from ev_charging_stations 
group by Postcode
order by totalplugs;

-- 21.Categorize stations into “Small”, “Medium”, or “Large” hubs based on the number of plugs.
select 
case 
when Number_of_plugs > 5 then 'Large'
when Number_of_plugs between 2 and 4 then 'Medium'
when Number_of_plugs <=1 then 'Small'
end as hub_category
from ev_charging_stations;

-- 22.	Identify pairs of stations located in the same suburb.
select a.Suburbs, a.Station_name as station1, a.Station_name as station2
from ev_charging_stations a join ev_charging_stations b on a.Suburbs=b.Suburbs and a.Station_name < b.Station_name
order by a.Suburbs,station1,station2;

-- 23.	Use a CTE to calculate the number of stations per LGA, then find the top 3 LGAs.
with lga_count as (select LGA,count(*) as station_count from ev_charging_stations group by LGA)
select LGA,station_count from lga_count order by station_count desc limit 2;

-- 24.	Find stations that belong to LGAs with above-average station counts.
select Station_name,LGA,count(*) as station_count,avg(station_count) as avg_count from ev_charging_stations
group by Station_name,LGA
order by station_count,avg_count;

-- 25.	Extract the numeric part of Charger_capacities and compute average, min, and max charger capacity


-- 26.	Rank stations by number of plugs within each LGA.
select LGA,Station_name,Number_of_plugs, rank() over(partition by LGA order by Number_of_plugs) from ev_charging_stations;

-- 27.	For each LGA, find the top 2 suburbs with the most stations.
select LGA,Suburbs,count(*) as station_count from ev_charging_stations
 group by LGA,Suburbs
 having count(*) > 1
 order by station_count
  limit 2;
 
-- 28.	Compute a running total of plugs for each LGA.
select LGA,Station_name,Number_of_plugs,sum(Number_of_plugs) over(partition by LGA order by Station_name) as running_total
from ev_charging_stations order by LGA,Station_name,Number_of_plugs;

-- 29.	Classify operators as “Major” if they manage more than 10 stations, otherwise “Minor”.
select Operator , count(*) as station_count,
case 
when count(*) > 10 then 'Major'
else 'Minor'
end as opp
from ev_charging_stations
group by Operator
order by station_count;

-- 30.	Find the busiest station (highest plugs) in each LGA.
select LGA,max(Number_of_plugs) as highest_plugs from ev_charging_stations group by LGA
order by highest_plugs desc
limit 1;




