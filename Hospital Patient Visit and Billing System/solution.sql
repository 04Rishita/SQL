SELECT * FROM ftn_project.hospital_patient_visit;

-- UPDATE OPERATION
-- Increase all paid_amount by 5% for “Insurance” payments
update hospital_patient_visit set paid_amount= paid_amount * 1.05 
where payment_method="Insurance" ;  
-- Correct any visit records where age < 1 → set to NULL
update hospital_patient_visit set age = NULL where age <1;

-- DELETE OPERATION
-- Delete records where billing_amount = 0
delete from hospital_patient_visit where billing_amount=0;

-- Delete visits by patients marked as “invalid” (manually set one)
select * from hospital_patient_visit where patient_name = "Invalid";
update hospital_patient_visit set patient_name="Invalid" where patient_id="PAT2034" ;
delete from hospital_patient_visit where patient_name="Invalid";

-- Total revenue, paid revenue, outstanding revenue
select sum(billing_amount) as revenue,
sum(paid_amount) as paid_revenue ,
sum(billing_amount - paid_amount) as outstanding_revenue
from hospital_patient_visit;

-- Revenue by doctor
select doctor_name,sum(billing_amount) as revenue_by_doctor
from hospital_patient_visit
group by doctor_name;

-- Revenue by department
select department,sum(billing_amount) as revenue_by_department 
from hospital_patient_visit
group by department;

-- Top 10 patients by spending
select patient_id,patient_name,sum(paid_amount) as patients_spending 
from hospital_patient_visit
group by patient_id,patient_name;


-- 11.Grouping & Filtering	
-- Average billing per visit type (OPD/IPD/Emergency)
select visit_type,avg(billing_amount) as average_billing 
from hospital_patient_visit
group by visit_type;

-- Count of visits requiring follow-up
select follow_up_flag,count(*) as count_visits 
from hospital_patient_visit where follow_up_flag=1
group by follow_up_flag;

-- Monthly revenue trend
select monthname(str_to_date(visit_date,'%d-%m-%Y')) as months, round(sum(billing_amount),2) as revenue
from hospital_patient_visit 
group by month(str_to_date(visit_date,'%d-%m-%Y')),
monthname(str_to_date(visit_date,'%d-%m-%Y'))
order by  revenue desc;

-- 12.JOINS
-- List all visits with patient name + doctor name + department
select p1.visit_id,p1.patient_name ,p1.doctor_name ,p1.department from hospital_patient_visit p1 join 
hospital_patient_visit p2 on p1.visit_id=p2.visit_id;

-- Get all procedures performed along with billing amounts
select p1.procedure_code,p1.procedure_description,p1.billing_amount from hospital_patient_visit p1 join
hospital_patient_visit p2 on p1.procedure_code=p2.procedure_code;

-- 13.SUBQUERIES
-- Patients whose visit count is above average visit count
select patient_name,count(visit_id) as visit_count from hospital_patient_visit 
group by patient_name
having count(visit_id) > (select avg(visit_count) from 
(select count(visit_id) as visit_count from hospital_patient_visit
group by patient_name ) as sub);

-- Visits where billing is above patient’s own average billing
select visit_type ,billing_amount from hospital_patient_visit as h
where billing_amount > (select avg(billing_amount) from hospital_patient_visit
where patient_name=h.patient_name);

-- Doctors with revenue higher than average doctor revenue
select doctor_name,sum(billing_amount) as revenue from hospital_patient_visit
group by doctor_name
having sum(billing_amount) >(select avg(revenue) from (select sum(billing_amount) as revenue from hospital_patient_visit
group by doctor_name ) as h );

-- Running total of daily revenue
select visit_date,sum(billing_amount),sum(sum(billing_amount))  over(order by visit_date) as running_total
from hospital_patient_visit
group by visit_date
order by visit_date;

-- Ranking doctors based on total revenue
select doctor_name,sum(billing_amount) as revenue, rank() over(order by sum(billing_amount)) as ranking
from hospital_patient_visit
group by doctor_name;

