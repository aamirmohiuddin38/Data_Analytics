--Select Warehouse, Database and Schema

USE WAREHOUSE AM_WAREHOUSE;
USE DATABASE CRICKET;
USE SCHEMA BATBOWLODI;

-- Create a table for Bowlers Data to Clean it

CREATE OR REPLACE TABLE AM_BOWLERSDATA(
   ROWID     INTEGER,
   Overs      VARCHAR(4),
   Mdns       VARCHAR(1),
   Runs       VARCHAR(3),
   Wkts       VARCHAR(3),
   Econ       VARCHAR(15),
   Ave        VARCHAR(10),
   SR         VARCHAR(10),
   Opposition VARCHAR(14),
   Ground     VARCHAR(25),
   Start_Date VARCHAR(15),
   Match_ID   VARCHAR(12) ,
   Bowler     VARCHAR(25),
   Player_ID  INTEGER  NOT NULL
);

-- Now Load Data into table -> Upload csv
-- Data Loaded Successfully : Help & Support -> Upload CSV -> Select Warehouse,Db and Table -> Data will get loaded.

SELECT * FROM AM_BOWLERSDATA LIMIT 10;

-------------------------------- Let the Cleaning Start ------------------------------------

DELETE FROM AM_BOWLERSDATA WHERE OVERS = '-';

---------      Economy = RUNS / OVERS
---------      Bowling Average = RUNS / WKTS
---------      Bowling Strike Rate = (OVERS * 6) / WKTS

------------- Now let's update the missing values following above expression ---------------

UPDATE AM_BOWLERSDATA
	SET ECON = RUNS / OVERS,
	    AVE = RUNS / WKTS,
	    SR = (OVERS * 6 ) / WKTS;

-- We get divide by zero error because WKTS value is 0 in some cases. This is resolved as:

UPDATE AM_BOWLERSDATA
	SET ECON = RUNS / OVERS,
        AVE = CASE WHEN WKTS = 0 THEN RUNS ELSE AVE END,
        SR =  CASE WHEN WKTS = 0 THEN OVERS * 6 ELSE SR END;
        

ALTER TABLE AM_BOWLERSDATA
    ADD COLUMN ECON_TEMP NUMBER(5,2),
               AVE_TEMP NUMBER(5,2),
               SR_TEMP NUMBER(5,2);
       
UPDATE AM_BOWLERSDATA
    SET ECON_TEMP = ECON,
        AVE_TEMP = AVE,
        SR_TEMP = SR;

ALTER TABLE AM_BOWLERSDATA
    DROP COLUMN ECON, AVE, SR;
    
ALTER TABLE AM_BOWLERSDATA
    RENAME COLUMN ECON_TEMP TO ECON;
    
ALTER TABLE AM_BOWLERSDATA
    RENAME COLUMN AVE_TEMP TO AVE;
    
ALTER TABLE AM_BOWLERSDATA
    RENAME COLUMN SR_TEMP TO SR;
                  
----------------------------------------------------------------------------------------------------------

SELECT * FROM AM_BOWLERSDATA LIMIT 5;

ALTER TABLE AM_BOWLERSDATA
    DROP COLUMN ROWID;
    
-- Let's Change datatype of other columns as: 

ALTER TABLE AM_BOWLERSDATA
    ADD COLUMN OVERS_TEMP NUMBER(3,1),
               MDNS_TEMP NUMBER(3),
               RUNS_TEMP NUMBER(4),
               WKTS_TEMP NUMBER(3);
               
UPDATE AM_BOWLERSDATA
    SET OVERS_TEMP = OVERS,
        MDNS_TEMP = MDNS,
        RUNS_TEMP = RUNS,
        WKTS_TEMP = WKTS;
        
ALTER TABLE AM_BOWLERSDATA
        DROP COLUMN OVERS, MDNS, RUNS, WKTS;
        

ALTER TABLE AM_BOWLERSDATA
    RENAME COLUMN OVERS_TEMP TO OVERS;

ALTER TABLE AM_BOWLERSDATA
    RENAME COLUMN MDNS_TEMP TO MDNS;
    
ALTER TABLE AM_BOWLERSDATA
    RENAME COLUMN RUNS_TEMP TO RUNS;
    
ALTER TABLE AM_BOWLERSDATA
    RENAME COLUMN WKTS_TEMP TO WKTS;
           
------------------------------------------------------------------------------------------------------------

-- Now Lets work on Date column

ALTER TABLE AM_BOWLERSDATA
    ADD COLUMN START_DATE_TEMP DATE;
    
UPDATE AM_BOWLERSDATA
    SET START_DATE_TEMP = TO_DATE(START_DATE,'DD MON YYYY');
    
ALTER TABLE AM_BOWLERSDATA
    DROP COLUMN START_DATE;
    
ALTER TABLE AM_BOWLERSDATA
    RENAME COLUMN START_DATE_TEMP TO START_DATE;


------------------------------------------------------------------------------------------------------------

-- Create Table from the cleaned one to align columns in proper postitons as they were:

CREATE OR REPLACE TABLE BOWLERS_DATA AS 
        (
            SELECT OVERS, MDNS, RUNS, WKTS, ECON, AVE, SR, OPPOSITION, GROUND, START_DATE, MATCH_ID, BOWLER, PLAYER_ID 
                FROM AM_BOWLERSDATA
        );

SELECT * FROM BOWLERS_DATA LIMIT 4;

-- We Can Drop Old Table Now:

DROP TABLE AM_BOWLERSDATA;

--------------------------------------------------------------------------------------------------------------


  -- ******************** Learning Stuff - for Clearing Confusions  ************************************ --


CREATE OR REPLACE TABLE dummytbl AS
        (select * from am_bowlersdata);
    
SELECT * FROM DUMMYTBL LIMIT 10;

ALTER TABLE DUMMYTBL
    ALTER COLUMN ECON VARCHAR(20),
                 AVE VARCHAR(10),
                 SR VARCHAR(10);

ALTER TABLE DUMMYTBL
    ADD  CONSTRAINT PK_PLAYER PRIMARY KEY(MATCH_ID, PLAYER_ID);

UPDATE DUMMYTBL
	SET ECON = RUNS / OVERS,
        AVE = CASE WHEN WKTS = 0 THEN RUNS ELSE AVE END,
        SR =  CASE WHEN WKTS = 0 THEN OVERS * 6 ELSE SR END;
        
ALTER TABLE IF EXISTS DUMMYTBL
    ADD COLUMN ECON_TEMP NUMBER(4,2),
                AVE_TEMP NUMBER(4,2),
                SR_TEMP NUMBER(4,2);
 
 alter table if exists dummytbl
    modify column econ_temp number(5,2),
                  ave_temp number(5,2),
                  sr_temp number(5,2);
 
update DUMMYTBL
    set ECON_TEMP = ECON,
        AVE_TEMP = AVE,
        SR_TEMP = SR;
    
select * from dummytbl order by overs limit 4;
    
    
drop table DUMMYTBL;


------------------------------------------------------------------------------------------------------------------------------------------
