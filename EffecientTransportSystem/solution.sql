SELECT * FROM ftn_project.vehicles_traffic;

-- b. Analysis to Perform
-- Traffic Flow Analysis: Which road segments face the worst congestion (avg speed < 20 km/h during peak)?
select avg(v.speed) as avg_speed ,r.name from road_segments r join vehicles_traffic v 
on r.road_segment_id=v.road_segment_id
group by r.name,v.speed
having avg_speed <20;

-- Public Transport Load: Which bus/train routes are overcrowded and which are underutilized?
select p.route_id,avg(p.passenger_count) as avg_passenger, r.avg_kg_capacity
from public_transport_rides p join road_segments r on r.road_segment_id=p.route_id 
group by p.route_id,r.avg_kg_capacity
having avg(p.passenger_count) > r.avg_kg_capacity;

-- Accident Patterns: Correlation of accidents with road type, time of day, and weather.
select hour(a.date_time) as hour, count(*) as total_accidents,r.region
from accidents a join road_segments r on a.road_segment_id=r.road_segment_id
group by hour(a.date_time),r.region
order by total_accidents desc;

-- Fare & Revenue Trends:Total earnings from smart card payments, busiest hours for ticketing.
select sum(s.amount) as total_earnings, hour(p.timestamp) as hours
from smartcards s join public_transport_rides p
on s.ride_id=p.ride_id
group by hours
order by total_earnings desc
limit 1;

-- Sustainability: % of citizens using public transport vs private vehicles.
select 
case 
when vehicle_type in('Car','Bike') then 'private'
else 'public' end as transport_type,
count(vehicle_id) as total,
round(100.0 * count(vehicle_id)/(select count(*) from vehicles_traffic),3)as percentage
from vehicles_traffic
group by 
case 
when vehicle_type in('Car','Bike') then 'private'
else 'public' 
end
order by total desc;

-- Route Optimization: Identify alternate less-congested road segments between two hubs.
select r.name,r.region as hubs,avg(v.speed) as average_speed,count(v.vehicle_id) as total from road_segments r join vehicles_traffic v
on r.road_segment_id=v.road_segment_id
join public_transport_rides p on v.vehicle_type=p.vehicle_type 
where r.region in ('Industrial','Highway')
group by r.name,r.region
having avg(v.speed) > 25
order by average_speed asc
limit 2;

-- Standardize timestamps, vehicle categories, and route names.
update vehicles_traffic set vehicle_type=lower(vehicle_type);
update road_segments set name=lower(name);
update public_transport_rides set timestamp=str_to_date(timestamp,'%Y-%m-%d %H:%i:%s');
update public_transport_rides set vehicle_type=lower(vehicle_type);
update public_transport_rides set passenger_count=(select average_count from (select avg(passenger_count) as average_count
from public_transport_rides) as counts)
where passenger_count=NULL;

-- 4.Analysis (SQL Queries):
-- Find top 10 congested road segments.
select r.name,r.region,avg(v.speed) as avg_speed from road_segments r join vehicles_traffic v
on r.road_segment_id=v.road_segment_id 
group by r.name,r.region
having avg(v.speed)>20
order by avg_speed
limit 10;

-- Calculate average passenger load per route vs capacity.
select p.route_id,avg(p.passenger_count),r.avg_kg_capacity,(avg(p.passenger_count) / r.avg_kg_capacity) * 100 as passenger_load
from public_transport_rides p join road_segments r on p.route_id=r.road_segment_id
group by  p.route_id,r.avg_kg_capacity
order by passenger_load;

--  Find peak traffic hours using GROUP BY HOUR(timestamp).
select hour(timestamp) as hours,count(vehicle_id) as vehicle_count from vehicles_traffic 
group by hour(timestamp)
order by vehicle_count desc
limit 1;

-- Identify high-risk intersections by accident density.
select r.name,count(accident_id) as total_accidents from accidents a 
join road_segments r on r.road_segment_id=a.road_segment_id
group by  r.name
order by total_accidents desc;

-- Predict cost savings if 20% of private cars shift to buses.
select count(*) as total_private_vehicles,vehicle_type from vehicles_traffic 
group by vehicle_type;








