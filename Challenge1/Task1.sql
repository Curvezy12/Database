-- 103641460 Seb Conway 

/* TOUR (TourName, Description)
PK (TourName)

EVENT (TourName, EventYear, EventMonth, EventDay, Fee)
PK (EventYear, EventMonth, EventDay)
FK (TourName) References TOUR

BOOKING (EventYear, EventMonth, EventDay, ClientID, DateBooked, Payment)
FK (EventYear, EventMonth, EventYear) References EVENT
FK (ClientID) References CLIENT

CLIENT (ClientID, Surname, GivenName, Gender)
PK (ClientID) */ 

USE Challenge1;
-----------------------------------------------------------------
IF OBJECT_ID('dbo.Booking', 'U') IS NOT NULL
DROP TABLE dbo.Booking
GO

IF OBJECT_ID('dbo.Event', 'U') IS NOT NULL
DROP TABLE dbo.Event
GO

IF OBJECT_ID('dbo.Client', 'U') IS NOT NULL
DROP TABLE dbo.Client
GO

IF OBJECT_ID('dbo.Tour', 'U') IS NOT NULL
DROP TABLE dbo.Tour
GO
-----------------------------------------------------------------
CREATE TABLE Tour ( 
    TourName NVARCHAR(100) PRIMARY KEY,
    Description NVARCHAR(500),
);
GO

CREATE TABLE Client ( 
    ClientId INT PRIMARY KEY,
    Surname NVARCHAR(100) NOT NULL,
    GivenName NVARCHAR(100) NOT NULL,
    Gender NVARCHAR(1) CHECK (Gender IN ('M','F','I')) NULL,
);
GO

CREATE TABLE [Event] (
    TourName NVARCHAR(100), 
    EventMonth NVARCHAR(3) CHECK (EventMonth IN ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')),
    EventDay INT CHECK (EventDay>=1 AND EventDay<=31), 
    EventYear INT CHECK (EventYear=4), 
    EventFee MONEY NOT NULL CHECK (EventFee>0),
    CONSTRAINT PK_Event PRIMARY KEY (TourName, EventMonth, EventDay, EventYear),
    CONSTRAINT FK_Event FOREIGN KEY (TourName) REFERENCES Tour
);
GO

CREATE TABLE Booking ( 
    ClientId INT,
    TourName NVARCHAR(100),
    EventMonth NVARCHAR(3) CHECK (EventMonth IN ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')), 
    EventDay INT CHECK (EventDay>=1 AND EventDay<=31),
    EventYear INT CHECK (EventYear=4),
    Payment MONEY Check (Payment>0) NULL,
    DateBooked DATE NOT NULL,
    CONSTRAINT PK_Booking PRIMARY KEY (ClientId, TourName, EventMonth, EventDay, EventYear),
    CONSTRAINT FK_Booking FOREIGN KEY (TourName, EventMonth, EventDay, EventYear) REFERENCES Event,
    CONSTRAINT FK_Booking_ClientId FOREIGN KEY (ClientId) REFERENCES Client,
);    
GO
