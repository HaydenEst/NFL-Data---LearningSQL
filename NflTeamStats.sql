--- Taking A Look at the Data
SELECT *
FROM PassingOffense2019
SELECT *
FROM RushingOffense2019
SELECT Season
FROM QBStats2019
SELECT Season
FROM ScrimmageStats2019
SELECT *
FROM TeamStats2019

--ADDING YEARS INTO TABLES
ALTER TABLE QBStats2019
ADD Season int;
UPDATE QBStats2019
SET Season = 2019

ALTER TABLE QBStats2020
ADD Season int;
UPDATE QBStats2020
SET Season = 2020

ALTER TABLE QBStats2021
ADD Season int;
UPDATE QBStats2021
SET Season = 2021
--
ALTER TABLE PassingOffense2019
ADD Season int;
UPDATE PassingOffense2019
SET Season = 2019

ALTER TABLE PassingOffense2020
ADD Season int;
UPDATE PassingOffense2020
SET Season = 2020

ALTER TABLE PassingOffense2021
ADD Season int;
UPDATE PassingOffense2021
SET Season = 2021
--
ALTER TABLE RushingOffense2019
ADD Season int;
UPDATE RushingOffense2019
SET Season = 2019

ALTER TABLE RushingOffense2020
ADD Season int;
UPDATE RushingOffense2020
SET Season = 2020

ALTER TABLE RushingOffense2021
ADD Season int;
UPDATE RushingOffense2021
SET Season = 2021
--
ALTER TABLE ScrimmageStats2019
ADD Season int;
UPDATE ScrimmageStats2019
SET Season = 2019

ALTER TABLE ScrimmageStats2020
ADD Season int;
UPDATE ScrimmageStats2019
SET Season = 2019

ALTER TABLE ScrimmageStats2020
ADD Season int;
UPDATE ScrimmageStats2020
SET Season = 2020

ALTER TABLE ScrimmageStats2021
ADD Season int;
UPDATE ScrimmageStats2021
SET Season = 2021
--
ALTER TABLE TeamStats2019
ADD Season int;
UPDATE TeamStats2019
SET Season = 2019

ALTER TABLE TeamStats2020
ADD Season int;
UPDATE TeamStats2020
SET Season = 2020

ALTER TABLE TeamStats2021
ADD Season int;
UPDATE TeamStats2021
SET Season = 2021

--- JOIN TEAM DATA FROM ALL SEASONS INTO ONE TABLE

/*
This code joins the PassingOffense, RushingOffense and TeamStats tables for each season.
Ex: PassingOffense19 joins with RushingOffense2019 and TeamStats2019. 
The newly joined tables are then unionized with each other and inserted into a new table called AllTeamStats
*/
SELECT t.tm, t.Season, t.PF, t.yds AS TotYds, p.Cmp, p.Att, p.PassYds, p.PassTD
, p.Int, p.Rate, r.RushYds, r.RushTD, r.Fmb INTO AllTeamStats
FROM TeamStats2019 AS t
INNER JOIN PassingOffense2019 AS p on t.tm = p.tm
INNER JOIN RushingOffense2019 AS r on t.tm = r.tm
WHERE t.Tm <> 'Avg Team' AND t.Tm <> 'Avg Tm/G'
AND t.Tm <> 'League Total'
UNION
SELECT t.tm, t.Season, t.PF, t.yds AS TotYds, p.Cmp, p.Att, p.PassYds, p.PassTD
, p.Int, p.Rate, r.RushYds, r.RushTD, r.Fmb
FROM TeamStats2020 AS t
INNER JOIN PassingOffense2020 AS p on t.tm = p.tm
INNER JOIN RushingOffense2020 AS r on t.tm = r.tm
WHERE t.Tm <> 'Avg Team' AND t.Tm <> 'Avg Tm/G'
AND t.Tm <> 'League Total'
UNION
SELECT t.tm, t.Season, t.PF, t.yds AS TotYds, p.Cmp, p.Att, p.PassYds, p.PassTD
, p.Int, p.Rate, r.RushYds, r.RushTD, r.Fmb
FROM TeamStats2021 AS t
INNER JOIN PassingOffense2021 AS p on t.tm = p.tm
INNER JOIN RushingOffense2021 AS r on t.tm = r.tm
WHERE t.Tm <> 'Avg Team' AND t.Tm <> 'Avg Tm/G'
AND t.Tm <> 'League Total'

SELECT *
FROM AllTeamStats


