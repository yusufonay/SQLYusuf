CREATE DATABASE MyNewDatabase;
GO

CREATE SCHEMA MyCategory1;
GO

CREATE TABLE MyCategory1.NewTableName (
  MyTableId int PRIMARY KEY ,
  SometextValue varchar (100) NOT NULL,
  SomeIntValue int NULL
)
GO

ALTER TABLE MyCategory1.NewTableName
   ADD NewValue varchar(100) NOT NULL
GO

--CREATE INDEX 

--CREATE VIEWS

SELECT * FROM MyCategory1.NewTableName;