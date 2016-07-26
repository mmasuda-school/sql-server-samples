﻿IF OBJECT_ID('[Website].[SearchForStockItemsByTags]') IS NOT NULL
	DROP PROCEDURE [Website].[SearchForStockItemsByTags];

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [Website].[SearchForStockItemsByTags]
@SearchText nvarchar(1000),
@MaximumRowsToReturn int
WITH EXECUTE AS OWNER
AS
BEGIN
    SELECT si.StockItemID,
           si.StockItemName
    FROM Warehouse.StockItems AS si
    INNER JOIN FREETEXTTABLE(Warehouse.StockItems, Tags, @SearchText, @MaximumRowsToReturn) AS ft
    ON si.StockItemID = ft.[KEY]
    ORDER BY ft.[RANK]
    FOR JSON AUTO, ROOT(N'StockItems');
END;
GO