--- CLEANING PLAYER NAMES
/*
Most names for individual Players have unneccasary charecters that would obstruct analysis
*/
SELECT Player
FROM NFL.dbo.QBStats2019
UNION
SELECT Player
FROM NFL.dbo.QBStats2020
UNION
SELECT Player
FROM NFL.dbo.QBStats2021

SELECT Player
FROM NFL.dbo.QBStats2019

UPDATE QBStats2019
SET Player = REPLACE(Player, '*', '')
UPDATE QBStats2019
SET Player = REPLACE(Player, '+', '')

UPDATE QBStats2020
SET Player = REPLACE(Player, '*', '')
UPDATE QBStats2020
SET Player = REPLACE(Player, '+', '')

UPDATE QBStats2021
SET Player = REPLACE(Player, '*', '')
UPDATE QBStats2021
SET Player = REPLACE(Player, '+', '')

UPDATE ScrimmageStats2019
SET Player = REPLACE(Player, '*', '')
UPDATE ScrimmageStats2019
SET Player = REPLACE(Player, '+', '')

UPDATE ScrimmageStats2020
SET Player = REPLACE(Player, '*', '')
UPDATE ScrimmageStats2020
SET Player = REPLACE(Player, '+', '')

UPDATE ScrimmageStats2021
SET Player = REPLACE(Player, '*', '')
UPDATE ScrimmageStats2021
SET Player = REPLACE(Player, '+', '')


--- Seperate Player Names to First and Last Names
SELECT
SUBSTRING(Player, 1, CHARINDEX(' ', Player) -1) AS FirstName,
SUBSTRING(Player, CHARINDEX(' ', Player) + 1, LEN(Player)) AS LastName
FROM NFL.dbo.QBStats2019

--SELECT
--PARSENAME(REPLACE(Player, ' ', '.'), 2),
--PARSENAME(REPLACE(Player, ' ', '.'), 1)
--FROM NFL.dbo.QBStats2019

--2019
ALTER TABLE QBStats2019
ADD FirstName varchar(50);
UPDATE QBStats2019
SET FirstName = SUBSTRING(Player, 1, CHARINDEX(' ', Player) -1)

ALTER TABLE QBStats2019
ADD LastName varchar(50);
UPDATE QBStats2019
SET LastName = SUBSTRING(Player, CHARINDEX(' ', Player) + 1, LEN(Player))
---
ALTER TABLE ScrimmageStats2019
ADD FirstName varchar(50);
UPDATE ScrimmageStats2019
SET FirstName = SUBSTRING(Player, 1, CHARINDEX(' ', Player) -1)


ALTER TABLE ScrimmageStats2019
ADD LastName varchar(50);
UPDATE ScrimmageStats2019
SET LastName = SUBSTRING(Player, CHARINDEX(' ', Player) + 1, LEN(Player))
--2020
ALTER TABLE QBStats2020
ADD FirstName varchar(50);
UPDATE QBStats2020
SET FirstName = SUBSTRING(Player, 1, CHARINDEX(' ', Player) -1)

ALTER TABLE QBStats2020
ADD LastName varchar(50);
UPDATE QBStats2020
SET LastName = SUBSTRING(Player, CHARINDEX(' ', Player) + 1, LEN(Player))
---
ALTER TABLE ScrimmageStats2020
ADD FirstName varchar(50);
UPDATE ScrimmageStats2020
SET FirstName = SUBSTRING(Player, 1, CHARINDEX(' ', Player) -1)

ALTER TABLE ScrimmageStats2020
ADD LastName varchar(50);
UPDATE ScrimmageStats2020
SET LastName = SUBSTRING(Player, CHARINDEX(' ', Player) + 1, LEN(Player))
--2021
ALTER TABLE QBStats2021
ADD FirstName varchar(50);
UPDATE QBStats2021
SET FirstName = PARSENAME(REPLACE(Player, ' ', '.'), 2)

ALTER TABLE QBStats2021
ADD LastName varchar(50);
UPDATE QBStats2021
SET LastName = SUBSTRING(Player, CHARINDEX(' ', Player) + 1, LEN(Player))
------------------
--19
ALTER TABLE ScrimmageStats2019
ADD FirstName varchar(50);
UPDATE ScrimmageStats2019
SET FirstName = SUBSTRING(Player, 1, CHARINDEX(' ', Player) -1)

