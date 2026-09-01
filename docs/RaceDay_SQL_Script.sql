/*Creation of database*/
Create Database RaceDay;

USE RaceDay;

/*Creation of Roles table*/
CREATE TABLE Roles(
  RoleID INT IDENTITY(1,1) PRIMARY KEY,
  RoleName VARCHAR(50) NOT NULL UNIQUE
  );

/*Creation of Users table*/
CREATE TABLE Users(
  UserID INT IDENTITY(1,1) PRIMARY KEY,
  RoleID INT NOT NULL,
  FullName VARCHAR(100) NOT NULL,
  Email VARCHAR(100) NOT NULL UNIQUE,
  PasswordHash VARCHAR(255) NOT NULL,
  PhoneNumber VARCHAR(20)NULL,
  CreatedAt DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_Users_Roles FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
  );

  /*Creation of Events table*/
  CREATE TABLE Events(
     EventID INT IDENTITY(1,1) PRIMARY KEY,
     OrganizerID INT NOT NULL,
     EventName VARCHAR(150) NOT NULL,
     Description VARCHAR(1000)NULL,
     EventDate DATE NOT NULL,
     Location VARCHAR(255)NOT NULL,
     CONSRAINT FK_Events_Users FOREIGN KEY (OrganizerID) REFERENCES Users(UserID)
     );

 /*Creation of Categories table*/
 CREATE TABLE Categories(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    CategoryName VARCHAR(100) NOT NULL,
    DistanceKm DECIMAL(5,2) NOT NULL CHECK (DistanceKm > 0),
    EntryFee DECIMAL(10,2) NOT NULL CHECK (EntryFee >= 0),
    MaxParcitipants INT NULL,
    CONSTRAINT FK_Categories_Events FOREIGN KEY (EventID) REFERENCES Events(EventID)
    );

  /*Creation of Enrolments table*/
   CREATE TABLE Enrolments(
       EnrolmentID INT IDENTITY(1,1) PRIMARY KEY,
       ParticipantID INT NOT NULL,
       CategoryID INT NOT NULL,
       EnrolmentDate DATETIME DEFAULT GETDATE(),
       Status VARCHAR(50)NOT NULL CHECK (Status IN ('Pending', 'Confirmed', 'Cancelled')),
       CONSTRAINT FK_Enrolments_Users FOREIGN KEY (ParticipantID) REFERENCES Users(UserID),
       CONSTRAINT FK_Enrolments_Categories FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
       CONSTRAINT UQ_Enrolments UNIQUE (ParticipantID, CategoryID)
       );

/*Creation of RESULTS TABLE*/
CREATE TABLE Results(
    ResultID INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentID INT NOT NULL,
    FinishTimeSeconds INT NOT NULL CHECK (FinishTimeSeconds > 0),
    Position INT NOT NULL CHECK (Position > 0),
    CapturedByOrganiser INT NOT NULL,
    CONSTRAINT FK_Results_Enrolments FOREIGN KEY (EnrolmentID) REFERENCES Enrolments(EnrolmentID),
    CONSTRAINT FK_Results_Users FOREIGN KEY (CapturedByOrganiser) REFERENCES Users(UserID)
    );

/*INSERT DATA*/
INSERT INTO Roles (RoleName) VALUES('Organizer'),('Participant');

/*User:2 Organiser,2 Participant*/
/*NOTE: PasswordHash values below are placeholders for sample data only.*/
/*Part 2 must hash real passwords (e.g,BCrypt) before insertion via the API*/

INSERT INTO Users(RoleID,FullName,Email,PasswordHash,PhoneNumber)VALUES
((SELECT RoleID FROM Roles WHERE RoleName = 'Organiser'),   'Lindiwe Mokoena', 'lindiwe.mokoena@raceday.co.za', 'HASH_PLACEHOLDER_1', '0821234567'),
((SELECT RoleID FROM Roles WHERE RoleName = 'Organiser'),   'Johan van der Merwe', 'johan.vdm@raceday.co.za', 'HASH_PLACEHOLDER_2', '0827654321'),
((SELECT RoleID FROM Roles WHERE RoleName = 'Participant'), 'Thabo Nkosi', 'thabo.nkosi@example.com', 'HASH_PLACEHOLDER_3', '0731112222'),
((SELECT RoleID FROM Roles WHERE RoleName = 'Participant'), 'Aisha Patel', 'aisha.patel@example.com', 'HASH_PLACEHOLDER_4', '0739998888');

