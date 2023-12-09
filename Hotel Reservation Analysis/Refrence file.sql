use sql_hotel;
select * from `hotel reservation dataset`;
drop table `hotel reservation dataset`;

# 1. What is the total number of reservations in the dataset?
	select count(*) as 'Total reservations' from `hotel reservation dataset`;

# 2. Which meal plan is the most popular among guests?
	SELECT type_of_meal_plan, COUNT(*) as plan_count
	FROM `hotel reservation dataset`
	GROUP BY type_of_meal_plan
	ORDER BY plan_count DESC
    limit 1;
    
# 3. What is the average price per room for reservations involving children?
	select no_of_children,avg(avg_price_per_room) as `avg price by no. of child`,(select avg(avg_price_per_room) from `hotel reservation dataset`) as `avg price overall irr to no. of child`
    from `hotel reservation dataset`
    group by no_of_children;

# 4. How many reservations were made for the year 20XX (replace XX with the desired year)?
	alter table `hotel reservation dataset` modify arrival_date date;
    SELECT year(`arrival_date`), COUNT(*) as plan_count
	FROM `hotel reservation dataset`
	GROUP BY year(`arrival_date`);

# 5. What is the most commonly booked room type?
    SELECT room_type_reserved, COUNT(*) AS booking_count
    FROM `hotel reservation dataset`
    GROUP BY room_type_reserved
    order by booking_count desc
    limit 1;

# 6. How many reservations fall on a weekend (no_of_weekend_nights > 0)?
	select count(*) as `reservations on weekend`
    from `hotel reservation dataset`
    where no_of_week_nights != 0;
    

# 7. What is the highest and lowest lead time for reservations?
	select max(lead_time), min(lead_time) 
    from `hotel reservation dataset`;

# 8. What is the most common market segment type for reservations?
	select market_segment_type,count(*) as total 
    from `hotel reservation dataset`
    group by market_segment_type
    order by total desc
    limit 1;

# 9. How many reservations have a booking status of "Confirmed"?
	select booking_status, count(*) as total
    from `hotel reservation dataset`
    group by booking_status
    having booking_status="Not_Canceled";

# 10. What is the total number of adults and children across all reservations?
	select sum(no_of_adults) as total_adults,sum(no_of_children) as total_children
    from `hotel reservation dataset`;

# 11. What is the average number of weekend nights for reservations involving children?
	select avg(no_of_weekend_nights)
    from `hotel reservation dataset`
    where no_of_children <> 0;

# 12. How many reservations were made in each month of the year?
	select monthname(arrival_date),year(arrival_date), count(*) as total
    from `hotel reservation dataset`
    group by monthname(arrival_date),year(arrival_date)
    order by month(arrival_date) asc;
    
# 13. What is the average number of nights (both weekend and weekday) spent by guests for each roomtype?
	select room_type_reserved as room_type,avg(no_of_weekend_nights),avg(no_of_week_nights)
    from `hotel reservation dataset`
    group by room_type_reserved
    order by room_type_reserved;

# 14. For reservations involving children, what is the most common room type, and what is the average price for that room type?
	select room_type_reserved,avg_price_per_room ,count(*) as total_count
    from `hotel reservation dataset`
    where no_of_children > 0
    group by room_type_reserved
    order by total_count desc
    limit 1;

# 15. Find the market segment type that generates the highest average price per room.
	select market_segment_type,avg_price_per_room
    from `hotel reservation dataset`
    group by market_segment_type
    having max(avg_price_per_room)
    order by avg_price_per_room desc
    limit 1;