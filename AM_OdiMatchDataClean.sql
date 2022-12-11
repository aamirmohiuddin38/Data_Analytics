-- Select DataWarehous, Database and Schema
USE WAREHOUSE AM_WAREHOUSE;
USE DATABASE CRICKET;
USE SCHEMA BATBOWLODI;

-- Create table

CREATE OR REPLACE TABLE AM_ODIMATCH_RESULTS(
  ROWID     NUMBER(10),
  Result     VARCHAR(4) ,
  Margin     VARCHAR(10) ,
  BR         VARCHAR(5),
  Toss       VARCHAR(4) ,
  Bat        VARCHAR(3) ,
  Opposition VARCHAR(14) ,
  Ground     VARCHAR(18) ,
  Start_Date VARCHAR(12),
  Match_ID   VARCHAR(11) ,
  Country    VARCHAR(11) ,
  Country_ID NUMBER(3)
  );
  
  DESCRIBE TABLE AM_ODIMATCH_RESULTS;
  
  -- Load data into table 
  -- Help and Support -> Upload CSV -> Choose Warehouse, Database and Table
  -- Data Loaded Successfully.
  
  SELECT * FROM AM_ODIMATCH_RESULTS LIMIT 10;
  
  ------------------------------------ DATA CLEANING ---------------------------------------------
  
  -- Removing ROWID and BR Column as it is given they are IRRELEVANT
  
  ALTER TABLE AM_ODIMATCH_RESULTS
    DROP COLUMN ROWID, BR;

-- Let's Check for Blank, NULL or N/r(no result) in RESULT column -> Delete those, they make no sense in analysis.
-- We have n/r(no result), - , canc(cancelled), aban (match abondened) -> We can delete them

DELETE FROM AM_ODIMATCH_RESULTS WHERE RESULT NOT IN ('won','lost','tied');

---------------------------------------

-- Wherever there is 'tied' in result, we can replace respective MARGIN with 0
--- Since we have to update table, we may do something wrong, lets maintain transaction for this as:

SHOW TRANSACTIONS;

-- start transaction 
START TRANSACTION NAME updt_tied;    

-- transaction
UPDATE AM_ODIMATCH_RESULTS
    SET MARGIN = '0'
    WHERE RESULT = 'tied';
    
-- check result
SELECT * FROM AM_ODIMATCH_RESULTS WHERE RESULT = 'tied';

-- undo change if needed (incase results were wrong or updation would have produced unexpected results)
-- ROLLBACK;

-- updated successfully
COMMIT;

--------------------------------------
-- Change Datatype of START_DATE as:

ALTER TABLE AM_ODIMATCH_RESULTS
    ADD COLUMN START_DATE_TEMP DATE;
    
UPDATE AM_ODIMATCH_RESULTS
    SET START_DATE_TEMP = TO_DATE(START_DATE, 'DD MON YYYY');
    
ALTER TABLE AM_ODIMATCH_RESULTS
    DROP COLUMN START_DATE;
    
ALTER TABLE AM_ODIMATCH_RESULTS
    RENAME COLUMN START_DATE_TEMP TO START_DATE;
    
    
----------------------------------------

-- Creating the clean table 

CREATE OR REPLACE TABLE ODI_MATCH_RESULTS AS
    (
        SELECT RESULT, MARGIN, TOSS, BAT, START_DATE, OPPOSITION, GROUND, MATCH_ID, COUNTRY, COUNTRY_ID
            FROM AM_ODIMATCH_RESULTS
    );
    
SELECT * FROM ODI_MATCH_RESULTS LIMIT 4;

-- Drop Old table
DROP TABLE AM_ODIMATCH_RESULTS;

------------------------------------------







