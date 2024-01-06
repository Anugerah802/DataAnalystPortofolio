-- ## World Palm Oil Production, Export, Import, and Land Use Analysist ## --

-- Every Country Most Palm Oil Production --

SELECT Country, Population, max(ProductioninTon) as BestProduction
from palmoilproduction
where Continent is not null
Group by Country
Order by BestProduction desc;

-- Every Country Production from 2010-2021 --

SELECT Country, Population, Year, ProductioninTon
from palmoilproduction
where Continent is not null 
and Year >= 2010

-- Production in 2021 group by Continent

SELECT Continent, sum(Population) as Population, Year, sum(ProductioninTon) as TotalProductionInTon,
from palmoilproduction
where Continent is not null
and year = 2021
Group by Continent;


-- Every Country Production per Capita from 2010-2021

SELECT Country, Population, Year, ProductioninTon, (ProductioninTon/Population) as Production_per_Capita
from palmoilproduction
where Continent is not null 
and Year >= 2010;

-- Yield (ton production per Ha Land LandUse) to measured Land Productivity from 2010-2021

SELECT Country, max(ProductioninTon) as Production, max(LandUseinHa) as LandUseInHa, 
max(ProductioninTon)/max(LandUseinHa) as Yield
from palmoilproduction
where Continent is not null and year >= 2010
Group By Country
Order BY Yield desc;

-- Production per Capita from 2010-2021 (Study case in Indonesia)

SELECT Country, Population, Year, ProductioninTon, (ProductioninTon/Population) as Production_per_Capita
from palmoilproduction
where Country like '%Indonesia%'
and Year >= 2010;

-- Yield to measured Land Productivity from 2010-2021 (Study case in Indonesia)

SELECT Country, Year, ProductioninTon as Production, LandUseinHa, 
ProductioninTon/LandUseinHa as Yield
FROM palmoilproduction
WHERE Country like '%Indonesia%' 
and Year >= 2010
ORDER by Year asc;

-- Corelation of Palm oil Production, Export, and Domestic Consumption in 2010-2021 (Study case in Indonesia)

SELECT a.Country, a.Year, a.ProductioninTon as Prodution_Ton, b.ExportinTon as Export_Ton, 
    (a.ProductioninTon-b.ExportinTon) as DomesticComs 
FROM palmoilproduction as a
Join palmoil_operation as b on (a.Country = b.Country and a.Year = b.Year)
    WHERE a.Country like '%Indonesia%';

-- Comparison of Land Use, mature Area, and Productivity (Study Case in Indonesia and Malaysia)

SELECT a.Country, a.Year, a.LandUseinHa, b.Matured_AreainHa, a.ProductioninTon as Production_Ton,
    (b.Matured_AreainHa/a.LandUseinHa)*100 as PercentMatureArea,
    a.ProductioninTon/a.LandUseinHa as LandUseYield,
    a.ProductioninTon/b.Matured_AreainHa as MatureAreaYield
FROM palmoilproduction as a
JOIN palmoil_operation as b on (a.Country = b.Country and a.Year = b.Year)
    WHERE a.Country like '%sia';
    
-- Country which Palm oil Producer also importir 

SELECT a.Country, a.ProductioninTon as Production_Ton, i.Import_ton, 
    a.LandUseinHa, a.ProductioninTon/a.LandUseinHa as Yield 
FROM palmoilproduction as a
JOIN palmoil_import as i on (a.Country = i.Country and a.Year = i.Year);


