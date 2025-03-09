CREATE DATABASE soccer;
SHOW DATABASES;
USE soccer;
SELECT DATABASE();

DROP TABLE IF EXISTS players;

CREATE TABLE players (
    Wage VARCHAR(50),
    Value VARCHAR(50),
    Name VARCHAR(100),
    Age INT,
    Nationality VARCHAR(50),
    Overall INT,
    Potential INT,
    Club VARCHAR(100),
    Special INT,
    Acceleration INT,
    Aggression INT,
    Agility INT,
    Balance INT,
    Ball_control INT,
    Composure INT,
    Crossing INT,
    Curve INT,
    Dribbling INT,
    Finishing INT,
    Free_kick_accuracy INT,
    GK_diving INT,
    GK_handling INT,
    GK_kicking INT,
    GK_positioning INT,
    GK_reflexes INT,
    Heading_accuracy INT,
    Interceptions INT,
    Jumping INT,
    Long_passing INT,
    Long_shots INT,
    Marking INT,
    Penalties INT,
    Positioning INT,
    Reactions INT,
    Short_passing INT,
    Shot_power INT,
    Sliding_tackle INT,
    Sprint_speed INT,
    Stamina INT,
    Standing_tackle INT,
    Strength INT,
    Vision INT,
    Volleys INT,
    CAM INT,
    CD INT,
    CDM INT,
    CF INT,
    CM INT,
    
    LAM INT,
    LB INT,
    LCB INT,
    LCM INT,
    LDM INT,
    LF INT,
    LM INT,
    LS INT,
    LW INT,
    LWB INT,
    Preferred_positions VARCHAR(100),
    RAM INT,
    RB INT,
    RCB INT,
    RCM INT,
    RDM INT,
    RF INT,
    RM INT,
    RS INT,
    RW INT,
    RWB INT,
    ST INT
);
ALTER TABLE players 
ADD COLUMN ID INT AFTER CM;

SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'players';

SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'players';

ALTER TABLE players 
MODIFY COLUMN RAM VARCHAR(50),
MODIFY COLUMN LAM VARCHAR(50),
MODIFY COLUMN Preferred_positions VARCHAR(50);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Fifa_Olympics_Cleaned.csv'
INTO TABLE players
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


DESC players;
SHOW TABLES;
SHOW VARIABLES LIKE 'secure_file_priv';

#  1. Identify the top players by overall rating.

SELECT Name, Age, Nationality, Club, Overall 
FROM players 
ORDER BY Overall DESC 
LIMIT 10;

#  2. Calculate the average age of players in each position.

SELECT Preferred_positions, FLOOR(AVG(Age)) AS Avg_Age
FROM players
GROUP BY Preferred_positions
ORDER BY Avg_Age DESC;

# 3. Determine the market value distribution among different nationalities.
SELECT Nationality, 
       COUNT(*) AS Player_Count,
       SUM(Value) AS Total_Value,
       ROUND(AVG(Value)) AS Avg_Value
FROM players
GROUP BY Nationality
ORDER BY Total_Value DESC;

# 4. Analyze performance metrics of players by club.

SELECT Club, 
       COUNT(*) AS Player_Count,
       ROUND(AVG(Overall), 2) AS Avg_Overall,
       ROUND(AVG(Potential), 2) AS Avg_Potential,
       ROUND(AVG(Acceleration), 2) AS Avg_Acceleration,
       ROUND(AVG(Dribbling), 2) AS Avg_Dribbling,
       ROUND(AVG(Short_passing), 2) AS Avg_Short_Passing,
       ROUND(AVG(Sprint_Speed), 2) AS Avg_Sprint_Speed
FROM players
WHERE Club IS NOT NULL AND Club <> ''
GROUP BY Club
ORDER BY Avg_Overall DESC;

# 5. Find the most common positions played by top-performing players.

SELECT Preferred_positions, COUNT(*) AS Player_Count
FROM players
WHERE Overall >= 85  -- Replace 85 with the actual percentile value
GROUP BY Preferred_positions
ORDER BY Player_Count DESC;

# 6. Identify players with the highest acceleration and agility ratings.

SELECT Name, Acceleration, Agility, Overall, Club, Nationality  
FROM players  
ORDER BY Acceleration DESC, Agility DESC  
LIMIT 10;

# 7. Calculate the average wage for players in each league.

SELECT Club, AVG(CAST(REPLACE(Wage, '$', '') AS SIGNED)) AS Avg_Wage  
FROM players  
GROUP BY Club  
ORDER BY Avg_Wage DESC;

# 8. Discover trends in player performance over the last few seasons.

SELECT Age, AVG(Overall) AS Avg_Overall_Rating
FROM players
GROUP BY Age
ORDER BY Age;


# 9. Determine the potential vs. overall rating for young talents.

SELECT Name, Age, Overall, Potential, (Potential - Overall) AS Growth_Potential
FROM players
WHERE Age < 23
ORDER BY Growth_Potential DESC;

#  10.Identify players with multiple preferred positions and their performance metrics.

SELECT Name, Age, Overall, Potential, Preferred_positions, Acceleration, Dribbling, Short_passing, Sprint_speed
FROM players
WHERE Preferred_positions LIKE '%,%'
ORDER BY Overall DESC;


#  11. Analyze correlations between physical attributes and skill ratings.

SELECT 
    ROUND(AVG(Strength), 2) AS Avg_Strength,
    ROUND(AVG(Stamina), 2) AS Avg_Stamina,
    ROUND(AVG(Sprint_speed), 2) AS Avg_SprintSpeed,
    ROUND(AVG(Dribbling), 2) AS Avg_Dribbling,
    ROUND(AVG(Short_passing), 2) AS Avg_ShortPassing,
    ROUND(AVG(Ball_control), 2) AS Avg_BallControl
FROM players;


#  12.Calculate the average market value of players by age group.

SELECT 
    CASE 
        WHEN Age BETWEEN 16 AND 20 THEN '16-20'
        WHEN Age BETWEEN 21 AND 25 THEN '21-25'
        WHEN Age BETWEEN 26 AND 30 THEN '26-30'
        WHEN Age BETWEEN 31 AND 35 THEN '31-35'
        ELSE '36+'
    END AS Age_Group,
    ROUND(AVG(Value), 2) AS Avg_Market_Value
FROM players
GROUP BY Age_Group
ORDER BY Age_Group;


#  13.Identify players with the best free-kick accuracy.

SELECT Name, Age, Nationality, Club, Free_kick_accuracy 
FROM players
ORDER BY Free_kick_accuracy DESC
LIMIT 10;



#  15.Develop queries to identify players at risk of being transferred based on
    #performance.

SELECT Name, Club, Age, Overall, Potential, Wage  
FROM players  
WHERE Overall < 60  -- Low overall rating  
   OR Age > 32;  -- Older players  









