CREATE TABLE Examples.SimpleTable
(
SimpleTableId int NOT NULL IDENTITY (1,1) PRIMARY KEY,
Value1 varchar (20) NOT NULL,
Value2 varchar (20) NOT NULL
);
CREATE PROCEDURE Examples.SimpleTable_Insert 
@Value1 varchar (20),
@Value2 varchar (20)
AS
  INSERT INTO Examples.SimpleTable(Value1, Value2)
  VALUES (@Value1, @value2);
  GO

EXEC Examples.SimpleTable_Insert  'MY VALUE 1' , 'MY VALUE2'

CREATE PROCEDURE Examples.SimpleTable_Update 
@SimpleTableId int,
@Value1 varchar (20),
@Value2 varchar (20)

AS
UPDATE  Examples.SimpleTable 
SET Value1 = @Value1,
    Value2 = @Value2
	WHERE SimpleTableId = @SimpleTableId;
  GO

  EXEC Examples.SimpleTable_Update 1, 'NEW VALUE 1' , 'NEW VALUE 2';
  SELECT * FROM Examples.SimpleTable

  CREATE PROCEDURE Examples.SimpleTable_Delete 
@SimpleTableId int
AS
DELETE FROM Examples.SimpleTable 
   
	WHERE SimpleTableId = @SimpleTableId;
  GO
  EXEC Examples.SimpleTable_Delete 1
  SELECT * FROM Examples.SimpleTable

  CREATE PROCEDURE Examples.SimpleTable_Select
  AS 
  SELECT SimpleTableId, Value1, Value2
  FROM Examples.SimpleTable
  ORDER BY Value1;

  CREATE PROCEDURE Examples.SimpleTable_SelectValue1StartWithQorZ
  AS
  SELECT *
  FROM Examples.SimpleTable
  WHERE Value1 LIKE 'Q%'
  ORDER BY Value1;

  SELECT *
  FROM Examples.SimpleTable
  WHERE Value1 LIKE 'Z%'
  ORDER BY Value1;
  GO

  INSERT INTO Examples.SimpleTable
  VALUES ('ZEBRA','ALPHA'), ('CHARLIE' , 'TANGO'), ('QUEBEC' , 'BETA')

  EXEC Examples.SimpleTable_SelectValue1StartWithQorZ