CREATE PROCEDURE dbo.USP_GetInvoiceDetails
	@InvoiceID INT = NULL -- This makes the parameter optional
AS
BEGIN	
	--If no parameter is passed (@InvoiceID is NULL), It returns all rows.
	--If a parameter is passed, it returns just that specific invoice.
	SELECT	
		VendorID,
		InvoiceID,
		InvoiceNumber,
		InvoiceDate,
		InvoiceTotal,
		PaymentTotal,
		CreditTotal,
		TermsID,
		InvoiceDueDate,
		PaymentDate
	FROM Invoices
	WHERE (@InvoiceID IS NULL OR InvoiceID = @InvoiceID);
END;
GO