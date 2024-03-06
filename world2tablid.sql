USE World;

SELECT * FROM City;
SELECT * FROM Country;
SELECT * FROM CountryLanguage;

-- Select laused 2 taused 2 tabelite põhjal
-- vigane päring
SELECT * FROM City, Country;

-- õige päring
SELECT * FROM Country,City
WHERE City.ID = Country.Capital;

-- INNER JOIN
SELECT * FROM Country
INNER JOIN City
ON City.ID = Country.Capital;

-- alias
SELECT * FROM Country as Co
INNER JOIN City as Ci
ON Ci.ID = Co.Capital;

-- 1.a
SELECT co.Name AS Riik, Ci.Name AS Pealinn ,Ci.Population AS 'Pealinna Elanike Arv'  FROM Country as Co
INNER JOIN City as Ci
ON Ci.ID = Co.Capital
WHERE co.Continent LIKE 'Europe'
ORDER BY Ci.Population desc;

-- 1.b
SELECT co.Name AS Riik, Ci.Name AS Pealinn ,Ci.Population AS 'Pealinna Elanike Arv'  FROM Country as Co
Left JOIN City as Ci
ON Ci.ID = Co.Capital
ORDER BY Co.Name;



--2.(Oleksii Rudenko)
Select c.Name as Riik,ci.Name as Pealinn from  Country as c
Inner JOIN City as ci
On ci.ID=c.Capital
Where c.Name=ci.Name
;
--3.Kokku 48 rida-- (Kyrylo Chernykh )
SELECT A.ID, A.Name, a.District, A.CountryCode
FROM City as A, City As B, Country as c
WHERE A.Name = B.Name AND A.ID <> B.ID 
and A.CountryCode=c.code and B.CountryCode=c.code
ORDER BY A.Name;


-- 4 ( Vitalii Sokhan )
select c.Name AS Riik, c.Continent AS Con, COUNT(co.Language) AS 'Language ARV'
from Country AS c
INNER JOIN CountryLanguage AS co
ON c.Code=co.CountryCode
GROUP by c.Name, c.Continent
ORDER by COUNT(co.Language) desc;


-- 5 (Darja / Mihhail)
select c.Name AS Riik, c.Continent AS Kontenent, count(cl.Language) AS 'Language ARV' from Country AS c, CountryLanguage as cl
where c.Code=cl.CountryCode
and cl.IsOfficial =1
group by c.Name,c.Continent
order by Count(cl.Language) desc;



/*
Не работает.

SELECT C.Name AS Riik, L.Language AS Keel, ci.population AS 'Inimiste arv'
FROM (Country AS C INNER JOIN City AS ci
ON C.Capital = Ci.ID)
INNER JOIN CountryLanguage AS L
ON C.Code = L.Language
WHERE c.continent LIKE 'Asia' AND C.Code = L.Language AND L.IsOfficial = 1
ORDER BY C.Name
*/

--6 Andrei (AleksanderK fix)
SELECT C.Name AS Riik, L.Language AS Keel, c.population AS 'Inimiste arv', cast( (c.population *  (l.Percentage/100)) as int ) per
FROM Country AS C
Inner JOIN City as ci
On ci.ID=c.Capital
INNER JOIN CountryLanguage as L
ON C.Code = L.CountryCode
WHERE c.continent LIKE 'Asia' AND C.Code = L.CountryCode
ORDER BY C.Name;

-- 7.a (Me)
SELECT Co.Name AS Riik, Co.Population as 'Riigi Elanikut' , Ci.Name AS Pealinn ,Ci.Population AS 'Pealinna Elanike Arv', round( (cast(Ci.Population AS FLOAT)/cast(Co.Population AS float))*100,1) Protsent
FROM Country as Co
inner JOIN City as Ci
ON Ci.ID = Co.Capital
ORDER BY Co.Name;

/* 7,b ( martin )
select c.Name AS Riik, c.Population AS 'Riigi Elanikut', ci.Name AS Pealinn, ci.Population 'Peallinna Elanikut', (ci.Population * 100/(SELECT SUM(ci.Population)))  as Protsent from country AS c
LEFT JOIN city AS ci
on ci.ID=c.Capital
group by ci.Name;
*/

--7,b ( martin )
select c.Name AS Riik, c.Population AS 'Riigi Elanikut', ci.Name AS Pealinn, ci.Population 'Peallinna Elanikut', round( (cast(Ci.Population AS FLOAT)/cast(C.Population AS float))*100,1) Protsent from country AS c
LEFT JOIN city AS ci
on ci.ID=c.Capital
order by c.Name;

-- 8 (Sergei)
Select CL.Language AS Language, sum (C.Population*Cl.Percentage) AS 'Kokku Inimest'
FROM country c
INNER JOIN CountryLanguage AS Cl
ON Cl.CountryCode=C.Code
GROUP BY Cl.Language
ORDER BY sum (C.Population*Cl.Percentage) desc

-- 9 ( Aleksandr Nikolas )
Select cl.Language AS Language, 
SUM(c.Population * cl.Percentage ) AS 'Kokku Inimest'
FROM Country AS c
INNER JOIN CountryLanguage AS cl 
ON cl.CountryCode = c.Code
WHERE c.Continent = 'Europe'
GROUP BY cl.Language
ORDER BY SUM(C.Population * cl.Percentage) desc;

-- 10 ( Janis Pahhomov )
select c.Name as Riik,
c.Continent as Continent,
c.SurfaceArea as Pindala,
c.IndepYear as IseseisAasta,
c.Population as ElanikudeArv,
c.GovernmentForm as GovernmentForm,
c.HeadOfState as Headofstate,
ci.name as Pealinn,
cl.language as Keel

from country as c,
city as ci,
CountryLanguage as cl
where cl.countrycode = c.code and Ci.ID = c.capital and cl.isofficial = 1
order by c.name