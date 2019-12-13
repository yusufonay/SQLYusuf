CREATE PROCEDURE Examples.HandlingErrors
AS
  DECLARE @NoOp int = 0;
  THROW 50000, 'An error has occurred!', 1;
GO

EXEC Examples.HandlingErrors;

CREATE PROCEDURE Examples.StopBatchError
AS
DECLARE @NoOp int = 100;
THROW 50000, 'Batch Stopped!' , 1;
SELECT @NoOp, SYSDATETIME();
GO

DROP PROCEDURE Examples.ContinueBatchError;

CREATE PROCEDURE Examples.ContinueBatchError
AS
DECLARE @NoOp int = 100;
RAISERROR  ('Batch Continued!', 16, 1);
SELECT @NoOp, SYSDATETIME();
GO
 
 EXEC Examples.StopBatchError;
 EXEC Examples.ContinueBatchError;

 CREATE TABLE Examples.Worker
 (
 WorkerID int NOT NULL IDENTITY(1,1) CONSTRAINT PKWorker PRIMARY KEY,
 WorkerName nvarchar(50) NOT NULL CONSTRAINT AKWorker UNIQUE 
 );
 CREATE TABLE Examples.WorkerAssignment
 (
  WorkerAssignmentId int IDENTITY(1,1) CONSTRAINT PKWorkerAssignmnet PRIMARY KEY,
  WorkerId int NOT NULL,
  CompanyName nvarchar(50) NOT NULL
  CONSTRAINT CHKWorkerAssignment_CompanyName
    CHECK (CompanyName <> 'Contoso, Ltd.'),
CONSTRAINT AKWorkerAssignment UNIQUE (WorkerId, CompanyName)
);
GO

CREATE PROCEDURE Examples.Worker_AddWithAssignment
   @WorkerName nvarchar(50),
   @CompanyName nvarchar(50)
AS
  SET NOCOUNT ON;
  IF @WorkerName IS NULL or @CompanyName IS NULL
     THROW 50000, 'Both parameters must be not null', 1;

	 DECLARE @Location nvarchar(30), @NewWorkerId int;
	 BEGIN TRY
	    BEGIN TRANSACTION;

SET @Location = 'Creating Worker Row';
INSERT INTO Examples.Worker(WorkerName)
VALUES (@WorkerName);

SELECT @NewWorkerId = SCOPE_IDENTITY(),
       @Location = 'Creating WorkAssignment Row';

INSERT INTO Examples.WorkerAssignment(WorkerId, CompanyName)
VALUES (@NewWorkerId, @CompanyName);

         COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
	  IF XACT_STATE() <> 0 

	        ROLLBACK TRANSACTION;

DECLARE @ErrorMessage nvarchar(4000);
SET @ErrorMessage = CONCAT('Error occured during: ''',@Location,'''',
                           'System Error: ',
						   ERROR_NUMBER(), ':',ERROR_MESSAGE());
THROW 50000, @ErrorMessage, 1;
END CATCH;
GO
