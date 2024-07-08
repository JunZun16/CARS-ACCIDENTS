USE cars_accidents;
SELECT * FROM dbo.accidents
SELECT * FROM DBO.vehicle


--QUESTION 1 HOW MANY ACCIDENTS HAVE OCURREDIN URBAN AREAS VS RURAL AREAS?
SELECT 
	Area,
	COUNT(AccidentIndex) as 'Total Accident'
FROM 
	dbo.accidents
GROUP BY
	Area

--QUESTION WHICH DAY OF THE WEEK HAS THE HIGHEST NUMBER OF ACCIDENTS
SELECT 
	Day,
	COUNT(AccidentIndex) as 'Total Accident'
FROM 
	dbo.accidents
GROUP BY
	Day
ORDER BY 
	[Total Accident] desc

--QUESTION 3 WHAT IS THE AVERAGE AGE OF VEHICLES INVOLVED IN ACCIDENTS BASED ON THEIR TYPE?
SELECT 
	VehicleType,
	ROUND(AVG(AgeVehicle),2) AS 'Average Age Car',
	COUNT([AccidentIndex]) as 'Total Accident'
FROM 
	dbo.vehicle
WHERE 
	AgeVehicle IS NOT NULL
GROUP BY
	VehicleType
ORDER BY 
	'Total Accident'
-----------------------------------------
SELECT 
	ROUND(AVG(AgeVehicle),2) AS 'Average Age Car',
	COUNT([AccidentIndex]) as 'Total Accident',
	VehicleType
FROM 
	dbo.vehicle
GROUP BY
	VehicleType
ORDER BY 
	'Total Accident'

--QUESTION 4 Can we identify any trends in accidents based on the age of vehicles involved?
SELECT
	AgeGroup,
	ROUND(COUNT([AccidentIndex]),2) AS 'Total Accidents',
	ROUND(AVG([AgeVehicle]),2) AS 'Average Age Car'
FROM(
	SELECT
	[AccidentIndex],
	[AgeVehicle],
	CASE
		WHEN [AgeVehicle] BETWEEN 0 AND 5 THEN 'NEW'
		WHEN [AgeVehicle] BETWEEN 6 AND 10 THEN 'REGULAR'
		ELSE 'OLD'
	END AS 'AgeGroup'
	FROM vehicle
) AS SubQuery
GROUP BY 
	AgeGroup
ORDER BY
	[Total Accidents]

--QUESTION 5 ARE THERE ANY SPECIFIC WEATHER CONDITIONS THAT CONTRIBUTE TO SEVERE ACCIDENTS?
DECLARE @Severity varchar(100)
set @Severity='Fatal'
SELECT
	COUNT([Severity]) AS 'TOTAL ACCIDENT',
	[WeatherConditions]
FROM accidents
WHERE
	Severity=@Severity
GROUP BY 
	WeatherConditions
ORDER BY
	[TOTAL ACCIDENT]

--question 6 do accidents involve impacts on the left hand side of vehicles?
SELECT 
    [LeftHand],
	COUNT([AccidentIndex]) AS 'TOTAL ACCIDENTS'
 
FROM [cars_accidents].[dbo].[vehicle]

group by LeftHand
HAVING LeftHand IS NOT NULL 

--QUESTION 7 ARE THERE ANY RELATIOSHIP BETWEEN JOURNEY PURPOSES AND THE SEVERITY OF ACCIDENTS
SELECT
	V.JourneyPurpose,
	COUNT(A.Severity) AS 'Total Accidents',
	CASE
		WHEN COUNT(A.Severity) BETWEEN 0 AND 1000 THEN 'LOW'
		WHEN COUNT(A.Severity) BETWEEN 0 AND 4000 THEN 'MODERATE'
		ELSE 'HIGH'
	END AS 'LEVEL OF RELATIONSHIP'
FROM 
	accidents A
JOIN 
	vehicle V ON V.AccidentIndex=A.AccidentIndex
GROUP BY
	V.JourneyPurpose
ORDER BY
	[Total Accidents] DESC
