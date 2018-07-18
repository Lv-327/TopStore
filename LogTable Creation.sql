IF OBJECT_ID('LogProcessesTable') is not null
DROP TABLE LogProcessesTable
GO

CREATE TABLE LogProcessesTable
	(
	LogID bigint IDENTITY(1,1) NOT NULL PRIMARY KEY,
	StateDescription nvarchar(50) NOT NULL,
	UserName sysname NOT NULL,
	StartTime smalldatetime NOT NULL,
	EndTime smalldatetime NULL,
	ProcessName nvarchar(50) NOT NULL,
	TableName nvarchar(20) NOT NULL,
	InsertRows int NOT NULL,
	UpdateRows int NOT NULL,
	DeleteRows int NOT NULL,
	Report nvarchar (150) NULL,
	LogKey datetime2(7) NOT NULL
	)
GO
