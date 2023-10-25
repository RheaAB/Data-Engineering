/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      DimensionalModel_Logical_and_Physical.DM1
 *
 * Date Created : Thursday, October 19, 2023 01:21:45
 * Target DBMS : Microsoft SQL Server 2019
 */

/* 
 * TABLE: DIM_Address 
 */

CREATE TABLE DIM_Address(
    AddressID                numeric(10, 2)     NOT NULL,
    RestaurentID             numeric(10, 2)     NULL,
    Address                  varchar(32)        NULL,
    City                     varchar(17)        NULL,
    State                    varchar(2)         NULL,
    Zipcode                  numeric(4, 0)      NULL,
    Logitute                 numeric(18, 12)    NULL,
    Latitude                 numeric(18, 12)    NULL,
    DI_CreatedDate           date               NULL,
    DI_WorkflowFileName      varchar(256)       NULL,
    DI_Workflow_ProcessID    varchar(256)       NULL,
    CONSTRAINT PK14 PRIMARY KEY NONCLUSTERED (AddressID)
)

go


IF OBJECT_ID('DIM_Address') IS NOT NULL
    PRINT '<<< CREATED TABLE DIM_Address >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DIM_Address >>>'
go

/* 
 * TABLE: DIM_Date 
 */

CREATE TABLE DIM_Date(
    DateSK                   date             NOT NULL,
    Date                     datetime         NULL,
    Day                      numeric(2, 0)    NULL,
    Month                    numeric(2, 0)    NULL,
    Year                     numeric(4, 0)    NULL,
    Week                     numeric(3, 0)    NULL,
    DI_CreatedDate           date             NULL,
    DI_WorkflowFileName      varchar(256)     NULL,
    DI_Workflow_ProcessID    varchar(256)     NULL,
    CONSTRAINT PK7 PRIMARY KEY NONCLUSTERED (DateSK)
)

go


IF OBJECT_ID('DIM_Date') IS NOT NULL
    PRINT '<<< CREATED TABLE DIM_Date >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DIM_Date >>>'
go

/* 
 * TABLE: DIM_RestaurantDetails 
 */

CREATE TABLE DIM_RestaurantDetails(
    RestaurentID             numeric(10, 2)    NOT NULL,
    Name                     varchar(70)       NULL,
    Phoneno                  text              NOT NULL,
    DI_CreatedDate           date              NULL,
    DI_WorkflowFileName      varchar(256)      NULL,
    DI_Workflow_ProcessID    varchar(256)      NULL,
    CONSTRAINT PK9 PRIMARY KEY NONCLUSTERED (RestaurentID)
)

go


IF OBJECT_ID('DIM_RestaurantDetails') IS NOT NULL
    PRINT '<<< CREATED TABLE DIM_RestaurantDetails >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DIM_RestaurantDetails >>>'
go

/* 
 * TABLE: DIM_ViolationInspectionType 
 */

CREATE TABLE DIM_ViolationInspectionType(
    InspectionTypeID         numeric(10, 2)    NOT NULL,
    InspectionType           varchar(10)       NULL,
    DI_CreatedDate           date              NULL,
    DI_WorkflowFileName      varchar(256)      NULL,
    DI_Workflow_ProcessID    varchar(256)      NULL,
    CONSTRAINT PK11 PRIMARY KEY NONCLUSTERED (InspectionTypeID)
)

go


IF OBJECT_ID('DIM_ViolationInspectionType') IS NOT NULL
    PRINT '<<< CREATED TABLE DIM_ViolationInspectionType >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DIM_ViolationInspectionType >>>'
go

/* 
 * TABLE: DIM_Violations 
 */

CREATE TABLE DIM_Violations(
    ViolationCodeID          numeric(10, 2)    NOT NULL,
    InspectionID             varchar(10)       NULL,
    ViolationCategory        varchar(100)      NULL,
    ViolationCode            varchar(109)      NULL,
    Description              varchar(254)      NULL,
    DI_CreatedDate           date              NULL,
    DI_WorkflowFileName      varchar(256)      NULL,
    DI_Workflow_ProcessID    varchar(256)      NULL,
    CONSTRAINT PK13 PRIMARY KEY NONCLUSTERED (ViolationCodeID)
)

go


IF OBJECT_ID('DIM_Violations') IS NOT NULL
    PRINT '<<< CREATED TABLE DIM_Violations >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DIM_Violations >>>'
go

/* 
 * TABLE: FCT_FoodInspection 
 */

CREATE TABLE FCT_FoodInspection(
    FoodInspectionSK         numeric(10, 2)    NOT NULL,
    ViolationCodeID          numeric(10, 2)    NOT NULL,
    RestaurentID             numeric(10, 2)    NOT NULL,
    DateSK                   date              NOT NULL,
    InspectionTypeID         numeric(10, 2)    NOT NULL,
    ViolationPoint           numeric(10, 2)    NULL,
    ViolationScore           numeric(10, 2)    NULL,
    InspectionResult         varchar(10)       NULL,
    InspectionID             varchar(10)       NOT NULL,
    BusinessID               varchar(10)       NULL,
    DI_CreatedDate           date              NULL,
    DI_WorkflowFileName      varchar(256)      NULL,
    DI_Workflow_ProcessID    varchar(256)      NULL,
    CONSTRAINT PK10 PRIMARY KEY NONCLUSTERED (FoodInspectionSK, ViolationCodeID, RestaurentID, DateSK, InspectionTypeID)
)

go


IF OBJECT_ID('FCT_FoodInspection') IS NOT NULL
    PRINT '<<< CREATED TABLE FCT_FoodInspection >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE FCT_FoodInspection >>>'
go

/* 
 * TABLE: DIM_Address 
 */

ALTER TABLE DIM_Address ADD CONSTRAINT RefDIM_RestaurantDetails6 
    FOREIGN KEY (RestaurentID)
    REFERENCES DIM_RestaurantDetails(RestaurentID)
go


/* 
 * TABLE: FCT_FoodInspection 
 */

ALTER TABLE FCT_FoodInspection ADD CONSTRAINT RefDIM_Violations2 
    FOREIGN KEY (ViolationCodeID)
    REFERENCES DIM_Violations(ViolationCodeID)
go

ALTER TABLE FCT_FoodInspection ADD CONSTRAINT RefDIM_RestaurantDetails3 
    FOREIGN KEY (RestaurentID)
    REFERENCES DIM_RestaurantDetails(RestaurentID)
go

ALTER TABLE FCT_FoodInspection ADD CONSTRAINT RefDIM_Date4 
    FOREIGN KEY (DateSK)
    REFERENCES DIM_Date(DateSK)
go

ALTER TABLE FCT_FoodInspection ADD CONSTRAINT RefDIM_ViolationInspectionType5 
    FOREIGN KEY (InspectionTypeID)
    REFERENCES DIM_ViolationInspectionType(InspectionTypeID)
go


