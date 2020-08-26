#creating a schema named 'assignment' and then using the 'table data import wizard' as part of mysql workbench to import data

use assignment; #using the 'assignment database'

drop table if exists Bajaj1;     

# creating derived table bajaj1 containing closing price of the stock , short term and long term moving avg of close price
create table  Bajaj1(constraint PK_date primary key(`date`)) 
as select `Date`,`Close Price` ,
round(avg(`Close Price`) over ( order by year(`Date`), 
	month(`Date`) , day(`Date`) rows 19 preceding ), 2) as '20 Day MA',
round(avg(`Close Price`) over ( order by year(`Date`), 
	month(`Date`) , day(`Date`) rows 49 preceding ), 2) as '50 Day MA'
from `Bajaj auto`;

drop table if exists Eicher1;

# creating derived table eicher1 containing closing price of the stock , short term and long term moving avg of close price
create table  Eicher1(constraint PK_date primary key(`date`))
as select `Date`,`Close Price` ,
round(avg(`Close Price`) over ( order by year(`Date`), 
	month(`Date`) , day(`Date`) rows 19 preceding ), 2) as '20 Day MA',
round(avg(`Close Price`) over ( order by year(`Date`), 
	month(`Date`) , day(`Date`) rows 49 preceding ), 2) as '50 Day MA'
from `eicher motors`;

drop table if exists Hero1;

# creating derived table hero1 containing closing price of the stock , short term and long term moving avg of close price
create table  Hero1(constraint PK_date primary key(`date`))
as select `Date`,`Close Price` ,
round(avg(`Close Price`) over ( order by year(`Date`), 
	month(`Date`) , day(`Date`) rows 19 preceding ), 2) as '20 Day MA',
round(avg(`Close Price`) over ( order by year(`Date`), 
	month(`Date`) , day(`Date`) rows 49 preceding ), 2) as '50 Day MA'
from `hero motocorp`;

drop table if exists Infosys1;

# creating derived table infosys1 containing closing price of the stock , short term and long term moving avg of close price
create table  Infosys1(constraint PK_date primary key(`date`))
as select `Date`,`Close Price` ,
round(avg(`Close Price`) over ( order by year(`Date`), 
	month(`Date`) , day(`Date`) rows 19 preceding ), 2) as '20 Day MA',
round(avg(`Close Price`) over ( order by year(`Date`), 
	month(`Date`) , day(`Date`) rows 49 preceding ), 2) as '50 Day MA'
from infosys;

drop table if exists Tcs1;

# creating derived table tcs1 containing closing price of the stock , short term and long term moving avg of close price
create table  Tcs1(constraint PK_date primary key(`date`))
as select `Date`,`Close Price` ,
round(avg(`Close Price`) over ( order by year(`Date`), 
	month(`Date`) , day(`Date`) rows 19 preceding ), 2) as '20 Day MA',
round(avg(`Close Price`) over ( order by year(`Date`), 
	month(`Date`) , day(`Date`) rows 49 preceding ), 2) as '50 Day MA'
from tcs;

drop table if exists Tvs1;

# creating derived table tvs1 containing closing price of the stock , short term and long term moving avg of close price
create table Tvs1(constraint PK_date primary key(`date`))
as select `Date`,`Close Price` ,
round(avg(`Close Price`) over ( order by year(`Date`), 
	month(`Date`) , day(`Date`) rows 19 preceding ), 2) as '20 Day MA',
round(avg(`Close Price`) over ( order by year(`Date`), 
	month(`Date`) , day(`Date`) rows 49 preceding ), 2) as '50 Day MA'
from `tvs motors`;



drop table if exists `master table`;

#creating a master table containing the date and close prices of all 6 stocks

create table  `master table`(constraint PK_date primary key(`date`))
as select `Date` , b.`Close Price` as Bajaj , t.`Close Price` as TCS ,tv.`Close Price` as TVS,
		i.`Close Price` as Infosys , e.`Close Price` as Eicher , h.`Close Price` as Hero
from bajaj1 b 
inner join eicher1 e using (`Date`)
inner join hero1 h using (`Date`)
inner join infosys1 i using (`Date`)
inner join tcs1 t using(`Date`)
inner join tvs1 tv using(`Date`);



# When the shorter-term moving average crosses above the longer-term moving average, it is a signal to BUY, as it indicates that the trend is shifting up. This is known as a Golden Cross.
# On the opposite when the shorter term moving average crosses below the longer term moving average, it is a signal to SELL, as it indicates the trend is shifting down. It is sometimes referred to as the Death Cross.

