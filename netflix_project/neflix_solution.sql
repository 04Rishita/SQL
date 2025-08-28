use netflix;

Select * from netflix;

Select * from netflix limit 5;

Select distinct(show_id) from Netflix;

Select
distinct(title) from netflix
where release_year >2020;

Select
distinct(title) from netflix
where release_year > 2020 and title='Blood & Water' or release_year < 2021
and title='Kota Factory'and not country= 'India';

Select
distinct(title) as name from netflix
order by title;

Select
min(release_year) as min_release_year,
max(release_year) as max_release_year,
count(distinct release_year) as count_of_release_year,
round(avg(release_year),2) as avg_of_all_release_years,
sum(release_year) as avg_of_all_release_years
from netflix
limit 1;

Select distinct ' country that End with ia :- '|| country as Value from netflix
where country like"%ia";

Select distinct 'country that Starts with ia :- '|| country as Value from netflix
where country like"ia%";

Select distinct 'country that has ia :- '|| country as Value from netflix
where country like "%ia%";


Select distinct 'country that starts and ends with a :- '|| country as Value from netflix
where country like "a%a%";

select * from netflix
where country in ('India','United States','Austrailia')
order by country asc;

select
n1.show_id as Show_idtable1,
n2.type as Show_idTable2,
n2.title as Showtable2
from netflix n1
join netflix n2 on n1.show_id = n2.show_id;

select * from netflix where country='India'
union all
select * from netflix where country='United States';

select
sum(case when country='India' then 1 else 0 end) as Shows_in_India,
sum(case when country='United States' then 1 else 0 end) as
Shows_in_United_States,
sum(case when country='South Africa' then 1 else 0 end) as
Shows_in_South_Africa
from netflix;

select distinct(a.title) from (select * from netflix) a;
select coalesce(release_year,0) as first_non_zero_value from netflix
limit 1;
select cast(release_year as float) as first_non_zero_value from netflix;

select
title,
release_year,
case when release_year=lag(release_year) over (order by release_year asc)
then 1 else 0 end as Back_to_Back
from netflix
order by release_year asc;

select
title,type,director,
ROW_NUMBER() OVER (ORDER BY
title asc) as row_number
from netflix
group by title
order by title asc;

select a.value from (

Select

distinct ' country that End with ia :- '|| country as Value,

DENSE_RANK() OVER (ORDER BY country asc) as rank from netflix

where country like"%ia"

)a
where rank=1
union all
select a.value from (

Select

distinct ' first country that starts with a :- '|| country as Value,

DENSE_RANK() OVER (ORDER BY country asc) as rank from netflix

where country like"a%"

)a
where rank=1
union all
select a.value from (
Select

distinct ' country that has a and minimum length 4 :- '|| country as Value,

DENSE_RANK() OVER (ORDER BY country asc) as rank from netflix

where country like"a__%"

)a
where rank=1;


with b as (

select

a.country,

a.count_of_shows,

row_number () over (order by a.count_of_shows desc) as rank

from

(

select

count(distinct title) as count_of_shows,

country

from netflix

group by country

) a

)

select country as country_most_shows from b

where b.rank=1;


select s.year,avg(s.duration) as avg_duration,max(s.duration) as long_duration,(select title from songs 
where year=s.year order by duration desc  limit 1) as longest_song,
(select artist_name from songs where s.year=year order by duration desc limit 1) as artist_longest_song from songs s where s.year>0 
group by s.year
order by s.year;

