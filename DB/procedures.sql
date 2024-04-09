select * from Northwind.dbo.Orders
Go

Select OrderId, ProductName, OD.UnitPrice, Quantity, Discount,
		subtotal=OD.UnitPrice*Quantity*(1-Discount)
from [Order Details] OD inner join Products P
on OD.ProductID=P.ProductID
go


IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'CalcularSubtotal')
BEGIN
    DROP PROCEDURE CalcularSubtotal;
END
GO
CREATE PROCEDURE CalcularSubtotal
AS
BEGIN
    SELECT 
        OD.OrderId, 
        P.ProductName, 
        OD.UnitPrice, 
        OD.Quantity, 
        OD.Discount,
        OD.UnitPrice * OD.Quantity * (1 - OD.Discount) AS Subtotal
    FROM 
        [Order Details] OD
    INNER JOIN 
        Products P ON OD.ProductID = P.ProductID;
END
GO

IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'BuscarProductosPorId')
BEGIN
    DROP PROCEDURE BuscarProductosPorId;
END
GO

CREATE PROCEDURE BuscarProductosPorId
    @IdProducto INT
AS
BEGIN
    SELECT 
        OD.OrderId, 
        P.ProductName, 
        OD.UnitPrice, 
        OD.Quantity, 
        OD.Discount,
        OD.UnitPrice * OD.Quantity * (1 - OD.Discount) AS Subtotal
    FROM 
        [Order Details] OD
    INNER JOIN 
        Products P ON OD.ProductID = P.ProductID
    WHERE 
        OD.OrderId = @IdProducto;
END
GO

IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'BuscarProductosPorTexto')
BEGIN
    DROP PROCEDURE BuscarProductosPorTexto;
END
GO

CREATE PROCEDURE BuscarProductosPorTexto
    @TerminoBusqueda NVARCHAR(100)
AS
BEGIN
    SELECT 
        OD.OrderId, 
        P.ProductName, 
        OD.UnitPrice, 
        OD.Quantity, 
        OD.Discount,
        OD.UnitPrice * OD.Quantity * (1 - OD.Discount) AS Subtotal
    FROM 
        [Order Details] OD
    INNER JOIN 
        Products P ON OD.ProductID = P.ProductID
    WHERE 
        P.ProductName LIKE @TerminoBusqueda;
END
GO

