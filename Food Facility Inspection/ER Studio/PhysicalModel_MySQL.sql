--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      DimensionalModel_Logical_and_Physical.DM1
--
-- Date Created : Thursday, October 19, 2023 01:22:59
-- Target DBMS : MySQL 8.x
--

-- 
-- TABLE: DIM_Address 
--

CREATE TABLE DIM_Address(
    AddressID                DECIMAL(10, 2)     NOT NULL,
    RestaurentID             DECIMAL(10, 2),
    Address                  VARCHAR(32),
    City                     VARCHAR(17),
    State                    VARCHAR(2),
    Zipcode                  DECIMAL(4, 0),
    Logitute                 DECIMAL(18, 12),
    Latitude                 DECIMAL(18, 12),
    DI_CreatedDate           DATE,
    DI_WorkflowFileName      VARCHAR(256),
    DI_Workflow_ProcessID    VARCHAR(256),
    PRIMARY KEY (AddressID)
)ENGINE=MYISAM
;



-- 
-- TABLE: DIM_Date 
--

CREATE TABLE DIM_Date(
    DateSK                   DATE             NOT NULL,
    Date                     DATETIME,
    Day                      DECIMAL(2, 0),
    Month                    DECIMAL(2, 0),
    Year                     DECIMAL(4, 0),
    Week                     DECIMAL(3, 0),
    DI_CreatedDate           DATE,
    DI_WorkflowFileName      VARCHAR(256),
    DI_Workflow_ProcessID    VARCHAR(256),
    PRIMARY KEY (DateSK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DIM_RestaurantDetails 
--

CREATE TABLE DIM_RestaurantDetails(
    RestaurentID             DECIMAL(10, 2)    NOT NULL,
    Name                     VARCHAR(70),
    Phoneno                  TEXT              NOT NULL,
    DI_CreatedDate           DATE,
    DI_WorkflowFileName      VARCHAR(256),
    DI_Workflow_ProcessID    VARCHAR(256),
    PRIMARY KEY (RestaurentID)
)ENGINE=MYISAM
;



-- 
-- TABLE: DIM_ViolationInspectionType 
--

CREATE TABLE DIM_ViolationInspectionType(
    InspectionTypeID         DECIMAL(10, 2)    NOT NULL,
    InspectionType           VARCHAR(10),
    DI_CreatedDate           DATE,
    DI_WorkflowFileName      VARCHAR(256),
    DI_Workflow_ProcessID    VARCHAR(256),
    PRIMARY KEY (InspectionTypeID)
)ENGINE=MYISAM
;



-- 
-- TABLE: DIM_Violations 
--

CREATE TABLE DIM_Violations(
    ViolationCodeID          DECIMAL(10, 2)    NOT NULL,
    InspectionID             VARCHAR(10),
    ViolationCategory        VARCHAR(100),
    ViolationCode            VARCHAR(109),
    Description              VARCHAR(254),
    DI_CreatedDate           DATE,
    DI_WorkflowFileName      VARCHAR(256),
    DI_Workflow_ProcessID    VARCHAR(256),
    PRIMARY KEY (ViolationCodeID)
)ENGINE=MYISAM
;



-- 
-- TABLE: FCT_FoodInspection 
--

CREATE TABLE FCT_FoodInspection(
    FoodInspectionSK         DECIMAL(10, 2)    NOT NULL,
    ViolationCodeID          DECIMAL(10, 2)    NOT NULL,
    RestaurentID             DECIMAL(10, 2)    NOT NULL,
    DateSK                   DATE              NOT NULL,
    InspectionTypeID         DECIMAL(10, 2)    NOT NULL,
    ViolationPoint           DECIMAL(10, 2),
    ViolationScore           DECIMAL(10, 2),
    InspectionResult         VARCHAR(10),
    InspectionID             VARCHAR(10)       NOT NULL,
    BusinessID               VARCHAR(10),
    DI_CreatedDate           DATE,
    DI_WorkflowFileName      VARCHAR(256),
    DI_Workflow_ProcessID    VARCHAR(256),
    PRIMARY KEY (FoodInspectionSK, ViolationCodeID, RestaurentID, DateSK, InspectionTypeID)
)ENGINE=MYISAM
;



-- 
-- TABLE: DIM_Address 
--

ALTER TABLE DIM_Address ADD CONSTRAINT RefDIM_RestaurantDetails6 
    FOREIGN KEY (RestaurentID)
    REFERENCES DIM_RestaurantDetails(RestaurentID)
;


-- 
-- TABLE: FCT_FoodInspection 
--

ALTER TABLE FCT_FoodInspection ADD CONSTRAINT RefDIM_Violations2 
    FOREIGN KEY (ViolationCodeID)
    REFERENCES DIM_Violations(ViolationCodeID)
;

ALTER TABLE FCT_FoodInspection ADD CONSTRAINT RefDIM_RestaurantDetails3 
    FOREIGN KEY (RestaurentID)
    REFERENCES DIM_RestaurantDetails(RestaurentID)
;

ALTER TABLE FCT_FoodInspection ADD CONSTRAINT RefDIM_Date4 
    FOREIGN KEY (DateSK)
    REFERENCES DIM_Date(DateSK)
;

ALTER TABLE FCT_FoodInspection ADD CONSTRAINT RefDIM_ViolationInspectionType5 
    FOREIGN KEY (InspectionTypeID)
    REFERENCES DIM_ViolationInspectionType(InspectionTypeID)
;


