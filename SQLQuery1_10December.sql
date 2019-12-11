CREATE TABLE Examples.Parent
(
ParentId int NOT NULL CONSTRAINT PKPARENT PRIMARY KEY
);
CREATE TABLE Examples.Child
(
ChildId int NOT NULL CONSTRAINT PKChild PRIMARY KEY,
ParentId int NULL
);

ALTER TABLE Examples.Child

ADD CONSTRAINT FKChild_Ref_ExamplesParent
FOREIGN KEY (ParentId) REFERENCES Examples.Parent(ParentId);

INSERT INTO	Examples.Parent VALUES (10);

INSERT INTO Examples.Child VALUES (1, 10);

SELECT * FROM Examples.Parent;
SELECT * FROM Examples.Child;

CREATE TABLE Examples.TwoPartKey
(
KeyColumn1 int	NOT NULL,
KeyColumn2 int  NOT NULL,
CONSTRAINT PFTwoPartKey PRIMARY KEY (KeyColumn1, KeyColumn2)
);

INSERT INTO Examples.TwoPartKey VALUES (10, 10);
DROP TABLE IF EXISTS Examples.TwoPartKeyReferences;
CREATE TABLE Examples.TwoPartKeyReference
(
KeyColumn1 int NOT NULL,
KeyColumn2 int NOT NULL,
CONSTRAINT FKTwoPartKeyReference_Ref_ExamplesTwoPartKey
 FOREIGN KEY (KeyColumn1, KeyColumn2)
   REFERENCES Examples.TwoPartKey (KeyColumn1, KeyColumn2)
 );

 SELECT * FROM Examples.TwoPartKey;
 SELECT * FROM Examples.TwoPartKeyReference;

 CREATE TABLE Examples.Invoice
 (
 InvoiceId int NOT NULL CONSTRAINT PKInvoice PRIMARY KEY
 );

 CREATE TABLE Examples.InvoiceLineItem
 (
 InvoiceLineItemId int NOT NULL CONSTRAINT PKInvoiceLineItem PRIMARY KEY,
 InvoiceLineNumber smallint NOT NULL,
 InvoiceId int NOT NULL 
    CONSTRAINT FKInvoiceLineItem_Ref_ExamplesInvoice
	  REFERENCES Examples.Invoice(InvoiceId)
	    ON DELETE CASCADE
		ON UPDATE NO ACTION,
CONSTRAINT AKInvoiceLineItem UNIQUE (InvoiceId, InvoiceLineNumber)
);

INSERT INTO Examples.Invoice (InvoiceId)
VALUES (1), (2), (3);
INSERT INTO Examples.InvoiceLineItem(InvoiceLineItemId, InvoiceId, InvoiceLineNumber)
VALUES (1,1,1) , (2,1,2) , (3,2,1);
 SELECT Invoice.InvoiceId, InvoiceLineItem.InvoiceLineItemId
 FROM Examples.Invoice
      FULL OUTER JOIN Examples.InvoiceLineItem
	   ON Invoice.InvoiceId = InvoiceLineItem.InvoiceId;

DELETE Examples.Invoice
WHERE InvoiceId = 1;
     