# Lets create a table Bajaj2 containing information of close price and 'signal' indicating whether to buy a stock or not on a respective day

drop table if exists Bajaj2;

create table  Bajaj2(constraint PK_date primary key(`date`))
as select `Date`, `Close Price` , 
( case 
	when row_number() over w < 50 THEN 'INFO NOT AVAILABLE'
	when `20 Day MA` > `50 Day MA` and lag(`20 Day MA`) over w < lag(`50 Day MA`) over w THEN 'BUY'
		when `20 Day MA` < `50 Day MA` and lag(`20 Day MA`) over w > lag(`50 Day MA`) over w THEN 'SELL'
		else 'HOLD' end) as `Signal`
from  Bajaj1
window w as (order by `Date`);

drop table if exists Eicher2;

# Lets create a table Eicher2 containing information of close price and 'signal' indicating whether to buy a stock or not on a respective day

create table  Eicher2(constraint PK_date primary key(`date`))
as select `Date`, `Close Price` , 
( case 
	when row_number() over w < 50 THEN 'INFO NOT AVAILABLE'
	when `20 Day MA` > `50 Day MA` and lag(`20 Day MA`) over w < lag(`50 Day MA`) over w THEN 'BUY'
		when `20 Day MA` < `50 Day MA` and lag(`20 Day MA`) over w > lag(`50 Day MA`) over w THEN 'SELL'
		else 'HOLD' end) as `Signal`
from  Eicher1
window w as (order by `Date`);

drop table if exists Hero2;

# Lets create a table Hero2 containing information of close price and 'signal' indicating whether to buy a stock or not on a respective day

create table  Hero2(constraint PK_date primary key(`date`))
as select `Date`, `Close Price` , 
( case 
	when row_number() over w < 50 THEN 'INFO NOT AVAILABLE'
	when `20 Day MA` > `50 Day MA` and lag(`20 Day MA`) over w < lag(`50 Day MA`) over w THEN 'BUY'
		when `20 Day MA` < `50 Day MA` and lag(`20 Day MA`) over w > lag(`50 Day MA`) over w THEN 'SELL'
		else 'HOLD' end) as `Signal`
from  Hero1
window w as (order by `Date`);

drop table if exists Infosys2;

# Lets create a table Infosys2 containing information of close price and 'signal' indicating whether to buy a stock or not on a respective day

create table  Infosys2(constraint PK_date primary key(`date`))
as select `Date`, `Close Price` , 
( case 
	when row_number() over w < 50 THEN 'INFO NOT AVAILABLE'
	when `20 Day MA` > `50 Day MA` and lag(`20 Day MA`) over w < lag(`50 Day MA`) over w THEN 'BUY'
		when `20 Day MA` < `50 Day MA` and lag(`20 Day MA`) over w > lag(`50 Day MA`) over w THEN 'SELL'
		else 'HOLD' end) as `Signal`
from  Infosys1
window w as (order by `Date`);

drop table if exists Tcs2;

# Lets create a table Tcs2 containing information of close price and 'signal' indicating whether to buy a stock or not on a respective day

create table  Tcs2(constraint PK_date primary key(`date`))
as select `Date`, `Close Price` , 
( case 
	when row_number() over w < 50 THEN 'INFO NOT AVAILABLE'
	when `20 Day MA` > `50 Day MA` and lag(`20 Day MA`) over w < lag(`50 Day MA`) over w THEN 'BUY'
		when `20 Day MA` < `50 Day MA` and lag(`20 Day MA`) over w > lag(`50 Day MA`) over w THEN 'SELL'
		else 'HOLD' end) as `Signal`
from  Tcs1
window w as (order by `Date`);

drop table if exists Tvs2;

# Lets create a table Tvs2 containing information of close price and 'signal' indicating whether to buy a stock or not on a respective day

create table  Tvs2(constraint PK_date primary key(`date`))
as select `Date`, `Close Price` , 
( case 
	when row_number() over w < 50 THEN 'INFO NOT AVAILABLE'
	when `20 Day MA` > `50 Day MA` and lag(`20 Day MA`) over w < lag(`50 Day MA`) over w THEN 'BUY'
		when `20 Day MA` < `50 Day MA` and lag(`20 Day MA`) over w > lag(`50 Day MA`) over w THEN 'SELL'
		else 'HOLD' end) as `Signal`
