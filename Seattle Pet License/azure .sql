/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      DATA MODEL
 *
 * Date Created : Monday, October 23, 2023 23:32:32
 * Target DBMS : Microsoft SQL Server 2017
 */

/* 
 * TABLE: Di_Date 
 */

CREATE TABLE Di_Date(
    date_sk              numeric(10, 0)    NOT NULL,
    Day_Num              numeric(10, 0)    NULL,
    Date_Ste             varchar(255)      NULL,
    Mon_Num              numeric(10, 0)    NULL,
    Year_Num             numeric(10, 0)    NULL,
    is_weekend           char(10)          NULL,
    Date_To_Warehouse    date              NULL,
    di_jobId             varchar(255)      NULL,
    dt                   date              NULL,
    CONSTRAINT PK2 PRIMARY KEY NONCLUSTERED (date_sk)
)

go


IF OBJECT_ID('Di_Date') IS NOT NULL
    PRINT '<<< CREATED TABLE Di_Date >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Di_Date >>>'
go

/* 
 * TABLE: Dim_Breed 
 */

CREATE TABLE Dim_Breed(
    BreedID            numeric(10, 0)    NOT NULL,
    Species            varchar(255)      NULL,
    Primary_Breed      varchar(255)      NULL,
    Secondary_Breed    varchar(255)      NULL,
    DI_CreateDate      date              NULL,
    DI_process_ID      varchar(10)       NULL,
    CONSTRAINT PK4 PRIMARY KEY NONCLUSTERED (BreedID)
)

go


IF OBJECT_ID('Dim_Breed') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Breed >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Breed >>>'
go

/* 
 * TABLE: Dim_Location 
 */

CREATE TABLE Dim_Location(
    Location_sk      numeric(10, 0)    NOT NULL,
    Zipcode          numeric(10, 0)    NULL,
    City             varchar(255)      NULL,
    State_abbr       varchar(255)      NULL,
    DI_CreateDate    date              NULL,
    DI_Process_ID    varchar(10)       NULL,
    CONSTRAINT PK1 PRIMARY KEY NONCLUSTERED (Location_sk)
)

go


IF OBJECT_ID('Dim_Location') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Location >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Location >>>'
go

/* 
 * TABLE: Fact_SeattlePet 
 */

CREATE TABLE Fact_SeattlePet(
    FactSk         numeric(10, 0)    NOT NULL,
    NumOfPet       numeric(10, 0)    NULL,
    date_sk        numeric(10, 0)    NOT NULL,
    Location_sk    numeric(10, 0)    NOT NULL,
    Breed_sk       numeric(10, 0)    NULL,
    BreedID        numeric(10, 0)    NOT NULL,
    CONSTRAINT PK3 PRIMARY KEY NONCLUSTERED (FactSk)
)

go


IF OBJECT_ID('Fact_SeattlePet') IS NOT NULL
    PRINT '<<< CREATED TABLE Fact_SeattlePet >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Fact_SeattlePet >>>'
go

/* 
 * TABLE: Fact_SeattlePet 
 */

ALTER TABLE Fact_SeattlePet ADD CONSTRAINT RefDim_Location2 
    FOREIGN KEY (Location_sk)
    REFERENCES Dim_Location(Location_sk)
go

ALTER TABLE Fact_SeattlePet ADD CONSTRAINT RefDim_Breed3 
    FOREIGN KEY (BreedID)
    REFERENCES Dim_Breed(BreedID)
go

ALTER TABLE Fact_SeattlePet ADD CONSTRAINT RefDi_Date4 
    FOREIGN KEY (date_sk)
    REFERENCES Di_Date(date_sk)
go


