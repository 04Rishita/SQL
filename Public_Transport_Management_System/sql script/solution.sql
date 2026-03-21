create table vehicles(vehicle_id int primary key,
vehicle_type varchar(50) not null, capacity int not null, manufacture_year year not null);
select * from vehicles;

create table stations(station_id int primary key, station_name varchar(50) not null,
zone varchar(50) not null,station_type varchar(50) not null);
select * from stations;

create table routes(route_id int primary key, source_station varchar(50) not null, destination_station varchar(50) not null,
distance_km int,route_type varchar(50));
select * from routes;

create table commuters(commuter_id int primary key,commuter_name varchar(50) not null,age int not null,
gender varchar(50) not null,city_zone varchar(50) not null,card_type varchar(50));
select * from commuters;

create table trips(trip_id int primary key ,commuter_id int not null,route_id int not null, trip_date date,
start_time time not null, end_time time not null,fare int, foreign key (commuter_id) references commuters(commuter_id),
foreign key (route_id) references routes(route_id));
select * from trips;

create table routes_assignment(assignment_id int primary key ,route_id int not null, vehicle_id int not null,
foreign key (route_id) references routes(route_id) , foreign key (vehicle_id) references vehicles(vehicle_id));
select * from routes_assignment;

create table maintenance(maintenance_id int primary key , vehicle_id int not null, maintenance_date date,
cost int,issue_type varchar(50) not null,foreign key (vehicle_id) references vehicles(vehicle_id));
select * from maintenace;

-- 3.Restrict route_type to Metro/Bus.
alter table routes modify column route_type enum('Metro','Bus');

-- 4.Ensure fare > 0.
alter table trips add constraint check_fare check (fare > 0);

-- 5.Add index on trip_date
create index trip_dt_indx on trips(trip_date);
show index from trips;

-- 6.Insert 20 new commuters.
insert into commuters (commuter_id, commuter_name, age, gender, city_zone, card_type) VALUES
(6,  'Aarav Sharma',23, 'M', 'East',  'Monthly Pass'),
(7,  'Priya Mehta',30, 'F', 'South', 'Pay Per Ride'),
(8,  'Rohan Verma', 34, 'M', 'West',  'Pay Per Ride'),
(9,  'Sneha Iyer', 29, 'F', 'North', 'Monthly Pass'),
(10,  'Kiran Patil',45, 'M', 'East',  'Student Pass'),
(11,  'Ananya Nair', 19, 'F', 'South', 'Student Pass'),
(12,  'Vikram Joshi', 38, 'M', 'West',  'Monthly Pass'),
(13,  'Pooja Reddy', 6, 'F', 'North', 'Pay Per Ride'),
(14,  'Arjun Gupta', 31, 'M', 'East',  'Monthly Pass'),
(15, 'Divya Pillai', 23, 'F', 'South', 'Student Pass'),
(16, 'Rahul Desai', 41, 'M', 'West',  'Monthly Pass'),
(17, 'Meera Bhat', 36, 'F', 'North', 'Pay Per Ride'),
(18, 'Suresh Kumar', 52, 'M', 'East',  'Senior Pass'),
(19, 'Neha Singh', 27, 'F', 'South', 'Monthly Pass'),
(20, 'Amit Chaudhary',33, 'M', 'West',  'Pay Per Ride'),
(21, 'Riya Kapoor',21, 'F', 'North', 'Student Pass'),
(22, 'Manish Tiwari',47, 'M', 'East',  'Senior Pass'),
(23, 'Kavya Menon', 25, 'F', 'South', 'Monthly Pass'),
(24, 'Deepak Yadav', 39, 'M', 'West',  'Pay Per Ride'),
(25, 'Simran Kaur', 30, 'F', 'North', 'Monthly Pass');
select * from commuters;

-- 7.Update vehicle capacity by +10%.
update vehicles set capacity = capacity * 1.10;
select * from vehicles;

-- 8.Delete trips before 2023.
select * from trips where trip_date <'2023-01-01';
delete from trips where trip_date < '2023-01-01';

-- 9.Change card_type of senior citizens.
update commuters set card_type='Senior Pass' where age >= 45;

-- 10.Add new station "Kurla".
insert into stations(station_id,station_name,zone,station_type) values (106,'Kurla','South','Metro');
select * from stations;

-- 11.List all metro stations.
select * from stations where station_type='Metro';

-- 12.Show commuters using Monthly Pass.
select * from commuters where card_type='Monthly Pass';

-- 13.Find total trips.
select count(*) from trips;

-- 14.Show distinct city zones.
select distinct city_zone from commuters;

-- 15.Average fare
select avg(fare) from trips;

-- 16.Total revenue per day.
select trip_date ,sum(fare) as total_revenue from trips
group by trip_date
order by trip_date;

-- 17.Revenue per route.
select route_id, sum(fare) as total_revenue from trips
group by route_id;

-- 18.Average trip duration.
select avg(start_time) as duration from trips;

-- 19.Total maintenance cost.
select sum(cost) as maintenance_cost from maintenace;

-- 20.Most used route.
select route_type,count(route_type) as counts from routes
group by route_type
order by counts desc
limit 1;