from  Tvs1
window w as (order by `Date`);



drop function if exists bajaj_signal;

delimiter $$

# creating a function bajaj_signal where given the date outputs the 'Signal' for bajaj_stock
create function bajaj_signal(Dat DATE)
returns varchar(25) deterministic

begin
	declare outp varchar(25);
    set outp = ( select `Signal` from bajaj2 where `Date` = Dat limit 1);
    if outp is Null or outp = 'INFO NOT AVAILABLE' then
    set outp = 'Data Not present';
    end if;
    return outp;
end; $$
    
delimiter ;

select bajaj_signal('2017-04-20') as 'Signal';

### ADDITIONAL INPUTS

# creating a procedure buy_sell_dates where given the stock name as input it outputs dates, close prices for rows which have a signal 'sell' or 'buy'

drop procedure if exists buy_sell_dates;
delimiter $$

create procedure buy_sell_dates(in tab_name varchar(25))
begin
	set @k = CONCAT("SELECT *, ROW_NUMBER() OVER (Partition by `Signal` ORDER BY `Date` ASC) AS Sell_Num 
			FROM `", tab_name,
			"2` WHERE `Signal` IN('Sell','Buy')
			ORDER BY `Signal`");
	PREPARE stmt1 FROM @k;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
end; $$
    
delimiter ;

# testing it . We can alter 'Bajaj' with any other stock and view the data
call buy_sell_dates('Bajaj');

drop view if exists num_signal_stocks;

# creating a view to check to check the count of 'Sell' , 'Buy' , 'Hold' for eachs stock
create view num_signal_stocks as
select b.`Signal` as `Signal` , b.Bajaj , e.Eicher , h.Hero , i.Infosys , t.Tcs , tv.Tvs
from (select distinct `Signal` as 'Signal', count(`Signal`) over (partition by `Signal`) as 'Bajaj'
from Bajaj2)  b inner join (select  distinct `Signal` as 'Signal', count(`Signal`) over (partition by `Signal`) as 'Eicher'
from Eicher2) e on b.`Signal` = e.`Signal`
inner join  (select  distinct `Signal` as 'Signal', count(`Signal`) over (partition by `Signal`) as 'Hero'
from Hero2) h on b.`Signal` = h.`Signal`
inner join  (select  distinct `Signal` as 'Signal', count(`Signal`) over (partition by `Signal`) as 'Infosys'
from Infosys2) i on b.`Signal` = i.`Signal`
inner join  (select  distinct `Signal` as 'Signal', count(`Signal`) over (partition by `Signal`) as 'Tcs'
from Tcs2) t on b.`Signal` = t.`Signal`
inner join  (select  distinct `Signal` as 'Signal', count(`Signal`) over (partition by `Signal`) as 'Tvs'
from Tvs2) tv on b.`Signal` = tv.`Signal`
order by field( b.`Signal`  ,'hold','buy', 'sell') desc;


drop view if exists avg_across_stocks;


# creating a view to check to how the close prices look for 'Buy' , 'Sell' and 'Hold' accross all stocks
create view avg_across_stocks as 
select b.`Signal` as `Signal` , b.Bajaj , e.Eicher , h.Hero , i.Infosys , t.Tcs , tv.Tvs
from (select distinct `Signal` as 'Signal', round(avg(`Close Price`) over (partition by `Signal`)) as 'Bajaj'
from Bajaj2)  b inner join (select  distinct `Signal` as 'Signal', round(avg(`Close Price`) over (partition by `Signal`)) as 'Eicher'
from Eicher2) e on b.`Signal` = e.`Signal`
inner join  (select  distinct `Signal` as 'Signal', round(avg(`Close Price`) over (partition by `Signal`)) as 'Hero'
from Hero2) h on b.`Signal` = h.`Signal`
inner join  (select  distinct `Signal` as 'Signal', round(avg(`Close Price`) over (partition by `Signal`)) as 'Infosys'
from Infosys2) i on b.`Signal` = i.`Signal`
inner join  (select  distinct `Signal` as 'Signal', round(avg(`Close Price`) over (partition by `Signal`)) as 'Tcs'
from Tcs2) t on b.`Signal` = t.`Signal`
inner join  (select  distinct `Signal` as 'Signal', round(avg(`Close Price`) over (partition by `Signal`)) as 'Tvs'
from Tvs2) tv on b.`Signal` = tv.`Signal`
order by field( b.`Signal`  ,'hold','buy', 'sell') desc;


## THE END ***




