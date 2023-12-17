-- Data exploring cases

SELECT * from coviddeath;

SELECT Location, date, New_cases, Total_deaths, Population 
from coviddeath;

-- Looking at total Cases Vs Total coviddeath (Indonesia Cases)

SELECT Location, date, total_cases, Total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from coviddeath
where location like '%Indonesia%';

-- looking at total_cases vs population

SELECT Location, date, total_cases, population, (total_cases/population)*100 as CasesPercentage
from coviddeath
where location like '%Indonesia%';

-- looking Countries with Highest Infection rate Compared to population

SELECT Location, max(total_cases) as HighestinfectCount, population, max(total_cases/population)*100 as HighestCasesPercentage
from coviddeath
Group by location, population 
order by HighestCasesPercentage desc;

-- showing countries with highest death count per population

SELECT Location, max(total_deaths) as TotaldeathCount, population, max(total_deaths/population)*100 as HighestDeathPercentage
from coviddeath
group by location, population
order by HighestDeathPercentage desc;

-- showing Continent with highest death count per population

SELECT continent, max(total_deaths) as TotaldeathCount, max(population), max(total_deaths/population)*100 as HighestDeathPercentage
from coviddeath
group by continent
order by HighestDeathPercentage desc;

-- Global Number

SELECT Location, date, sum(total_cases) as Totalcases, sum(total_deaths) as TotalDeath,
(sum(total_cases)/sum(total_deaths))*100 as DeathCasesPercentage
from coviddeath
where continent is not null
Group by date;


-- vaccine Cases 

-- looking total population vs New vaccination 

select Dea.continent, Dea.location, Dea.date, Dea.population, vac.new_vaccinations
from coviddeath as Dea
Join covidvaccine as vac on (Dea.location = vac.location)
where Dea.location like '%Indonesia%';

-- 