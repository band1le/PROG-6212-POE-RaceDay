/*Creation of database*/
Create Database RaceDay;


USE RaceDay;


/*Creation of Roles table*/
CREATE TABLE Roles(
RolesID INT IDENTITY(1,1)PRIMARY KEY,
RoleName VARCHAR(50) NOT NULL CHECK (RoleName IN ('Organiser', 'Participant'))
);


/*Creation of Users table*/
/*Users <-> Roles is ONE-TO-ONE: every User has exactly one Roles record of their own.RolesID is NOT NULL (every user has a role) and UNIQUE (a Roles record belongs to one user only).RoleName is therefore NOT unique - many users can be 'Organiser' - but each has their own row.*/
CREATE TABLE Users (
UserID          INT IDENTITY(1,1) PRIMARY KEY,
RolesID          INT NOT NULL UNIQUE,
FullName        VARCHAR(100) NOT NULL,
Email           VARCHAR(100) NOT NULL UNIQUE,
PasswordHash    VARCHAR(255) NOT NULL,
PhoneNumber     VARCHAR(20)  NULL,
CreatedAt       DATETIME NOT NULL DEFAULT GETDATE(),
 
CONSTRAINT FK_Users_Roles FOREIGN KEY (RolesID) REFERENCES Roles(RolesID)
);


/*Creation of evnts table*/
/*PART 2 CHANGE: added Distance and EventType. The Part 2 functional requirements say everyevent must capture "a name, description, date, location, distance, and event type(run, walk, or cycle)". Both columns are mirrored in the EF Core model and the ERD.*/
CREATE TABLE Events (
EventsID        INT IDENTITY(1,1) PRIMARY KEY,
 OrganiserID     INT NOT NULL,
 EventName       VARCHAR(150) NOT NULL,
 Description     VARCHAR(1000) NULL,
 EventDate       DATE NOT NULL,
 Location        VARCHAR(150) NOT NULL,
 Distance        DECIMAL(6,2) NULL CHECK (Distance > 0),
 EventType       VARCHAR(10) NOT NULL CHECK (EventType IN ('Run', 'Walk', 'Cycle')),
 CreatedAt       DATETIME NOT NULL DEFAULT GETDATE(),
 
CONSTRAINT FK_Events_Users FOREIGN KEY (OrganiserID)REFERENCES Users(UserID)
);


/*Creation of Categories Table*/
/*PART 2 CHANGE: DistanceKm is now NULLable so an age-based category (e.g. 'Senior','Under 20') can exist without a distance. The CHECK still applies whenever a value is given.*/
CREATE TABLE Categories (
CategoryID      INT IDENTITY(1,1) PRIMARY KEY,
EventsID         INT NOT NULL,
CategoryName    VARCHAR(100) NOT NULL,
DistanceKm      DECIMAL(5,2) NOT NULL CHECK (DistanceKm > 0),
EntryFee        DECIMAL(8,2) NOT NULL DEFAULT 0 CHECK (EntryFee >= 0),
MaxParticipants INT NULL,
 
CONSTRAINT FK_Categories_Events FOREIGN KEY (EventsID)REFERENCES Events(EventsID)
);


/*Creation of Enrolments Table*/
CREATE TABLE Enrolments (
EnrolmentID     INT IDENTITY(1,1) PRIMARY KEY,
ParticipantID   INT NOT NULL,
CategoryID      INT NOT NULL,
EnrolmentDate   DATETIME NOT NULL DEFAULT GETDATE(),
Status          VARCHAR(20) NOT NULL DEFAULT 'Confirmed'CHECK (Status IN ('Confirmed', 'Cancelled', 'Pending')),
 
CONSTRAINT FK_Enrolments_Users FOREIGN KEY (ParticipantID) REFERENCES Users(UserID),
CONSTRAINT FK_Enrolments_Categories FOREIGN KEY (CategoryID)REFERENCES Categories(CategoryID),
CONSTRAINT UQ_Enrolments_Participant_Category UNIQUE (ParticipantID, CategoryID)
);


/*Creation of Results table*/
CREATE TABLE Results (
ResultID                INT IDENTITY(1,1) PRIMARY KEY,
EnrolmentID             INT NOT NULL UNIQUE,
FinishTimeSeconds       INT NULL CHECK (FinishTimeSeconds > 0),
Position                INT NULL CHECK (Position > 0),
CapturedByOrganiserID   INT NOT NULL,
CapturedAt              DATETIME NOT NULL DEFAULT GETDATE(),
 
CONSTRAINT FK_Results_Enrolments FOREIGN KEY (EnrolmentID)REFERENCES Enrolments(EnrolmentID),
CONSTRAINT FK_Results_Users FOREIGN KEY (CapturedByOrganiserID)REFERENCES Users(UserID)
);


/*INSERT ROLES*/
INSERT INTO Roles (RoleName) VALUES ('Organiser'), ('Participant');


