/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      Model1.DM1
 *
 * Date Created : Thursday, September 28, 2023 01:56:37
 * Target DBMS : Microsoft SQL Server 2017
 */

IF OBJECT_ID('Customer') IS NOT NULL
BEGIN
    DROP TABLE Customer
    PRINT '<<< DROPPED TABLE Customer >>>'
END
go
IF OBJECT_ID('CustomerCredentials') IS NOT NULL
BEGIN
    DROP TABLE CustomerCredentials
    PRINT '<<< DROPPED TABLE CustomerCredentials >>>'
END
go
IF OBJECT_ID('SalesOrderDetail') IS NOT NULL
BEGIN
    DROP TABLE SalesOrderDetail
    PRINT '<<< DROPPED TABLE SalesOrderDetail >>>'
END
go
IF OBJECT_ID('SeasonalDiscounts') IS NOT NULL
BEGIN
    DROP TABLE SeasonalDiscounts
    PRINT '<<< DROPPED TABLE SeasonalDiscounts >>>'
END
go
CREATE TYPE AccountNumber FROM nvarchar(15) NULL
go

CREATE TYPE Flag FROM bit NOT NULL
go

CREATE TYPE Name FROM nvarchar(50) NULL
go

CREATE TYPE NameStyle FROM bit NOT NULL
go

CREATE TYPE OrderNumber FROM nvarchar(25) NULL
go

CREATE TYPE Phone FROM nvarchar(25) NULL
go

/* 
 * TABLE: Customer 
 */

CREATE TABLE Customer(
    CustomerID      int                 IDENTITY(1,1) NOT FOR REPLICATION,
    NameStyle       NameStyle           DEFAULT 0 NOT NULL,
    Title           nvarchar(8)         NULL,
    FirstName       Name                NOT NULL,
    MiddleName      Name                NULL,
    LastName        Name                NOT NULL,
    Suffix          nvarchar(10)        NULL,
    CompanyName     nvarchar(128)       NULL,
    SalesPerson     nvarchar(256)       NULL,
    EmailAddress    nvarchar(50)        NULL,
    Phone           Phone               NULL,
    PasswordHash    varchar(128)        NOT NULL,
    PasswordSalt    varchar(10)         NOT NULL,
    rowguid         uniqueidentifier    CONSTRAINT [DF_Customer_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate    datetime            CONSTRAINT [DF_Customer_ModifiedDate] DEFAULT (getdate()) NOT NULL
)

go


IF OBJECT_ID('Customer') IS NOT NULL
    PRINT '<<< CREATED TABLE Customer >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Customer >>>'
go

/* 
 * TABLE: Customer 
 */

ALTER TABLE Customer ADD 
    CONSTRAINT PK_Customer_CustomerID PRIMARY KEY NONCLUSTERED (CustomerID)
go

IF OBJECT_ID('Customer') IS NOT NULL
    PRINT '<<< CREATED TABLE Customer >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Customer >>>'
go

/* 
 * TABLE: CustomerCredentials 
 */

CREATE TABLE CustomerCredentials(
    ID              int         NOT NULL,
    CustomerID      int         NOT NULL,
    CreatedDate     datetime    NULL,
    ModifiedDate    datetime    NULL
)

go


IF OBJECT_ID('CustomerCredentials') IS NOT NULL
    PRINT '<<< CREATED TABLE CustomerCredentials >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CustomerCredentials >>>'
go

/* 
 * TABLE: CustomerCredentials 
 */

ALTER TABLE CustomerCredentials ADD 
    CONSTRAINT PK11 PRIMARY KEY NONCLUSTERED (ID)
go

IF OBJECT_ID('CustomerCredentials') IS NOT NULL
    PRINT '<<< CREATED TABLE CustomerCredentials >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CustomerCredentials >>>'
go

/* 
 * TABLE: SalesOrderDetail 
 */

CREATE TABLE SalesOrderDetail(
    SalesOrderID          int                 NOT NULL,
    SalesOrderDetailID    int                 IDENTITY(1,1),
    OrderQty              smallint            NOT NULL
                          CONSTRAINT CK_SalesOrderDetail_OrderQty CHECK ([OrderQty]>(0)),
    ProductID             int                 NOT NULL,
    UnitPriceDiscount     money               CONSTRAINT [DF_SalesOrderDetail_UnitPriceDiscount] DEFAULT 0.0 NOT NULL
                          CONSTRAINT CK_SalesOrderDetail_UnitPriceDiscount CHECK ([UnitPriceDiscount]>=(0.00)),
    MemberShipType        varchar(50)         NULL,
    LineTotal             numeric(38, 6)      NOT NULL,
    rowguid               uniqueidentifier    CONSTRAINT [DF_SalesOrderDetail_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate          datetime            CONSTRAINT [DF_SalesOrderDetail_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    SeasonalDiscountID    int                 NULL
)

go


IF OBJECT_ID('SalesOrderDetail') IS NOT NULL
    PRINT '<<< CREATED TABLE SalesOrderDetail >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE SalesOrderDetail >>>'
go

/* 
 * TABLE: SalesOrderDetail 
 */

ALTER TABLE SalesOrderDetail ADD 
    CONSTRAINT PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID PRIMARY KEY NONCLUSTERED (SalesOrderID, SalesOrderDetailID)
go

IF OBJECT_ID('SalesOrderDetail') IS NOT NULL
    PRINT '<<< CREATED TABLE SalesOrderDetail >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE SalesOrderDetail >>>'
go

/* 
 * TABLE: SeasonalDiscounts 
 */

CREATE TABLE SeasonalDiscounts(
    ID                 int              NOT NULL,
    SeasonName         varchar(50)      NULL,
    DiscountPercent    numeric(2, 0)    NULL,
    CreatedDate        date             NULL,
    ModifiedDate       date             NULL
)

go


IF OBJECT_ID('SeasonalDiscounts') IS NOT NULL
    PRINT '<<< CREATED TABLE SeasonalDiscounts >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE SeasonalDiscounts >>>'
go

/* 
 * TABLE: SeasonalDiscounts 
 */

ALTER TABLE SeasonalDiscounts ADD 
    CONSTRAINT PK13 PRIMARY KEY NONCLUSTERED (ID)
go

IF OBJECT_ID('SeasonalDiscounts') IS NOT NULL
    PRINT '<<< CREATED TABLE SeasonalDiscounts >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE SeasonalDiscounts >>>'
go

/* 
 * TABLE: CustomerCredentials 
 */

ALTER TABLE CustomerCredentials ADD CONSTRAINT RefCustomer15 
    FOREIGN KEY (CustomerID)
    REFERENCES Customer(CustomerID)
go


/* 
 * TABLE: SalesOrderDetail 
 */

ALTER TABLE SalesOrderDetail ADD CONSTRAINT RefSeasonalDiscounts17 
    FOREIGN KEY (SeasonalDiscountID)
    REFERENCES SeasonalDiscounts(ID)
go

ALTER TABLE SalesOrderDetail ADD CONSTRAINT FK_SalesOrderDetail_Product_ProductID 
    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
go

ALTER TABLE SalesOrderDetail ADD CONSTRAINT FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID 
    FOREIGN KEY (SalesOrderID)
    REFERENCES SalesOrderHeader(SalesOrderID) ON DELETE CASCADE
go


