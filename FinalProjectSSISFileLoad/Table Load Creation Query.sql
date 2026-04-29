USE Restaurant;
GO

DROP TABLE IF EXISTS dbo.SSIS_File_Load;
GO

CREATE TABLE dbo.SSIS_File_Load (
	AverageRate FLOAT,
	CurrencyCode CHAR(3),
	CurrencyDate DATETIME,
	EndOfDayRate VARCHAR(50)
);
GO