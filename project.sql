/* 
COVID-19 DATA EXPLORATION

Skills Used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/

SELECT *
FROM Project.dbo.CovidDeath$



Select *
From PortfolioProject..CovidDeaths
Where continent is not null 
order by 3,4



--SELECT WHAT DATA TO USE
SELECT location, date, total_cases, total_deaths,population
FROM Project..CovidDeath$
WHERE continent is not null 
ORDER BY 1,2



--Total Cases vs Total Death in Africa
SELECT location, date, total_cases, total_deaths,population
FROM Project..CovidDeath$
WHERE continent = 'Africa'
AND continent IS NOT NULL
ORDER BY 1,2



--Total Cases vs Total Death in Africa
--Shows likelihood of dying if you contracted covid in African countries
SELECT continent, location, date, total_cases, total_deaths, population, (total_deaths/population)*100 AS DeathPerc
FROM Project..CovidDeath$
WHERE continent = 'Africa'
AND continent IS NOT NULL
ORDER BY 1,2



--Total Cases vs Total Death in Africa
--Shows likelihood of you contracting covid in African countries/ percentage of people infected
SELECT continent, location, date, total_cases, total_deaths, population, (total_cases/population)*100 AS PercPopInfected
FROM Project..CovidDeath$
WHERE continent = 'Africa'
AND continent IS NOT NULL
ORDER BY 1,2



--Total Cases vs Total Death in Nigeria
--Shows Covid daily cases and Deaths in Nigeria
SELECT location, date, population, total_cases, total_deaths
FROM Project..CovidDeath$
WHERE location like '%Nigeria%'
AND continent IS NOT NULL
ORDER BY 1,2



--Total Cases vs Total Death in Nigeria
--Shows likelihood of dying if you contracted covid in Nigeria
SELECT location, date, total_cases, total_deaths,population, (total_deaths/population)*100  DeathpercNigeria
FROM Project..CovidDeath$
WHERE location like '%Nigeria%'
AND continent IS NOT NULL
ORDER BY 1,2



--Total Cases vs Total Death in Nigeria

--Shows likelihood of contracting covid in Nigeria/ perc of people infected

SELECT location, date, total_cases, total_deaths,population, (total_cases/population)*100  CovidPopPercNigeria
FROM Project..CovidDeath$
WHERE location like '%Nigeria%'
AND continent IS NOT NULL
ORDER BY 1,2



--Total Covid Cases by Countries (Africa) SUM

SELECT location, SUM(total_cases)  TotalCase
FROM Project..CovidDeath$
WHERE continent like '%Africa%'
AND continent IS NOT NULL
GROUP BY location
order by location




--Total Covid cases by Countries (Africa) Highest to Lowest

SELECT location, population, SUM(total_cases)  TotalCasepercountry
FROM Project..CovidDeath$
WHERE continent like '%Africa%'
AND continent IS NOT NULL
GROUP BY location, population
order by TotalCasepercountry DESC



--SHOWS TOP 10 African countries with Highest Number of Covid Cases

SELECT TOP 10 location, population, SUM(total_cases)  TotalCasepercountry
FROM Project..CovidDeath$
WHERE continent like '%Africa%'
AND continent IS NOT NULL
GROUP BY location, population
order by TotalCasepercountry DESC



--SHOWS COUNTRIES WITH THE HIGHEST INFECTION RATE Vs POPULATION IN AFRICA

SELECT location, population, MAX(total_cases)  HighestInfectioncountAfrica, MAX((total_cases/population))* 100 AS PercPopulationInfected
FROM Project..CovidDeath$
WHERE continent like '%Africa%'
AND continent IS NOT NULL
GROUP BY location, population
order by PercPopulationInfected DESC



--SHOWS TOP 10 COUNTRIES WITH THE HIGHEST INFECTION RATE Vs POPULATION IN AFRICA

SELECT TOP 10 location, population, MAX(total_cases)  HighestInfectioncountAfrica, MAX((total_cases/population))* 100 AS PercPopulationInfected
FROM Project..CovidDeath$
WHERE continent like '%Africa%'
AND continent IS NOT NULL
GROUP BY location, population
order by PercPopulationInfected DESC



--COUNTRIES WITH HIGHEST INFECTION RATE COMPARED TO POPULATION (GLOBAL)

SELECT location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))* 100 AS PercPopulationInfected
FROM project..CovidDeath$
--WHERE location = 'Nigeria'
WHERE continent IS NOT NULL
Group by location,population
ORDER BY PercPopulationInfected DESC



--TOP 50 COUNTRIES WITH HIGHEST INFECTION RATE COMPARED TO POPULATION (GLOBAL)

SELECT TOP 50 location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))* 100 AS PercPopulationInfected
FROM project..CovidDeath$
--WHERE location = 'Nigeria'
WHERE continent IS NOT NULL
Group by location,population
ORDER BY PercPopulationInfected DESC



--COUNTRIES WITH THE HIGHEST DEATH COUNT PER POPULATION

SELECT location, MAX(total_deaths) as HighestDeathCount --MAX((total_deaths/population))* 100 AS PercPopulationDeath
FROM project..CovidDeath$
--WHERE location = 'Nigeria'
WHERE continent IS NOT NULL
Group by location
ORDER BY HighestDeathCount DESC


--Convert Data using cast function

--SHOWS COUNTRIES WITH HIGHEST DEATH COUNT

SELECT location, MAX(cast(total_deaths as int)) as HighestDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
Group by location
ORDER BY HighestDeathCount DESC



--SHOWS COUNTRIES WITH THE HIGHEST DEATH COUNT PER POPULATION (GLOBAL)

SELECT location, MAX(cast(total_deaths as int)) as HighestDeathCount, ROUND(MAX(total_deaths/population)* 100,3) AS PercPopulationDeath
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
Group by location
ORDER BY PercPopulationDeath DESC



--SHOWS COUNTRIES WITH HIGHEST DEATH COUNT IN AFRICA

SELECT location, MAX(cast(total_deaths as int)) as HighestDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent = 'Africa'
AND continent IS NOT NULL
Group by location
ORDER BY HighestDeathCount DESC



--SHOWS COUNTRIES WITH THE HIGHEST DEATH COUNT PER POPULATION IN AFRICA

SELECT location, MAX(cast(total_deaths as int)) as HighestDeathCount, ROUND(MAX(total_deaths/population)* 100,3) AS PercPopulationDeath
FROM PortfolioProject..CovidDeaths
WHERE continent = 'Africa'
AND continent IS NOT NULL
Group by location
ORDER BY PercPopulationDeath DESC



--LET'S BREAK THINGS DOWN BY CONTINENT

--Shows highest death counts by continent

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCountbyContinent                
From Project..CovidDeath$
Where continent is not null 
Group by continent
order by TotalDeathCountbyContinent desc



--Shows Highest Infection Count By Continent      

Select continent, MAX(total_cases) as TotalInfectionCountbyContinent
From Project..CovidDeath$
Where continent is not null 
Group by continent
order by TotalInfectionCountbyContinent desc




-- GLOBAL NUMBERS

--Shows global daily Total Covid cases, Total Deaths, and Death Percentage

Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From project..CovidDeath$
where continent is not null 
Group By date
order by 1,2



--Shows Africa daily Total Covid cases, Total Deaths, and Death Percentage

Select date,  SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From project..CovidDeath$
--Where location like '%states%'
where continent = 'Africa'
AND continent IS NOT NULL
Group By date
order by 1,2


--Shows Nigeria's daily Total Covid cases, Total Deaths

SELECT date,  SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths 
FROM Project..CovidDeath$
WHERE location like '%Nigeria%'
AND continent IS NOT NULL
GROUP BY date
ORDER BY 1,2



--SHOWS GLOBAL OVERALL TOTAL COVID CASES, TOTAL COVID DEATHS, and DEATH PERCENTAGES  

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From project..CovidDeath$
where continent is not null 
order by 1,2



--Shows Africa overall Total Covid cases, Total Deaths, and Death Percentage  

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From project..CovidDeath$
where continent = 'Africa'
AND continent is not null 
order by 1,2



--Shows Nigeria overall Total Covid cases, Total Deaths, and Death Percentage 

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From project..CovidDeath$
where location = 'Nigeria'
AND continent is not null 
order by 1,2



--NOW LETS JOIN THE COVID VACCINATION TABLE


--SHOWING GLOBAL POPULATION VS VACCINATED

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Convert(bigint, vac.new_vaccinations))
Over(Partition by dea.location Order by dea.location, dea.date)  Rollingpeoplevaccinated
FROM project..CovidDeath$  dea
JOIN project..Covidvaccination$  vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3 


--USE CTE

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From Project..CovidDeath$ dea
Join Project..CovidVaccination$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
)
SELECT *,(RollingPeopleVaccinated/Population)*100 AS PercPopVaccinated
FROM PopvsVac



--SHOWING AFRICA POPULATION Vs VACCINATION

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Convert(bigint, vac.new_vaccinations))
Over(Partition by dea.location Order by dea.location, dea.date)  Rollingpeoplevaccinated
FROM project..CovidDeath$  dea
JOIN project..Covidvaccination$  vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent = 'Africa'
AND dea.continent IS NOT NULL
ORDER BY 2,3 


--USE CTE

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Project..CovidDeath$ dea
Join Project..CovidVaccination$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent = 'Africa'
AND dea.continent is not null 
--order by 2,3
)
SELECT *, (RollingPeopleVaccinated/Population)*100 AS PercPopVaccinatedAfrica
FROM PopvsVac



--SHOWING NIGERIA POPULATION VS VACCINATION

SELECT  dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Convert(bigint, vac.new_vaccinations))
Over(Partition by dea.location Order by dea.location, dea.date)  Rollingpeoplevaccinated
FROM project..CovidDeath$  dea
JOIN project..Covidvaccination$  vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.location = 'Nigeria'
AND dea.continent IS NOT NULL
ORDER BY 2,3 


--USE CTE

With PopvsVac ( Date, Location, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.date, dea.location, dea.population, vac.new_vaccinations, 
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Project..CovidDeath$ dea
Join Project..CovidVaccination$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.location = 'Nigeria'
AND dea.continent is not null 
--order by 2,3
)
SELECT *, (RollingPeopleVaccinated/Population)*100 AS PercPopVaccinatedinNigeria
FROM PopvsVac



--TEMP TABLE

DROP TABLE if exists #PercentagePopulationVaccinated
CREATE TABLE #PercentagePopulationVaccinated 
(
continent nvarchar(255),
location nvarchar (255),
date datetime,
Population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentagePopulationVaccinated

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Project..CovidDeath$ dea
Join Project..CovidVaccination$ vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null
--order by 2,3

SELECT *, (RollingPeopleVaccinated/Population)*100  PercOfPopVaccinated
FROM #PercentagePopulationVaccinated



--CREATING VIEW TO STORE DATA FOR LATER VISUALIZATION

CREATE VIEW PercentagePopulationVaccinated AS
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From Project..CovidDeath$ dea
Join Project..CovidVaccination$ vac
	On dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null



--Total Covid cases by Countries (Africa) Highest to Lowest
CREATE VIEW AfricaTotalCovidCasePerCountry AS
SELECT location, population, SUM(total_cases)  TotalCasepercountry
FROM Project..CovidDeath$
WHERE continent like '%Africa%'
AND continent IS NOT NULL
GROUP BY location, population
--order by TotalCasepercountry DESC


CREATE VIEW Top10AfricaCovidCase AS
SELECT TOP 10 location, population, SUM(total_cases)  TotalCasepercountry
FROM Project..CovidDeath$
WHERE continent like '%Africa%'
AND continent IS NOT NULL
GROUP BY location, population
--order by TotalCasepercountry DESC



--SHOWS COUNTRIES WITH THE HIGHEST INFECTION RATE Vs POPULATION IN AFRICA

CREATE VIEW AfricaInfectionCountVsPopulationRate AS
SELECT location, population, MAX(total_cases)  HighestInfectioncount, MAX((total_cases/population))* 100 AS PercPopulationInfected
FROM Project..CovidDeath$
WHERE continent like '%Africa%'
AND continent IS NOT NULL
GROUP BY location, population
--order by PercPopulationInfected DESC

--SHOWS TOP 10 COUNTRIES WITH THE HIGHEST INFECTION RATE Vs POPULATION IN AFRICA
CREATE VIEW Top10AfricaInfectionCountVsPopulationRate AS
SELECT TOP 10 location, population, MAX(total_cases)  HighestInfectioncountAfrica, MAX((total_cases/population))* 100 AS PercPopulationInfected
FROM Project..CovidDeath$
WHERE continent like '%Africa%'
AND continent IS NOT NULL
GROUP BY location, population
--order by PercPopulationInfected DESC


--COUNTRIES WITH HIGHEST INFECTION RATE COMPARED TO POPULATION (GLOBAL)
CREATE VIEW GlobalInfectionCountVsPopulationRate AS
SELECT location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))* 100 AS PercPopulationInfected
FROM project..CovidDeath$
WHERE continent IS NOT NULL
Group by location,population
--ORDER BY PercPopulationInfected DESC


--TOP 50 COUNTRIES WITH HIGHEST INFECTION RATE COMPARED TO POPULATION (GLOBAL)
CREATE VIEW Top50GlobalInfectionCountVsPopulationRate AS
SELECT TOP 50 location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))* 100 AS PercPopulationInfected
FROM project..CovidDeath$
--WHERE location = 'Nigeria'
WHERE continent IS NOT NULL
Group by location,population
ORDER BY PercPopulationInfected DESC


--SHOWS COUNTRIES WITH THE HIGHEST DEATH COUNT IN AFRICA
CREATE VIEW AfricaDeathCounts AS
SELECT location, MAX(cast(total_deaths as int)) as HighestDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent = 'Africa'
AND continent IS NOT NULL
Group by location
--ORDER BY HighestDeathCount DESC


--SHOWS COUNTRIES WITH THE HIGHEST DEATH COUNT PER POPULATION IN AFRICA
CREATE VIEW AfricaCovidDeathRate AS
SELECT location, MAX(cast(total_deaths as int)) as HighestDeathCount, ROUND(MAX(total_deaths/population)* 100,3) AS PercPopulationDeath
FROM PortfolioProject..CovidDeaths
WHERE continent = 'Africa'
AND continent IS NOT NULL
Group by location
--ORDER BY PercPopulationDeath DESC


--Shows highest death counts by continent
CREATE VIEW DeathCountsbyContinent AS
Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCountbyContinent                
From Project..CovidDeath$
Where continent is not null 
Group by continent
--order by TotalDeathCountbyContinent desc


--Shows Highest Infection Count By Continent 
CREATE VIEW InfectionCountsByContinent AS
Select continent, MAX(total_cases) as TotalInfectionCountbyContinent
From Project..CovidDeath$
Where continent is not null 
Group by continent
--order by TotalInfectionCountbyContinent desc



--SHOWS GLOBAL OVERALL TOTAL COVID CASES, TOTAL COVID DEATHS, and DEATH PERCENTAGES
CREATE VIEW GlobalTotal AS
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From project..CovidDeath$
where continent is not null 
--order by 1,2


--Shows Africa overall Total Covid cases, Total Deaths, and Death Percentage 
CREATE VIEW AfricaTotal AS
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From project..CovidDeath$
where continent = 'Africa'
AND continent is not null 
--order by 1,2


--Shows Nigeria overall Total Covid cases, Total Deaths, and Death Percentage 
CREATE VIEW NigeriaTotal AS
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From project..CovidDeath$
where location = 'Nigeria'
AND continent is not null 
--order by 1,2