-- 21.Show commuter with route info.
select c.commuter_name,c.age,c.gender,c.city_zone,c.card_type,r.source_station,r.destination_station,r.distance_km,r.route_type
from commuters c join trips t on c.commuter_id=t.commuter_id 
join routes r on r.route_id=t.route_id;

-- 22.	Route with station names
select r.route_id,s1.station_name as source_station,s2.station_name as destination_station,r.distance_km,r.route_type
from routes r join stations s1 on r.source_station=s1.station_id
join stations s2 
on r.destination_station=s2.station_id;

-- 23.Vehicle assigned to each route.
select v.vehicle_id,v.vehicle_type,r.route_id,r.assignment_id from vehicles v join routes_assignment r on
v.vehicle_id=r.vehicle_id ;

-- 24.Trips with vehicle type.
select t.trip_id,t.trip_date,t.start_time,t.end_time,t.fare,v.vehicle_type,v.capacity from trips t 
join routes_assignment r on t.route_id=r.route_id join vehicles v on v.vehicle_id=r.vehicle_id;

-- 25.Vehicles never used.
select vehicle_id,vehicle_type,capacity,manufacture_year from vehicles where vehicle_id not in
(select vehicle_id from routes_assignment);

-- 26.Routes with revenue above average.
select r.route_id,r.source_station,r.destination_station,r.distance_km,r.route_type,t.fare from routes r 
join trips t on r.route_id=t.route_id 
group by r.route_id
having t.fare > (select avg(fare) from trips);

-- 27.Commuters spending more than average.
select c.commuter_id,c.commuter_name,avg(t.fare)as avg_spending from commuters c join trips t on c.commuter_id=t.commuter_id
group by c.commuter_id,c.commuter_name
having avg(t.fare) > (select avg(fare) from trips);

-- 28.Most expensive maintenance vehicle.
select v.vehicle_id,v.vehicle_type,max(m.cost) as maximum_cost 
from vehicles v join maintenace m on v.vehicle_id=m.vehicle_id;

-- 29.Stations with highest traffic.
select r.source_station , count(*) as traffic from trips t
join routes r on r.route_id=t.route_id
group by r.source_station
order by traffic desc
limit 1;

-- 30.Routes longer than city average.
select c.city_zone,r.route_id,r.distance_km from commuters c join trips t on c.commuter_id=t.commuter_id 
join routes r on r.route_id=t.route_id
where r.distance_km > (select avg(distance_km) from routes);

-- 31.	Fare category:•	< 30 → Cheap •30–50 → Normal •50 → Expensive
select trip_id, fare,
case 
when fare > 30 then 'Cheap'
when fare between 30 and 50 then 'Normal'
else 'Expensive'
end as fare_category
from trips;
	
-- 32.	Trip duration:•	< 30 min → Short•	30–60 → Medium•	60 → Long
select trip_id,start_time,end_time,
case
when timestampdiff(minute,start_time,end_time) < 30 then 'short'
when timestampdiff(minute,start_time,end_time) between 30 and 60 then 'Medium'
else 'long'
end as duration_category
from trips;

-- 33.vw_commuter_profile (name, total_trips, total_spent)
create view vw_commuter_profile as 
select c.commuter_name,count(t.trip_id) as total_trip,sum(t.fare) as total_spent
from commuters c join trips t on c.commuter_id=t.commuter_id
group by c.commuter_name;
select * from vw_commuter_profile;

-- 34.	vw_route_performance (route_id, total_trips, revenue)
create view vw_route_performance as 
select route_id,count(trip_id) as total_trips,sum(fare) as revenue
from trips
group by route_id;
select * from vw_route_performance;

-- 35.	Rank routes by revenue.
select route_id,sum(fare) as revenue, rank () over(order by sum(fare) desc) as rank_route
from trips
group by route_id;

-- 36.Top 5 commuters by spending.
select c.commuter_id,sum(t.fare) as total from commuters c join trips t on c.commuter_id=t.commuter_id
group by c.commuter_id 
order by total desc
limit 5;

-- 37.Maintenance cost ranking.
select maintenance_id,maintenance_date,cost, rank() over(order by cost desc) as cost_rank
from maintenace
group by maintenance_id
order by cost desc;

-- 38.Which zone generates max revenue?
select c.city_zone,sum(t.fare) as revenue from commuters c join trips t on c.commuter_id=t.commuter_id
group by c.city_zone
order by revenue desc
limit 1;

-- 39.	Which vehicle type is most cost efficient?
select v.vehicle_type,SUM(t.fare) as total_revenue,SUM(m.cost) as total_maintenance_cost,
(SUM(t.fare) / SUM(m.cost)) as efficiency_ratio
from Vehicles v
join routes_assignment ra on v.vehicle_id = ra.vehicle_id
join routes r on ra.route_id = r.route_id
join trips t on r.route_id = t.route_id
left join maintenace m on v.vehicle_id = m.vehicle_id
group by v.vehicle_type
order by efficiency_ratio desc
limit 1;

-- 40.	Which route needs more vehicles?
SELECT t.route_id, COUNT(t.trip_id) AS total_trips,count(ra.vehicle_id)as total_vechicle
from routes r join routes_assignment ra on r.route_id=ra.route_id 
join trips t on r.route_id=t.route_id
GROUP BY r.route_id
ORDER BY total_trips DESC
LIMIT 1;