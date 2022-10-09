create database population;
use population;
create table CIA_factbook(
country	varchar(100), 
area integer,
birth_rate decimal(38,2), 
death_rate decimal(38,2),
infant_mortality_rate decimal(38,2),
internet_users	integer,
life_exp_at_birth decimal(38,2),	
maternal_mortality_rate integer,
net_migration_rate	decimal(38,2),
population	integer,
population_growth_rate decimal(38,2)
);
drop table cia_factbook_FSDA;
drop table cia_factbook_fsda;
drop table cia_factbook;
drop table CIA_factbook;
drop table cia_factbook;
LOAD DATA INFILE 'D:\cia_factbook.csv'
INTO TABLE CIA_factbook
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(@col1, @col2, @col3, @col4, @col5, @col6, @col7, @col8, @col9, @col10, @col11)
set country = @col1, 
area = if(@col2 = 'NA', NULL, @col2), 
birth_rate = if(@col3 = 'NA', NULL, @col3), 
death_rate = if(@col4 = 'NA', NULL, @col4),
infant_mortality_rate = if(@col5 = 'NA', NULL, @col5), 
internet_users = if(@col6 = 'NA', NULL, @col6), 
life_exp_at_birth = if(@col7 = 'NA', NULL, @col7),
maternal_mortality_rate  = if(@col8 = 'NA', NULL, @col8),
net_migration_rate = if(@col9 = 'NA', NULL, @col9), 
population = if(@col10 = 'NA', NULL, @col10), 
population_growth_rate = if(@col11 = 'NA', NULL, @col11);

select * from CIA_factbook;

select country ,population
from CIA_factbook
where population = (select max(cast(population as unsigned)) from CIA_factbook);

select country,population from CIA_factbook
  order by population asc;

select min(population) from CIA_factbook;

select country ,population
from CIA_factbook
where population = (select min(population) from CIA_factbook);
select country , population_growth_rate from CIA_factbook 
where population_growth_rate = (select max(population_growth_rate) from CIA_factbook);

select country , population/ area as max_population_density from CIA_factbook 
where population_density = max(population/area);

with density_pop as
(select country , (population/ area) as population_density  from CIA_factbook group by country)
select country,population_density from density_pop 
where population_density= (select max(population_density) from density_pop) ;

