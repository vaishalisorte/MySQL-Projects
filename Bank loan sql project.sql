use `sqlproject`;
select * from finance10;
select count(*) from finance10;
select count(*) from finance20;

-- KPI 1 *Year wise loan amount Stat*---
select year(issue_d) as "Year", sum(loan_amnt) as "Loan Amount" from finance10
 group by year
 order by year desc
 
 -- KPI 2 *Grade and sub grade wise revol_bal*---
Select f1.grade, f1.sub_grade, sum(f2.revol_bal) as revolving_bal
from finance10 as f1 inner join finance20 as f2
on f1.id = f2.id
group by f1.grade, f1.sub_grade
order by grade

-- KPI3  *Total Payment for Verified Status Vs Total Payment for Non Verified Status*---
select f1.verification_status, sum(f2.total_pymnt) as total_payment
from finance10 as f1 inner join finance20 as f2
on f1.id = f2.id
group by f1.verification_status;

-- KPI4  *State wise and last_credit_pull_d wise loan status*---
select addr_state, loan_status, count(loan_status)
from finance10
group by addr_state, loan_status;

-- KPI5  *Home ownership Vs last payment date stats*--- 
select year(f2.last_pymnt_d) payment_year, monthname(f2.last_pymnt_d) payment_month, f1.home_ownership, count(f1.home_ownership) home_ownership
from finance10 as f1 inner join finance20 as f2
on f1.id = f2.id
group by year(f2.last_pymnt_d), monthname(f2.last_pymnt_d), f1.home_ownership
order by home_ownership;

select fn1.home_ownership, year(last_pymnt_d) as payment_year
from finance10 as fn1 join finance20 as fn2
on fn1.id = fn2.id
where home_ownership in ('rent', 'mortgage', 'own')
group by fn1.home_ownership;