CREATE SCHEMA Examples;
GO

CREATE TABLE Examples.UniquenessConstraint
(
  PrimaryUniqueValue int NOT NULL,
  AlternateUniqueValue1 int NULL,
  AlternateUniqueValue2 int Null
  );
  CREATE SCHEMA Constraint;
  GO
  ALTER TABLE Examples.UniquenessConstraint
    ADD CONSTRAINT PKUniquenessConstraint PRIMARY KEY 
	(PrimaryUniqueValue);