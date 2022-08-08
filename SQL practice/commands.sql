-- TODO: String to date format
select str_to_date(order_date, "%m%d%Y") from sales;

alter table sales
add column order_date_new date after order_date;

update sales
set order_new_date = str_to_date(order_date, '%m/%d/%Y');

select * from sales
where order_new_date between '2011-04-01' and '2011-08-30'

select now()
select curdate()

select date_sub(curdate(), interval 1 week)
select date_sub(curdate(), interval 2 day)
select date_sub(curdate(), interval 1 year)

select * from sales 
where ship_date_new < date_sub(curdate(), interval 1 month)

select year(now())
select day(now())
select month(now())
select dayname(now())

select year(curdate())
select day(curdate())
select month(curdate())
select dayname(curdate())

select dayname('2022-08-02')

alter table sales
add column flag date after order_id

-- TODO: ALTER AND UPDATE 

update sales
set flag = now()

alter table sales
modify column year datetime

alter table sales
add column order_year int

alter table sales
add column order_month int

alter table sales
add column order_day int

update sales
set order_year = year(order_date_new)

update sales
set order_month = month(order_date_new)

update sales
set order_day = day(order_date_new)

select order_year, avg(sales) from sales group by order_year

-- TODO: Discount and CTC

select sales, (discount*100) as Discount,shipping_cost, ((sales*discount) + shipping_cost )  as CTC from sales

select order_id, discount, if(discount > 0, 'yes', 'no') as dicount_flag from sales

alter table sales
add column discount_flag varchar(10) after discount

update sales
set discount_flag = if(discount > 0, 'yes', 'no')

select discount_flag, count(*) from sales group by discount_flag

-- TODO: IF ELSE STATEMENT
DELIMITER $$
create function add_to_col1(a INT)
RETURNS INT
deterministic
BEGIN
	DECLARE b int;
    set b = a + 10;
    return b;
end $$
    
    select add_to_col1(13)
    
    select quantity, add_to_col1(quantity) from sales

    -- Caculate real profit
DELIMITER $$
create function profit_real(p decimal(10,5), d decimal(10,5))
returns decimal(10,5)
DETERMINISTIC
BEGIN
	declare actual_gain decimal(10,5);
    set actual_gain = p - d;
    return actual_gain;
END $$

-- TODO: function to convert integer into string
DELIMITER $$
create function int_to_varchar(a int)
returns varchar(10)
DETERMINISTIC
BEGIN
	declare b varchar(10);
    set b = a;
    return b;
END $$

--TODO: REQUIREMENT: label this in sales
1-100 - much affordable product
100-300 - affordable
300-600 - moderate price
600+ - expensive 

ALTER TABLE SALES
ADD COLUMN sales_flag varchar(30) after sales

Delimiter $$
create function label_sales(sales int)
returns varchar(30)
deterministic
begin
	declare flag varchar(30);
    if sales < 100 then
		set flag = "much affordable product";
	elseif sales between 100 and 300 then
		set flag = "affordable";
	elseif sales between 300 and 600 then
		set flag = "moderate price";
	else
		set flag = "expensive";
	end if;
    return flag;
end $$

update sales
set sales_flag = label_sales(sales)

-- TODO: LOOPS 
set @var = 10;
generate_mydata : loop
set @var = @var + 1;
if @var = 100 then
	leave generate_mydata;
end if;
end loop generate_mydata;

-- TODO: USE OF LOOP
create table table_loop(val int)
select * from table_loop
-- LOOPS 
Delimiter $$
create procedure insert_into_tableloop()
Begin
set @var = 10;
generate_mydata : loop
INSERT INTO table_loop values(@var);
set @var = @var + 1;
if @var = 100 then
	leave generate_mydata;
end if;
end loop generate_mydata;
End $$

call insert_into_tableloop