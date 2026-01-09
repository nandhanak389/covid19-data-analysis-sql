create database covid;
use covid;
select * from ecdc_covid_19;
alter table ecdc_covid_19 rename to covid_19;
alter table covid_19 rename column countriesAndTerritories to Country;
alter table covid_19 rename column countryterritoryCode to Countrycode;
alter table covid_19 rename column dateRep to Dates;
alter table covid_19 rename column popData2018 to Population;
select * from covid_19; 
alter table covid_19 rename column day to Day;
alter table covid_19 rename column month to Month;
alter table covid_19 rename column year to Year;
alter table covid_19 rename column cases to Cases;
alter table covid_19 rename column deaths to Deaths;
alter table covid_19 rename column geoid to Geoid;

# questions 
-- 1 extract dayname and month name?
select  Day,dayname(Dates) as Dayname from covid_19;
select Month,monthname(Dates)as Monthname from covid_19;

# arithematic opreators 
-- 1 
select * from covid_19 where Countrycode="AFG";
select * from covid_19 where Cases < 50;
select *from covid_19 where Countrycode<> "IND";
select * from covid_19 where Deaths>50;
select * from covid_19 where Population <=100000;
select * from covid_19 where Cases >=100;
select Country,Cases from covid_19 where Cases >=100;
select Dates,Cases from covid_data where cases >= 10 AND cases <= 40;
select Dates, Cases, Deaths from covid_19 where Cases >= Deaths;
select * from covid_19 where month != 3;

# logical operator

select * from covid_19 where not Cases < 100;
select Country,Cases,Month from covid_19 where Month = 3 AND Year = 2020;
select Country,Cases,Population from covid_19 where Population > 300000 and Cases >100;
select Country,Cases,Deaths,Countrycode  FROM covid_19 WHERE Cases >= 40 OR Deaths >3;
select Deaths,Country from covid_19 where Countrycode='IND' and Deaths>5; 
select Dates,Cases,Deaths,Country,Population from covid_19 where not Population >2500000;
select Dates,Cases,Deaths,Country,Population from covid_19 where Countrycode='CAN' and ( Deaths>10 or Cases>5);
select * from covid_19 where (Cases > 25 AND Deaths > 0) OR Month = 4;
select *from covid_19 where (Countrycode='DNK' OR Countrycode='FRA') and (Month=4 OR Month=3);
select *from covid_19 where not Cases<=500 and (Countrycode ='BEL' or Countrycode='SLE');

#special operators

select * from covid_19 where Cases between 100 and 500;
select * from covid_19 where Cases  NOT between 100 and 500;
select * from covid_19 where Month between 3 and 6;
select * from covid_19 where Country IN ('India', 'China', 'Japan');
select * from covid_19 where country NOT IN ('India', 'China', 'Japan');
select * from covid_19 where geoid IN ('AU', 'AT','CZ');
select * from covid_19 where Country LIKE 'A%';
select * from covid_19 where Country  NOT LIKE 'A%';
select * from covid_19 where Country LIKE '%land%';
select * from covid_19 where Country  NOT LIKE '____';
select * from covid_19 where Cases IS NOT NULL;
select * from covid_19 where Countrycode IS NOT NULL;

# aggregative functions

select sum(Cases) from covid_19 ;
select Country, SUM(Cases) AS total_cases from covid_19 GROUP BY Country;
select Month,sum(Deaths)as Monthly_death from covid_19  group by Month;
select avg (Cases) AS avg_daily_cases from covid_19 where Country = 'Afghanistan';
select Country,avg(Population) as avg_population from covid_19 group by Country;
select Country,avg(Deaths) as avg_deaths from covid_19 group by Country;
select count(*) as days_over_cases from covid_19 where Country = 'India' and Cases > 80;
select  Country ,count(Cases) as total_cases from covid_19 group by Country;
select Country,count(Month) AS months_with_deaths from covid_19 where Deaths>=5 group by Country;
select max(Deaths) from covid_19;
select max(Cases) from covid_19;
select Country,max(Cases) as Country_Max_cases from covid_19 group by Country;
select min(Deaths) from covid_19;
select min(Cases) from covid_19;
select min(Population) from covid_19;

# ORDER BY 
SELECT Country, Dates, Cases, Deaths FROM covid_19 ORDER BY Cases ASC;
SELECT Country, Dates, Cases, Deaths FROM covid_19 ORDER BY Country ASC;
SELECT DISTINCT Country, Population FROM covid_19 ORDER BY Population DESC;

# case stt
SELECT 
    Country,
    Dates,
    Cases,
    Deaths,
    CASE 
        WHEN Deaths > Cases 
        THEN 'Abnormal'
        WHEN Deaths = Cases 
        THEN 'Equal'
        ELSE 'Normal'
    END AS case_status
FROM covid_19;
SELECT 
    Country,
    Population,
    CASE 
        WHEN Population < 1000000 
        THEN 'Small'
        WHEN Population BETWEEN 1000000 AND 10000000 
        THEN 'Medium'
        WHEN Population BETWEEN 10000001 AND 50000000 
        THEN 'Large'
        ELSE 'Very Large'
    END AS population_group
from covid_19;
select
    Country,
    Dates,
    Cases,
    case 
        when Cases = 0 
        then 'No Cases'
        when Cases between 1 and 100 
        then 'Low'
        when Cases between 101 and 500 
        then 'Medium'
        else 'High'
    end as case_level
from covid_19;
