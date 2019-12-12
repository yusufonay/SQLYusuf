CREATE TABLE Examples.Parameter
(
ParameterId int IDENTITY(1,1) PRIMARY KEY,
Value1 varchar(20) NOT NULL,
Value2 varchar(20) NOT NULL
);
CREATE PROCEDURE Examples.Parameter_Insert 
@Value1 varchar(20) = 'No entry given',
@Value2 varchar(20) = 'No entry given'
AS
SET NOCOUNT ON;
INSERT INTO Examples.Parameter (Value1,Value2)
VALUES (@Value1,@Value2);
GO

EXECUTE Examples.Parameter_Insert;

EXECUTE Examples.Parameter_Insert 'Some Entry';

EXECUTE Examples.Parameter_Insert 'More Entry' , 'More Entry';

EXECUTE Examples.Parameter_Insert @Value1 =   'Other Entry';

SELECT * FROM Examples.Parameter;

ALTER PROCEDURE Examples.Parameter_Insert
@Value1 varchar(20) = 'No entry given',
@Value2 varchar(20) = 'No entry given' OUTPUT,
@NewParameterId int = NULL OUTPUT 
AS
SET NOCOUNT ON;
SET @Value1 = UPPER(@Value1);
SET @Value2 = LOWER(@Value2);

INSERT INTO Examples.Parameter(Value1,Value2)
VALUES (@Value1, @Value2);

SET @NewParameterId = SCOPE_IDENTITY();
GO

DECLARE @MyValue1 varchar (20) = 'Test',
        @MyValue2 varchar (20) = 'Test',
		@MyNewParameterId int  = -200;

EXECUTE Examples.Parameter_Insert @Value1 = @MyValue1,
                                  @Value2 = @MyValue2 OUTPUT,
								  @NewParameterId = @MyNewParameterId OUTPUT;
 
 SELECT @MyValue1 AS Val1, @MyValue2 as Val2, @MyNewParameterId as NewParamId;

 SELECT * 
 FROM Examples.Parameter 
 WHERE ParameterId = @MyNewParameterId;

 CREATE PROCEDURE SimpleReturnValue
 AS
   DECLARE @NoOp int;

   DECLARE @ReturnCode int;
   EXECUTE @ReturnCode = SimpleReturnValue;
   SELECT @ReturnCode AS  DefaultReturnCode;
    
CREATE PROCEDURE DoOperation
(
@Value int
)
AS
       IF @Value = 0
	      RETURN 1;
	  ELSE IF @Value IS NULL 
	      RETURN -1;
	  ELSE RETURN 0;
GO

DECLARE @ReturnCode int;
EXEC @ReturnCode = DoOperation NULL ;
SELECT @ReturnCode;

DECLARE @ReturnCode int;
EXEC @ReturnCode = DoOperation 10;
SELECT @ReturnCode;

DECLARE @ReturnCode int;
EXEC @ReturnCode =  DoOperation 0;
SELECT @ReturnCode;