ALTER TABLE ScrimmageStats2019
ADD LastName varchar(50);
UPDATE ScrimmageStats2019
SET LastName = SUBSTRING(Player, CHARINDEX(' ', Player) + 1, LEN(Player))
--20
ALTER TABLE ScrimmageStats2020
ADD FirstName varchar(50);
UPDATE ScrimmageStats2020
SET FirstName = SUBSTRING(Player, 1, CHARINDEX(' ', Player) -1)

ALTER TABLE ScrimmageStats2020
ADD LastName varchar(50);
UPDATE ScrimmageStats2020
SET LastName = SUBSTRING(Player, CHARINDEX(' ', Player) + 1, LEN(Player))
--21
ALTER TABLE ScrimmageStats2021
ADD FirstName varchar(50);
UPDATE ScrimmageStats2021
SET FirstName = SUBSTRING(Player, 1, CHARINDEX(' ', Player) -1)

ALTER TABLE ScrimmageStats2021
ADD LastName varchar(50);
UPDATE ScrimmageStats2021
SET LastName = SUBSTRING(Player, CHARINDEX(' ', Player) + 1, LEN(Player))

---Check
SELECT FirstName, LastName, Player
FROM ScrimmageStats2020

---Standardizing Team Names For all Tables
/*
There are a few teams in whose team team names differ due to name or locations changes.
Also, some tables give abbreviated names for teams, and some give full names. 
*/
ALTER TABLE AllTeamStats
ADD NewTeam varchar(50);

UPDATE AllTeamStats
SET NewTeam = CASE
					WHEN tm like 'Washington%' THEN 'Washington Commanders'
					WHEN tm like 'Oakland%' THEN 'Las Vegas Raiders'
					ELSE tm
					END
					FROM AllTeamStats


SELECT QBStats2021.TM, AllTeamStats.NewTeam FROM AllTeamStats
FULL OUTER JOIN QBStats2021
ON SUBSTRING(AllTeamStats.NewTeam, 1, 3) = QBStats2021.tm
GROUP BY AllTeamStats.NewTeam, QBStats2021.TM


UPDATE QBStats2019
SET NewTeam =  
CASE
	WHEN Tm = 'GNB' THEN 'Green Bay Packers'
	WHEN Tm = 'JAX' THEN 'Jacksonville Jaguars'
	WHEN Tm = 'LAC' THEN 'Los Angeles Chargers'
	WHEN Tm = 'LAR' THEN 'Los Angeles Rams'
	WHEN Tm = 'NOR' THEN 'New Orleans Saints'
	WHEN Tm = 'NWE' THEN 'New England Patriots' 
	WHEN Tm = 'NYG' THEN 'New York Giants'
	WHEN Tm = 'NYJ' THEN 'New York Jets'
	WHEN Tm = 'OAK' THEN 'Las Vegas Raiders'
	WHEN Tm = 'SFO' THEN 'San Francisco 49ers'
	ELSE Tm
	END 

ALTER TABLE QBStats2020
ADD NewTeam Varchar(50)
UPDATE QBStats2020
SET NewTeam =  
CASE
	WHEN Tm = 'GNB' THEN 'Green Bay Packers'
	WHEN Tm = 'JAX' THEN 'Jacksonville Jaguars'
	WHEN Tm = 'LAC' THEN 'Los Angeles Chargers'
	WHEN Tm = 'LAR' THEN 'Los Angeles Rams'
	WHEN Tm = 'NOR' THEN 'New Orleans Saints'
	WHEN Tm = 'NWE' THEN 'New England Patriots' 
	WHEN Tm = 'NYG' THEN 'New York Giants'
	WHEN Tm = 'NYJ' THEN 'New York Jets'
	WHEN Tm = 'LVR' THEN 'Las Vegas Raiders'
	WHEN Tm = 'SFO' THEN 'San Francisco 49ers'
	ELSE Tm
	END 

ALTER TABLE QBStats2021
ADD NewTeam Varchar(50)
UPDATE QBStats2021
SET NewTeam =  
CASE
	WHEN Tm = 'GNB' THEN 'Green Bay Packers'
	WHEN Tm = 'JAX' THEN 'Jacksonville Jaguars'
	WHEN Tm = 'LAC' THEN 'Los Angeles Chargers'
	WHEN Tm = 'LAR' THEN 'Los Angeles Rams'
	WHEN Tm = 'NOR' THEN 'New Orleans Saints'
	WHEN Tm = 'NWE' THEN 'New England Patriots' 
	WHEN Tm = 'NYG' THEN 'New York Giants'
	WHEN Tm = 'NYJ' THEN 'New York Jets'
	WHEN Tm = 'LVR' THEN 'Las Vegas Raiders'
	WHEN Tm = 'SFO' THEN 'San Francisco 49ers'
	ELSE Tm
	END 

