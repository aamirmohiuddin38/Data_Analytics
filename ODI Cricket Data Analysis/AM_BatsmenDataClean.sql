---------------------------------------------------------------------------------------------------------------------
-- Creating Table 

CREATE OR REPLACE TABLE AM_BATSMEN_DATA (
 Row_id      INTEGER,
  Bat1       VARCHAR(6),
  Runs       VARCHAR(10),
  BF         VARCHAR(5),
  SR         VARCHAR(7),
  `4s`         VARCHAR(3),
  `6s`         VARCHAR(3),
  Opposition VARCHAR(14),
  Ground     VARCHAR(21),
  Start_Date VARCHAR(10),
  Match_ID    VARCHAR(10),
  Batsman    VARCHAR(21),
  Player_ID  NUMBER(10) 
);
--------------------------------------------------------------------------------------------------------------------
-- Load Data into table
-- using snowflake options (HELP & SUPPORT -> UPLOAD CSV)
--------------------------------------------------------------------------------------------------------------------

Select * from AM_BATSMEN_DATA LIMIT 3;

--------------------------------------------------------------------------------------------------------------------

-- Let the cleaning start
-- DNB, TDNB does not contribute to any stats, so lets delete these type of rows 

Delete from AM_BATSMEN_DATA
    WHERE BAT1 IN('DNB', 'TDNB', 'sub', 'absent');
    
SELECT COUNT(*) FROM AM_BATSMEN_DATA;

SELECT * FROM AM_BATSMEN_DATA WHERE SR = '-';

DELETE FROM AM_BATSMEN_DATA WHERE SR = '-';

-- Check - for all columns
SELECT * FROM AM_BATSMEN_DATA WHERE '-' IN (BAT1, BF, Runs, SR, `4s`, `6s`);

-- As the above query produced no results, that indicates data is lil bit clean, now we can change the schema of table (datatypes we need to)

-------------------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE AM_BATSMEN_DATA
MODIFY COLUMN RUNS NUMBER(5);

-- snowflake does not allow us to change the datatype of column from string or varchar to number, so we create a duplicate column as:

-------------------------------------------------------------------------------------------------------------------------------------------------
-- RUNS COLUMN
-- 1. Add new colum
ALTER TABLE AM_BATSMEN_DATA
ADD COLUMN RUNS_TEMP NUMBER(3);

-- 2. Update new column with Values of Existing(Old) column
UPDATE AM_BATSMEN_DATA
SET RUNS_TEMP = RUNS;

-- 3. Drop the Old Column
ALTER TABLE AM_BATSMEN_DATA
DROP COLUMN RUNS;

-- 4. Rename New Column
ALTER TABLE AM_BATSMEN_DATA
RENAME COLUMN RUNS_TEMP TO RUNS;

--------------------------------------------------------------------------------------------------------------------------------------
-- Now we have to repeat the same for other columns as well

-- OTHER COLUMNS (BF,SR,4S,6S)
-- 1. Adding new colums
ALTER TABLE AM_BATSMEN_DATA
ADD COLUMN 
    BF_TEMP NUMBER(3),
    SR_TEMP NUMBER(5,2),
    `4s_TEMP` NUMBER(3),
    `6s_TEMP` NUMBER(3);

-- 2. Update new column with Values of Existing(Old) column
UPDATE AM_BATSMEN_DATA
    SET BF_TEMP = BF,
        SR_TEMP = SR,
        `4s_TEMP` = `4s`,
        `6s_TEMP` = `6s`;

-- 3. Drop the Old Column
ALTER TABLE AM_BATSMEN_DATA
DROP COLUMN BF,
            SR,
            `4s`,
            `6s`;

-- 4. Rename New Column
ALTER TABLE AM_BATSMEN_DATA
    RENAME COLUMN BF_TEMP TO BF;
    
ALTER TABLE AM_BATSMEN_DATA    
    RENAME COLUMN `4s_TEMP` TO `4S`;
    
ALTER TABLE AM_BATSMEN_DATA    
    RENAME COLUMN `6s_TEMP` TO `6s`;
    
ALTER TABLE AM_BATSMEN_DATA
    RENAME COLUMN SR_TEMP TO SR;
   
 --------------------------------------------------------------------------------------------------------------------------------------  
    
    -- Change Dataype of START_DATE to DATE 
    
    SELECT YEAR(START_DATE) AS years from AM_BATSMEN_DATA LIMIT 3;
    -- this will not extract as datatype is not proper, now lets update the datatype
    
    UPDATE AM_BATSMEN_DATA
        SET DATE_TEMP = TO_DATE(DATE_TEMP, 'YYYY-MM-DD');

ALTER TABLE AM_BATSMEN_DATA
    ADD COLUMN DATE_TEMP VARCHAR(12);
    
ALTER TABLE AM_BATSMEN_DATA
    DROP COLUMN DATE_TEMP;

UPDATE AM_BATSMEN_DATA
    SET DATE_TEMP = CONCAT('20', START_DATE);

Select * from AM_BATSMEN_DATA LIMIT 3;

SELECT RIGHT('SQL Tutorial is cool',20-4) AS ExtractString;

SELECT RIGHT(DATE_TEMP, LEN(DATE_TEMP) -2)  FROM AM_BATSMEN_DATA LIMIT 2;

SELECT CONCAT('20', 10-01-10);

SELECT YEAR(DATE_TEMP), MONTH(DATE_TEMP) FROM AM_BATSMEN_DATA LIMIT 3;


ALTER TABLE AM_BATSMEN_DATA
    ADD COLUMN START_DATE_TMP DATE;
    
UPDATE AM_BATSMEN_DATA
    SET START_DATE_TMP = DATE_TEMP;

ALTER TABLE AM_BATSMEN_DATA
    DROP COLUMN DATE_TEMP;

ALTER TABLE AM_BATSMEN_DATA
    DROP COLUMN START_DATE;
    
ALTER TABLE AM_BATSMEN_DATA
    RENAME COLUMN START_DATE_TMP TO START_DATE;

---------------------------------------------------------------------------------------------------------------------------------------------

-- Further Cosmetic part
ALTER TABLE AM_BATSMEN_DATA
    DROP COLUMN ROW_ID;
    
-- Create Table from the cleaned one to align columns in proper postitons as they were:

CREATE TABLE BATSMAN_DATA AS
    (
        SELECT BAT1, RUNS, BF, SR, `4s`, `6s`, OPPOSITION, GROUND, START_DATE, MATCH_ID, BATSMAN, PLAYER_ID
            FROM AM_BATSMEN_DATA
    );
    
SELECT * FROM BATSMAN_DATA ORDER BY BATSMAN;

-- We Can Drop Old Table Now:

DROP TABLE AM_BATSMEN_DATA;
-------------------------------------------------------------------------------------------------------------------------------


-- Learning/Confusion?



SELECT LENGTH(OPPOSITION) FROM BATSMAN_DATA LIMIT 1;

WITH BestScore AS
(
    SELECT BATSMAN, MAX(RUNS) AS BEST
    FROM BATSMAN_DATA
    GROUP BY BATSMAN
 )
 SELECT BestScore.BATSMAN, BestScore.BEST, B.BAT1
    FROM BestScore
    INNER JOIN BATSMAN_DATA B
    ON B.RUNS = BestScore.BEST
    ORDER BY BestScore.BEST DESC;
 
    
----------------------------------------------------------------------------
    
    
    