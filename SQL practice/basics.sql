-- show databases;
-- select database();
-- use photo_store;
-- select database();

-- TODO: CREATE TABLE

-- CREATE TABLE cameras(
--     model_name VARCHAR(30),
--     quantity INT
-- );

-- DESC cameras;

-- DROP TABLE CAMERAS;

-- CREATE TABLE canon_cameras(
--     model_name VARCHAR(30),
--     quantity INT
-- );

-- DESC canon_cameras;

-- TODO: INSERT DATA INTO TABLE

-- INSERT INTO canon_cameras(model_name, quantity)
-- VALUES("70-D",12),
-- ("80D", 19),
-- ("EOS-R", 25),
-- ("ROS-r5",80),
-- ("EOR-r6",50);

-- TODO: Answering Customer questions
-- SELECT * FROM canon_cameras;
-- select model_name from canon_cameras;

-- SELECT model_name, quantity from canon_cameras
-- WHERE model_name = "80D";

-- SELECT model_name, quantity FROM canon_cameras
-- WHERE quantity >= 50;