--Putting all QB Stats in one table
/*
I realized that a lot of the code was redundent earlier, and I could have simply unionized some tables
*/
SELECT * INTO AllQBStats
	FROM QBStats2019
	UNION
	SELECT * FROM QBStats2020
	UNION
	SELECT * FROM QBStats2021

SELECT * FROM AllQBStats

SELECT AllQBStats.NewTeam, AllTeamStats.NewTeam FROM AllTeamStats
FULL OUTER JOIN AllQBStats
ON SUBSTRING(AllTeamStats.NewTeam, 1, LEN(AllQBStats.NewTeam)) = AllQBStats.NewTeam
GROUP BY AllTeamStats.NewTeam, AllQBStats.NewTeam

--Putting all Scrimmage Stats in one table
SELECT * INTO AllScrimmageStats
	FROM ScrimmageStats2019
	UNION
	SELECT * FROM ScrimmageStats2020
	UNION
	SELECT * FROM ScrimmageStats2021

SELECT * FROM AllScrimmageStats

--- Standardizing team names for the scrimmage stats
SELECT AllScrimmageStats.tm, AllTeamStats.NewTeam FROM AllTeamStats
FULL OUTER JOIN AllScrimmageStats
ON SUBSTRING(AllTeamStats.NewTeam, 1, 3) = AllScrimmageStats.tm
GROUP BY AllTeamStats.NewTeam, AllScrimmageStats.tm

ALTER TABLE  AllScrimmageStats
ADD NewTeam Varchar(50)
UPDATE AllScrimmageStats
SET NewTeam =  
CASE
	WHEN Tm = 'GNB' THEN 'Green Bay Packers'
	WHEN Tm = 'JAX' THEN 'Jacksonville Jaguars'
	WHEN Tm = 'LAC' THEN 'Los Angeles Chargers'
	WHEN Tm = 'LAR' THEN 'Los Angeles Rams'
	WHEN Tm = 'NOR' THEN 'New Orleans Saints'
	WHEN Tm = 'NWE' THEN 'New England Patriots' 
	WHEN Tm = 'NYG' THEN 'New York Giants'
	WHEN Tm = 'NYJ' THEN 'New York Jets'
	WHEN Tm = 'LVR' THEN 'Las Vegas Raiders'
	WHEN Tm = 'OAK' THEN 'Las Vegas Raiders'
	WHEN Tm = 'SFO' THEN 'San Francisco 49ers'
	ELSE Tm
	END 

SELECT AllScrimmageStats.NewTeam, AllTeamStats.NewTeam FROM AllTeamStats
FULL OUTER JOIN AllScrimmageStats
ON SUBSTRING(AllTeamStats.NewTeam, 1, len(AllScrimmageStats.NewTeam)) = AllScrimmageStats.NewTeam
GROUP BY AllTeamStats.NewTeam, AllScrimmageStats.NewTeam


--- Rushing leaders over the past three seasons
CREATE VIEW BestRBs AS
SELECT TOP(20) Player, SUM(Yds1) AS SumOfYds
FROM AllScrimmageStats
GROUP BY Player
ORDER BY SUM(Yds1) DESC

---Extracting Location From The Team Name
/*
This was tricky to figure out, because some team locations had more than one word in them, so a simple parsename or substring function
wouldn't work. My goal for this was to extract the word 'Tampa Bay' from 'Tampa Bay Buccaneers' or 'Pittsburgh' from
'Pittsburgh Steelers'. First I calculated the amount of spaces that each team had after the first word. So 'Steelers' has
0 spaces, and 'Bey Buccaneers' has 1. No team had more than 1. Next I used this as a condition for a CASE statemt. If
a team had 0 spaces, I simply used the PARSENAME function. If it had 1 space then I created a SUNSTRING. This string started
at the beginning of NewTeam string. I used the PARSENAME function to determine the length of the first word and length of the 
second word, and this determined the length of the substring. 
*/
SELECT
CASE 
	WHEN LEN(SUBSTRING(NewTeam, CHARINDEX(' ', NewTeam) + 1, LEN(NewTeam))) -
