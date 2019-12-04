CREATE TABLE Examples.Gadget
(
GadgetId int NOT NULL CONSTRAINT PKGadget PRIMARY KEY,
GadgetNumber char (8) NOT NULL CONSTRAINT AKGadget UNIQUE,
GadgetType varchar (10)		NOT NULL
);

INSERT INTO Examples.Gadget (GadgetId, GadgetNumber, GadgetType)
VALUES (1,'00000001','Electronic'),
       (2,'00000002','Manual'),
	   (3,'00000003','Manual');
GO

CREATE VIEW Examples.ElectronicGadget
AS
  SELECT GadgetId, GadgetNumber, GadgetType,
     UPPER(GadgetType) AS UpperGadgetType
	 FROM Examples.Gadget
	 WHERE GadgetType = 'Electronic';
	 GO

	 SELECT * FROM Examples.Gadget;
	 SELECT * FROM Examples.ElectronicGadget;
SELECT ElectronicGadget.GadgetNumber AS FromView,
       Gadget.GadgetNumber AS FromTable, Gadget.GadgetType, ElectronicGadget.UpperGadgetType
FROM Examples.ElectronicGadget
FULL OUTER JOIN Examples.Gadget
ON ElectronicGadget.GadgetId = Gadget.GadgetId;
GO

INSERT INTO Examples.ElectronicGadget(GadgetId, GadgetNumber, GadgetType)
VALUES (4, '00000004', 'Electronic'),
       (5, '00000005' , 'Manual');

UPDATE Examples.ElectronicGadget
SET GadgetType = 'Manual'
WHERE GadgetNumber = '000000004';
GO

UPDATE Examples.ElectronicGadget
SET GadgetType = 'Electronic'
WHERE GadgetNumber = '0000005';
GO

ALTER VIEW Examples.ElectronicGadget
AS
SELECT GadgetId, GadgetNumber, GadgetType,
UPPER(GadgetType) AS UpperGadgetType
FROM Examples.Gadget
WHERE GadgetType = 'Electronic'
WITH CHECK OPTION;
GO

INSERT INTO Examples.ElectronicGadget(GadgetId, GadgetNumber, GadgetType)
VALUES(6, '0000006','Electronic');
GO

UPDATE Examples.ElectronicGadget
SET GadgetType = 'Manual'
WHERE GadgetNumber = '00000004';
GO