/*Events: 3 events,each created by Organiser*/
INSERT INTO Events(OrganiserID,EventName,Description,EventDate,Location)VALUES
((SELECT UserID FROM Users WHERE Email = 'lindiwe.mokoena@raceday.co.za'), 'Soweto Community Marathon', 'Annual road running event through Soweto.', '2026-10-17', 'Soweto, Johannesburg'),
((SELECT UserID FROM Users WHERE Email = 'lindiwe.mokoena@raceday.co.za'), 'Joburg Park Run Challenge', 'Monthly timed park run series.', '2026-09-05', 'Zoo Lake, Johannesburg'),
((SELECT UserID FROM Users WHERE Email = 'johan.vdm@raceday.co.za'),      'Cape Winelands Cycle Tour', 'Scenic road cycling event through the Winelands.', '2026-11-14', 'Stellenbosch, Western Cape');

/*Categories: at least one per event*/
INSERT INTO Categories(EventID,CategoryName,DistanceKm,EntryFee,MaxParticipants)VALUES
((SELECT EventID FROM Events WHERE EventName = 'Soweto Community Marathon'), '5km Fun Run', 5.00, 100.00, 500),
((SELECT EventID FROM Events WHERE EventName = 'Soweto Community Marathon'), '21km Half Marathon', 21.10, 250.00, 300),
((SELECT EventID FROM Events WHERE EventName = 'Joburg Park Run Challenge'), '5km Timed Run', 5.00, 0.00, 200),
((SELECT EventID FROM Events WHERE EventName = 'Cape Winelands Cycle Tour'), '60km Road Cycle', 60.00, 350.00, 150),
((SELECT EventID FROM Events WHERE EventName = 'Cape Winelands Cycle Tour'), '100km Road Cycle', 100.00, 450.00, 150);

/*Enrolments:sample participant sign-ups*/
INSERT INTO Enrolments(ParticipantID,CategoryID,Status)VALUES
((SELECT UserID FROM Users WHERE Email = 'thabo.nkosi@example.com'), (SELECT CategoryID FROM Categories WHERE CategoryName = '21km Half Marathon'), 'Confirmed'),
((SELECT UserID FROM Users WHERE Email = 'aisha.patel@example.com'),(SELECT CategoryID FROM Categories WHERE CategoryName = '5km Fun Run'), 'Confirmed'),
((SELECT UserID FROM Users WHERE Email = 'aisha.patel@example.com'), (SELECT CategoryID FROM Categories WHERE CategoryName = '60km Road Cycle'), 'Pending');

/*Result:captured for confirmed enrolments*/
INSERT INTO Results(EnrolmentID,FinishTimeSeconds,Position,CapturedByOrganiser)VALUES
((SELECT EnrolementID FROM Enrolments e
  JOIN Users u ON e.ParticipantID= u.UserID
  JOIN Categories c ON e.CategoryID = c.CategoryID
  WHERE u.Email ='thabo.nkosi@example.com' AND c.CategoryName = '21km Half Marathon'),
  5820,12,(SELECT UserID FROM Users WHERE Email= 'Lindiwe.mokoena@raceday.co.za')),
  ((SELECT EnrolmentID FROM Enrolments e
  JOIN Users u ON e.ParticipantID= u.UserID
  JOIN Categories c ON e.CategoryID=c.CategoryID
  WHERE u.Email= 'aisha.patel@example.com' AND c.CategoryName = '5km Fun Run'),
  1530,4,(SELECT UserID FROM Users WHERE Email='lindiwe.mokoena@raceday.co.za'));

  /*Verification queries*/
  SELECT*FROM Roles;
  SELECT*FROM Users;
  SELECT*FROM Events;
  SELECT*FROM Categories;
  SELECT*FROM Enrolments;
  SELECT*FROM Results;
