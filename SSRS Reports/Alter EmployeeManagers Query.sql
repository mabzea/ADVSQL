USE AdventureWorks2019;
GO

--By defualt, AdventureWorks refuses to load all records if you dont give it a specific
--BusinessEntityID. To meet the requirements, we have alter the sotred procedure so it accepts a blank null

ALTER PROCEDURE [dbo].[uspGetEmployeeManagers]
	@BusinessEntityID [int] = NULL
AS
BEGIN
	SET NOCOUNT ON;

    -- Use recursive query to list out all Employees
    WITH [EMP_cte]([RecursionLevel], [OrganizationNode], [FirstName], [LastName], [BusinessEntityID]) 
    AS (
        SELECT 0, e.[OrganizationNode], p.[FirstName], p.[LastName], e.[BusinessEntityID]
        FROM [HumanResources].[Employee] e 
        INNER JOIN [Person].[Person] p 
        ON p.[BusinessEntityID] = e.[BusinessEntityID]
        WHERE (@BusinessEntityID IS NULL OR e.[BusinessEntityID] = @BusinessEntityID)
        
        UNION ALL
        
        SELECT cte.[RecursionLevel] + 1, e.[OrganizationNode], p.[FirstName], p.[LastName], e.[BusinessEntityID]
        FROM [EMP_cte] cte
        INNER JOIN [HumanResources].[Employee] e 
        ON cte.[OrganizationNode].GetAncestor(1) = e.[OrganizationNode]
        INNER JOIN [Person].[Person] p 
        ON p.[BusinessEntityID] = e.[BusinessEntityID]
    )
    SELECT 
        cte.[RecursionLevel], 
        cte.[BusinessEntityID], 
        cte.[FirstName], 
        cte.[LastName], 
        cte.[OrganizationNode].ToString() AS [OrganizationNode], 
        p.[FirstName] AS [ManagerFirstName], 
        p.[LastName] AS [ManagerLastName]
    FROM [EMP_cte] cte 
    LEFT OUTER JOIN [HumanResources].[Employee] e 
    ON cte.[OrganizationNode].GetAncestor(1) = e.[OrganizationNode]
    LEFT OUTER JOIN [Person].[Person] p 
    ON p.[BusinessEntityID] = e.[BusinessEntityID]
    ORDER BY [RecursionLevel], cte.[OrganizationNode].ToString();
END;
GO