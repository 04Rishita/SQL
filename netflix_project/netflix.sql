SELECT * FROM ftn.netflixdata;
select * from ftn.netflixdata limit 5;
select distinct(show_id)from netflixdata;
select distinct(title) from netflixdata where release_year>2020;
select distinct(title) from netflixdata where release_year>2020 AND title="Blood & Water" OR release_year<2021 AND title="Kota Factory" AND country!="India" ;
select distinct(title) as name from netflixdata order by title;
select min(release_year) as min_release,max(release_year),count(distinct release_year) as count_year,round(avg(release_year),2) as avg_year,sum(release_year) as avg_sum from netflixdata limit 1;
select * from netflixdata where country in('India','United States','Australia')order by country asc;
select title,release_year,case when release_year=lag(release_year) over(order by release_year asc)then 1 else 0 end as back_to_back from netflixdata order by release_year;
select n1.show_id as show_idtable1,n2.type as show_idtable2,n2.title as showtable2 from netflixdata n1 join netflixdata n2 on n1.show_id=n2.show_id; 
select sum(case when country='India' then 1 else 0 end) as showsin_India,
sum(case when country='United States' then 1 else 0 end) as showsin_US,
sum(case when country='South Africa' then 1 else 0 end) as showsin_South_africa
from  netflixdata;

select distinct(a.title) from (select * from netflixdata) a;

select coalesce(release_year,0) as first_non_zero_value from netflixdata
limit 1;

select cast(release_year as float) as first_non_zero_value from netflixdata;

select title,release_year, case when release_year=lag(release_year)over (order by release_year asc)
then 1 else 0 end as back_to_back from netflixdata order by release_year asc;

select title,type,director,row_number() over(order by title asc) as rn from netflixdata group by title order by title asc;

select distinct country as  value from netflixdata where country like "%ia";
select distinct country as  value from netflixdata where country like "%ia%";
select distinct country as  value from netflixdata where country like "a%a%";
select count(*) i from netflixdata where type='TV show';
select count(*) as total_movies from netflixdata where type='Movie';

-- group query
select type,count(*) as total_comedy,
case when count(*)>=1000 then 'high'
when count(*) between 500 and 999 then 'moderate'
else 'low'
end as label
from netflixdata where listed_in like '%Comedies%'
group by type;


SELECT 
    title,
    type,
    country,
    release_year,
    rating,
    description,
    CASE
        WHEN release_year < 2010 THEN 'Old'
        WHEN release_year BETWEEN 2010 AND 2019 THEN 'Recent'
        ELSE 'Latest'
    END AS era
FROM netflixdata
WHERE 
	country IN ('India', 'United States')    
    AND release_year BETWEEN 2015 AND 2021
    AND description LIKE '%life%'
    AND director IS NOT NULL
ORDER BY release_year DESC;




