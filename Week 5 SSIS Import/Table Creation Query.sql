USE AdventureWorks2019;
GO

CREATE TABLE Week5_SSIS_Import(
	CurrencyDate DATE,
	CurrencyCode CHAR(3),
	AverageRate DECIMAL(18, 4),
	EndOfDayRate DECIMAL(18, 4)
);
GO