/*INSERT USERS: 2 Organisers, 2Participant*/
/*PLEASE NOTE PASSWORDHAS VALUES BELOW ARE PLACEHOLDER FOR SAMPLE DATA ONLY*/
/*Part 2 must hash real password for example(BCrypt)before insertion via the API*/
INSERT INTO Users (RolesID, FullName, Email, PasswordHash, PhoneNumber) VALUES
((SELECT RolesID FROM Roles WHERE RoleName = 'Organiser'),   'Lindiwe Mokoena', 'lindiwe.mokoena@raceday.co.za', 'HASH_PLACEHOLDER_1', '0821234567'),
((SELECT RolesID FROM Roles WHERE RoleName = 'Organiser'),   'Johan van der Merwe', 'johan.vdm@raceday.co.za', 'HASH_PLACEHOLDER_2', '0827654321'),
((SELECT RolesID FROM Roles WHERE RoleName = 'Participant'), 'Thabo Nkosi', 'thabo.nkosi@example.com', 'HASH_PLACEHOLDER_3', '0731112222'),
((SELECT RolesID FROM Roles WHERE RoleName = 'Participant'), 'Aisha Patel', 'aisha.patel@example.com', 'HASH_PLACEHOLDER_4', '0739998888');
GO

/*INSERT INTO EVENTS*/
INSERT INTO Events (OrganiserID, EventName, Description, EventDate, Location) VALUES
((SELECT UserID FROM Users WHERE Email = 'lindiwe.mokoena@raceday.co.za'), 'Soweto Community Marathon', 'Annual road running event through Soweto.', '2026-10-17', 'Soweto, Johannesburg'),
((SELECT UserID FROM Users WHERE Email = 'lindiwe.mokoena@raceday.co.za'), 'Joburg Park Run Challenge', 'Monthly timed park run series.', '2026-09-05', 'Zoo Lake, Johannesburg'),
((SELECT UserID FROM Users WHERE Email = 'johan.vdm@raceday.co.za'),      'Cape Winelands Cycle Tour', 'Scenic road cycling event through the Winelands.', '2026-11-14', 'Stellenbosch, Western Cape');


/*INSERT INTO CATEGORIES*/
INSERT INTO Categories (EventsID, CategoryName, DistanceKm, EntryFee, MaxParticipants) VALUES
((SELECT EventsID FROM Events WHERE EventName = 'Soweto Community Marathon'), '5km Fun Run', 5.00, 100.00, 500),
((SELECT EventsID FROM Events WHERE EventName = 'Soweto Community Marathon'), '21km Half Marathon', 21.10, 250.00, 300),
((SELECT EventsID FROM Events WHERE EventName = 'Joburg Park Run Challenge'), '5km Timed Run', 5.00, 0.00, 200),
((SELECT EventsID FROM Events WHERE EventName = 'Cape Winelands Cycle Tour'), '60km Road Cycle', 60.00, 350.00, 150),
((SELECT EventsID FROM Events WHERE EventName = 'Cape Winelands Cycle Tour'), '100km Road Cycle', 100.00, 450.00, 150);
GO

/*INSERT INTO Enrolments*/
INSERT INTO Enrolments (ParticipantID, CategoryID, Status) VALUES
((SELECT UserID FROM Users WHERE Email = 'thabo.nkosi@example.com'),(SELECT CategoryID FROM Categories WHERE CategoryName = '21km Half Marathon'), 'Confirmed'),
((SELECT UserID FROM Users WHERE Email = 'aisha.patel@example.com'),(SELECT CategoryID FROM Categories WHERE CategoryName = '5km Fun Run'), 'Confirmed'),
((SELECT UserID FROM Users WHERE Email = 'aisha.patel@example.com'),(SELECT CategoryID FROM Categories WHERE CategoryName = '60km Road Cycle'), 'Pending');


/*insert into results*/
INSERT INTO Results (EnrolmentID, FinishTimeSeconds, Position, CapturedByOrganiserID) VALUES
((SELECT EnrolmentID FROM Enrolments e
    JOIN Users u ON e.ParticipantID = u.UserID
    JOIN Categories c ON e.CategoryID = c.CategoryID
    WHERE u.Email = 'thabo.nkosi@example.com' AND c.CategoryName = '21km Half Marathon'),
 5820, 12, (SELECT UserID FROM Users WHERE Email = 'lindiwe.mokoena@raceday.co.za')),
((SELECT EnrolmentID FROM Enrolments e
    JOIN Users u ON e.ParticipantID = u.UserID
    JOIN Categories c ON e.CategoryID = c.CategoryID
    WHERE u.Email = 'aisha.patel@example.com' AND c.CategoryName = '5km Fun Run'),1530, 4, (SELECT UserID FROM Users WHERE Email = 'lindiwe.mokoena@raceday.co.za'));


/*Verification queries*/
SELECT * FROM Roles;
SELECT * FROM Users;
SELECT * FROM Events;
SELECT * FROM Categories;
SELECT * FROM Enrolments;
SELECT * FROM Results;