LEN(SUBSTRING(REPLACE(NewTeam, ' ', ''), CHARINDEX(' ', NewTeam), LEN(NewTeam))) = 0
		THEN PARSENAME(REPLACE(NewTeam, ' ', '.'), 2)
	ELSE SUBSTRING(NewTeam, 1, LEN(PARSENAME(REPLACE(NewTeam, ' ', '.'), 3)+PARSENAME(REPLACE(NewTeam, ' ', '.'), 2))+1)
	END AS Location
FROM AllTeamStats


--- Average Rushing Yards For Each Team In The Last Three Seasons
CREATE VIEW AveRushYds AS

SELECT NewTeam, AVG(RushYds) AS AvgYd
, CASE
	WHEN NewTeam = 'New York Jets' THEN 'New York (2)' --This was so tableau didn't confuse the Jets and Giants
	WHEN LEN(SUBSTRING(NewTeam, CHARINDEX(' ', NewTeam) + 1, LEN(NewTeam))) - 
LEN(SUBSTRING(REPLACE(NewTeam, ' ', ''), CHARINDEX(' ', NewTeam), LEN(NewTeam))) = 0
		THEN PARSENAME(REPLACE(NewTeam, ' ', '.'), 2)
	ELSE SUBSTRING(NewTeam, 1, LEN(PARSENAME(REPLACE(NewTeam, ' ', '.'), 3)+PARSENAME(REPLACE(NewTeam, ' ', '.'), 2))+1)
	END AS Location
FROM AllTeamStats
GROUP BY NewTeam

--- Finding how yards from a team's leading rusher realates to points for the team throughout a given season
/*
This finds the each teams' leading rusher for all three seasons. I used the ROW_NUMBER function to count the rows and
PARTITIONED it over each team and season, then ordered it by rushing yards. This made it so that each time the row_number
was one, that player was their team's leading rusher. I repeated this process for recievers and passers.
*/
CREATE VIEW RushLeadsVsPF AS
WITH LeadRusherCTE AS
(
SELECT ROW_NUMBER() OVER ( 
	PARTITION BY NewTeam, Season
	ORDER BY Yds1 DESC 
	) rn, 
	NewTeam, Season, Player, Yds1
FROM AllScrimmageStats
)
SELECT tm.NewTeam, tm.Season, tm.PF, lr.Yds1
FROM LeadRusherCTE lr
INNER JOIN AllTeamStats tm
ON SUBSTRING(tm.NewTeam, 1, len(lr.NewTeam)) = lr.NewTeam AND tm.Season = lr.Season
WHERE rn = 1

--- Finding how yards from a team's leading reciever realates to points for the team throughout a given season
CREATE VIEW RecLeadsVsPF AS
WITH LeadRecieverCTE AS
(
SELECT ROW_NUMBER() OVER ( 
	PARTITION BY NewTeam, Season
	ORDER BY Yds DESC 
	) rn, 
	NewTeam, Season, Player, Yds
FROM AllScrimmageStats
)
SELECT tm.NewTeam, tm.Season, tm.PF, lr.Yds
FROM LeadRecieverCTE lr
INNER JOIN AllTeamStats tm
ON SUBSTRING(tm.NewTeam, 1, len(lr.NewTeam)) = lr.NewTeam AND tm.Season = lr.Season
WHERE rn = 1

--- Finding how yards from a team's leading passer realates to points for the team throughout a given season
CREATE VIEW PassVsPF AS
WITH PassVsPFCTE AS
(
SELECT ROW_NUMBER() OVER ( 
	PARTITION BY NewTeam, Season
	ORDER BY Yds DESC 
	) rn, 
	NewTeam, Season, Player, Yds
FROM AllQBStats
)
SELECT tm.NewTeam, tm.Season, tm.PF, qb.Yds
FROM PassVsPFCTE qb
INNER JOIN AllTeamStats tm
ON SUBSTRING(tm.NewTeam, 1, len(qb.NewTeam)) = qb.NewTeam AND tm.Season = qb.Season
WHERE rn = 1

--- Progress of the top ten 2021 leading rushers
CREATE VIEW TopTenRushers AS
WITH CTE AS
(
SELECT TOP(10) Player, Season, Yds1
FROM AllScrimmageStats
WHERE Season = 2021
Order By Yds1 DESC
)
SELECT CTE.Player, s.Season, s.Yds1
FROM CTE
INNER JOIN AllScrimmageStats s
ON s.Player = CTE.Player
Order BY Player