-- Lag/Lead analysis of daily revenue for trend detection
select visit_date,sum(billing_amount) as dalily_revnue,lag(sum(billing_amount)) over(order by visit_date)as previous_day_revenue,
lead(sum(billing_amount)) over(order by visit_date) as next_day
from hospital_patient_visit
group by visit_date
order by visit_date;

-- 15.Create Views
-- Monthly_Billing_Summary view.
create view monthly_billing_summary as 
select year(str_to_date(visit_date,'%d-%m-%Y')) as year, month(str_to_date(visit_date,'%d-%m-%Y')) as date,
sum(billing_amount) as monthly_revenue from hospital_patient_visit
group by year(str_to_date(visit_date,'%d-%m-%Y')),month(str_to_date(visit_date,'%d-%m-%Y')) ;
select * from monthly_billing_summary;

-- Doctor_Performance view (total visits, revenue, avg billing)
create view performance_view as 
select doctor_name,count(visit_id) as total_visits, sum(billing_amount) as revenue,avg(billing_amount) as avg_billing
from hospital_patient_visit
group by doctor_name;
select * from performance_view;

-- High_Value_Patients view (billing > ₹X threshold)
create view high_value_patients as 
select patient_name,sum(billing_amount) as total_billing from hospital_patient_visit
group by  patient_name;
select * from high_value_patients where total_billing > 2000;

-- 16.Stored Procedures / Functions
DELIMITER //
create procedure settle_payment (in
h_visit_id varchar(10),p_paid_amount int)
begin
update hospital_patient_visit set paid_amount= paid_amount+ p_paid_amount
where visit_id=h_visit_id;
end //
DELIMITER ;
call settle_payment ('VIS20001',300)

DELIMITER //
create procedure add_followup(in h_visit_id varchar(10))
begin
update hospital_patient_visit set follow_up_flag=1
where visit_id=h_visit_id;
end//
DELIMITER //
 call add_followup('VIS20001');


-- 17.Trigger
-- On UPDATE of billing_amount → insert into audit_log table
create table ftn_project.audit_log (id int auto_increment primary key,visit_id varchar(20),old_billing_amt int, new_billing_amount int,
changed_at datetime);	

DELIMITER //
create trigger billing_update
after update on hospital_patient_visit
for each row
begin
insert into audit_log(visit_id,old_billing_amt,new_billing_amount,changed_at) 
values(new.visit_id,ifnull(old.billing_amount,0),ifnull(new.billing_amount,0),now());
end//

update hospital_patient_visit set billing_amount=5000 where visit_id='VIS20003';
select * from audit_log where visit_id='VIS20003';


-- On INSERT of a new visit → auto-calculate outstanding_amount
alter table hospital_patient_visit
add column outstanding_amount int;

DELIMITER //
create trigger new_vists
before insert on hospital_patient_visit
for each row
begin
   set new.outstanding_amount =
       coalesce(new.billing_amount,0) - coalesce(new.paid_amount,0);
end//
DELIMITER ;

select trigger_name, event_manipulation, action_timing, event_object_table
from information_schema.triggers
where event_object_table = 'hospital_patient_visit';

insert into hospital_patient_visit(
patient_id ,visit_id,visit_date,patient_name,age,gender,doctor_id,
doctor_name,department,diagnosis_code,diagnosis_description,procedure_code,
procedure_description,prescription_id,medication,med_quantity,med_unit_price,
med_total_cost,procedure_cost,other_charges,billing_amount,
insurance_provider,payment_method,paid_amount,visit_type,
follow_up_flag,clinic_location,city,state,country
)
values(
"PAT1357","VIS20501","2023-09-27","Rishita",20,"Female","D839",
"ABC","ENT","A11","HAPPY","P90","X-Ray","RX1000",
"Amlodipine",22,45.9,100,0,20.0,250,
"healthplus","UPI",100,"OPD",0,
"central clinic","ahmedabad","gujarat","India"
);
select billing_amount, paid_amount, outstanding_amount
from hospital_patient_visit
where visit_id = "VIS20501";


