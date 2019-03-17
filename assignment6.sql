create database NewSales2

use NewSales2

CREATE TABLE [Customer]
(
 [CustomerId]   int IDENTITY (1, 1) NOT NULL ,
 [CustomerName] varchar(40) NOT NULL ,
 [Phone]        varchar(20) NULL ,

 CONSTRAINT [PK_Customer] PRIMARY KEY NONCLUSTERED ([CustomerId] ASC),
 CONSTRAINT [AK1_Customer_CustomerName] UNIQUE NONCLUSTERED ([CustomerName] ASC)
);
GO


CREATE TABLE [Supplier]
(
 [SupplierId]  int IDENTITY (1, 1) NOT NULL ,
 [CompanyName] varchar(40) NOT NULL ,
 [Phone]       varchar(20) NULL ,

 CONSTRAINT [PK_Supplier] PRIMARY KEY NONCLUSTERED ([SupplierId] ASC),
 CONSTRAINT [AK1_Supplier_CompanyName] UNIQUE NONCLUSTERED ([CompanyName] ASC)
);
GO

CREATE TABLE [Product]
(
 [ProductId]      int IDENTITY (1, 1) NOT NULL ,
 [ProductName]    varchar(50) NOT NULL ,
 [SupplierId]     int NOT NULL ,
 [UnitPrice]      decimal(12,2) NULL ,
 [IsDiscontinued] bit NOT NULL CONSTRAINT [DF_Product_IsDiscontinued] DEFAULT 0 ,

 CONSTRAINT [PK_Product] PRIMARY KEY NONCLUSTERED ([ProductId] ASC),
 CONSTRAINT [AK1_Product_SupplierId_ProductName] UNIQUE NONCLUSTERED ([ProductName] ASC, [SupplierId] ASC),
 CONSTRAINT [FK_Product_SupplierId_Supplier] FOREIGN KEY ([SupplierId])  REFERENCES [Supplier]([SupplierId])
);
GO

CREATE TABLE [Store]
(
 [StoreId]   int IDENTITY (1, 1) NOT NULL ,
 [StoreName] varchar(255) NOT NULL ,

 CONSTRAINT [PRIMARY] PRIMARY KEY NONCLUSTERED ([StoreId] ASC)
);


CREATE TABLE [Order]
(
 [OrderId]     int PRIMARY KEY IDENTITY  (1, 1) NOT NULL ,
 [OrderNumber] varchar(10) NULL ,
 [CustomerId]  int NOT NULL ,
 [OrderDate]   datetime NOT NULL CONSTRAINT [DF_Order_OrderDate] DEFAULT CURRENT_TIMESTAMP ,
 [TotalAmount] decimal(12,2) NOT NULL ,
 [StoreId]     int NOT NULL ,

 
 CONSTRAINT [AK1_Order_OrderNumber] UNIQUE NONCLUSTERED ([OrderNumber] ASC),
 CONSTRAINT [FK_115] FOREIGN KEY ([StoreId])  REFERENCES [Store]([StoreId]),
 CONSTRAINT [FK_Order_CustomerId_Customer] FOREIGN KEY ([CustomerId])  REFERENCES [Customer]([CustomerId])
);
GO

 
CREATE TABLE [OrderItem]
(
 [OrderId]   int PRIMARY KEY NOT NULL ,
 [ProductId] int NOT NULL ,
 [UnitPrice] decimal(12,2) NOT NULL ,
 [Quantity]  int NOT NULL ,

 CONSTRAINT [FK_OrderItem_OrderId_Order] FOREIGN KEY ([OrderId])  REFERENCES [Order]([OrderId]),
 CONSTRAINT [FK_OrderItem_ProductId_Product] FOREIGN KEY ([ProductId])  REFERENCES [Product]([ProductId])
);
GO

INSERT INTO [Customer]([CustomerName],[Phone])
VALUES ('Bianca','0826467266');

INSERT INTO [Customer]([CustomerName],[Phone])
VALUES ('Pierre','0245789546');

INSERT INTO [Customer]([CustomerName],[Phone])
VALUES ('Miica','0212457896');



INSERT INTO [Supplier]([CompanyName],[Phone])
VALUES ('Red','0826467266');

INSERT INTO [Supplier]([CompanyName],[Phone])
VALUES ('Blue','0826467266');

INSERT INTO [Supplier]([CompanyName],[Phone])
VALUES ('Purple','0826467266');


INSERT INTO [Product]([ProductName],[SupplierId],[UnitPrice],[IsDiscontinued])
VALUES ('iphone',1,15000,1);

INSERT INTO [Product]([ProductName],[SupplierId],[UnitPrice],[IsDiscontinued])
VALUES ('samsung',2,17000,1);

INSERT INTO [Product]([ProductName],[SupplierId],[UnitPrice],[IsDiscontinued])
VALUES ('nokia',1,1500,1);

INSERT INTO [Store]([StoreName])
Values ('Centurion');

INSERT INTO [Store]([StoreName])
Values ('Online');


INSERT INTO [Order]([OrderNumber],[CustomerId],[OrderDate],[TotalAmount],[StoreId])
Values ('123',1,'2019-03-19',123,1);

INSERT INTO [Order]([OrderNumber],[CustomerId],[OrderDate],[TotalAmount],[StoreId])
Values ('1273',2,'2019-03-19',1263,1);

INSERT INTO [Order]([OrderNumber],[CustomerId],[OrderDate],[TotalAmount],[StoreId])
Values ('12003',1,'2019-03-19',12883,2);

INSERT INTO [Order]([OrderNumber],[CustomerId],[OrderDate],[TotalAmount],[StoreId])
Values ('12663',1,'2019-03-19',12773,2);


INSERT INTO [OrderItem]([OrderId],[ProductId],[UnitPrice],[Quantity])
Values (1,1,12773,2);

INSERT INTO [OrderItem]([OrderId],[ProductId],[UnitPrice],[Quantity])
Values (2,2,127373,2);

INSERT INTO [OrderItem]([OrderId],[ProductId],[UnitPrice],[Quantity])
Values (3,3,1277333,2);

