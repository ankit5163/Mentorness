use sql_coronavirus;
-- To avoid any errors, check missing value / null value 

-- Q1. Write a code to check NULL values
Select * from sql_coronavirus.`corona virus datasets` 
	where Province IS null or `Country/Region` is null or Latitude is null or Longitude is null or `Date` is null or Confirmed is null or Deaths is null or Recovered is null;

-- Q2. If NULL values are present, update them with zeros for all columns. 
-- no null values are present

-- Q3. check total number of rows
Select count(*) as Total_records_present 
	from sql_coronavirus.`corona virus datasets` ;
    
-- Q4. Check what is start_date and end_date
SELECT MIN(`Date`) AS Start_Date, MAX(`Date`) AS End_Date 
	FROM sql_coronavirus.`corona virus datasets`;
    
-- Q5. Number of month present in dataset
SELECT DISTINCT `month` AS Num_Months 
	FROM sql_coronavirus.`corona virus datasets`;
    
-- Q6. Find monthly average for confirmed, deaths, recovered
SELECT DISTINCT `month` AS Num_Months,avg(Confirmed),avg(Deaths),avg(Recovered) 
	FROM sql_coronavirus.`corona virus datasets` 
	group by `month`
    order by avg(Confirmed),avg(Deaths),avg(Recovered) ;

-- Q7. Find most frequent value for confirmed, deaths, recovered each month 
Select `month`,
	( Select confirmed from sql_coronavirus.`corona virus datasets` group by `confirmed`,monthname(str_to_date(`Date`, '%d-%m-%Y')) order by count(confirmed) desc limit 1 ) as confirmed_mode,
	( Select deaths from sql_coronavirus.`corona virus datasets` group by `Deaths`,monthname(str_to_date(`Date`, '%d-%m-%Y')) order by count(Deaths) desc limit 1) as death_mode,
	( Select recovered from sql_coronavirus.`corona virus datasets` group by `recovered`,monthname(str_to_date(`Date`, '%d-%m-%Y')) order by count(Recovered) desc limit 1) as recovered_mode
    from sql_coronavirus.`corona virus datasets`
    group by month
    order by month(`Date`);
    
-- Q8. Find minimum values for confirmed, deaths, recovered per year
	select year,min(confirmed),min(deaths),min(Recovered) from sql_coronavirus.`corona virus datasets`group by year;

-- Q9. Find maximum values of confirmed, deaths, recovered per year
	select year,max(confirmed),max(deaths),max(Recovered) from sql_coronavirus.`corona virus datasets`group by year;
    
-- Q10. The total number of case of confirmed, deaths, recovered each month
	select month,sum(confirmed),sum(deaths),sum(Recovered) from sql_coronavirus.`corona virus datasets`group by month
    order by month(`date`);

-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
	select count(*) as `total cases`, avg(confirmed) as `average confirmed`, variance(confirmed) as varience, stddev(confirmed) as `standard deviation`
    from sql_coronavirus.`corona virus datasets`;
    
-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )
	select count(*) as `total cases` , avg(deaths) as `average deaths`, variance(deaths) as varience, stddev(deaths) as `standard deviation`
    from sql_coronavirus.`corona virus datasets`
    ;

-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
select count(*) as `total cases`, avg(Recovered) as `average Recovered`, variance(Recovered) as varience, stddev(Recovered) as `standard deviation`
    from sql_coronavirus.`corona virus datasets`;
    
-- Q14. Find Country having highest number of the Confirmed case
select `Country/Region`,sum(confirmed) AS total_cases 
	from sql_coronavirus.`corona virus datasets` 
	group by `Country/Region` 
	order by total_cases desc
    Limit 5;
    
-- Q15. Find Country having lowest number of the death case
select `Country/Region`,sum(deaths) AS total_cases 
	from sql_coronavirus.`corona virus datasets` 
	group by `Country/Region` 
	order by total_cases asc
    Limit 5;
    
-- Q16. Find top 5 countries having highest recovered case
select `Country/Region`,sum(Recovered) AS total_cases 
	from sql_coronavirus.`corona virus datasets` 
	group by `Country/Region` 
	order by total_cases desc
    Limit 5;
    
