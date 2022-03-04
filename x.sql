Use EventDatabase;

--- Testing 
DROP TABLE IF EXISTS [Event];
DROP TABLE IF EXISTS [User];
DROP TABLE IF EXISTS Participants;
DROP TABLE IF EXISTS Options;
DROP TABLE IF EXISTS Selection;

DROP PROCEDURE IF EXISTS AddUser;
DROP PROCEDURE IF EXISTS CreateEvent
DROP PROCEDURE IF EXISTS DeleteUser
DROP PROCEDURE IF EXISTS DeleteEvent
DROP PROCEDURE IF EXISTS AddParticipant
GO

CREATE TABLE [Event](
	Id INT PRIMARY KEY IDENTITY(1,1),
	Title VARCHAR(50),
	[Date] DATETIME,
	EventExpiryDate DATETIME,
	Deadline DATETIME
);

CREATE TABLE [User](
	Username VARCHAR(50) PRIMARY KEY,
	RegName VARCHAR(50),
	Email VARCHAR(50),
	[Password] VARCHAR(50),
	[Admin] BIT,
	UserExpiryDate DATETIME
);

CREATE TABLE Participation(
	User_Username VARCHAR(50) PRIMARY KEY,
	Event_Id INT,
	FOREIGN KEY (User_Username) REFERENCES [User](Username),
	FOREIGN KEY (Event_Id) REFERENCES [Event](Id)
);

CREATE TABLE Options(
	ItemName VARCHAR(50) PRIMARY KEY,
	Event_Id INT,
	FOREIGN KEY (Event_Id) REFERENCES [Event](Id)
);

CREATE TABLE Selection(
	Option_Id VARCHAR(50),
	Part_Id VARCHAR(50),
	Amount INT, 
	FOREIGN KEY (Option_Id) REFERENCES Options(ItemName),
	FOREIGN KEY (Part_Id) REFERENCES Participation(User_Username)
);
GO

CREATE PROCEDURE AddUser @_Username VARCHAR(50), @_Password VARCHAR(50), @_Email VARCHAR(50), @_RegName VARCHAR(50)
AS
BEGIN
	INSERT INTO [User](Username, [Password], Email, RegName) VALUES(@_Username, @_Password, @_Email, @_RegName)
END;
GO;

CREATE PROCEDURE CreateEvent @_Title VARCHAR(50), @_Date DATETIME, @_EventExpiryDate DATETIME
AS
BEGIN
	INSERT INTO [Event](Title, [Date], EventExpiryDate) VALUES(@_Title, @_Date, @_EventExpiryDate)
END;
GO;

CREATE PROCEDURE DeleteUser @_RegName VARCHAR(50)
AS
BEGIN
	DELETE FROM [User] WHERE RegName = @_RegName;
END;
GO;

CREATE PROCEDURE DeleteEvent @_ID INT
AS
BEGIN
	DELETE FROM [Event] WHERE ID = @_ID;
END;
GO;

CREATE PROCEDURE AddParticipant @_Username VARCHAR(50), @_Event_Id INT
AS
BEGIN
	INSERT INTO Participation(User_Username, Event_Id) VALUES(@_Username, @_Event_Id)
END;
GO;

CREATE PROCEDURE DeleteParticipant @_Username VARCHAR(50), @_Event_Id INT
AS
BEGIN
	DELETE FROM Participation WHERE User_Username = @_Username AND Event_Id = @_Event_Id
END;
GO;

CREATE PROCEDURE AddOption @_ItemName VARCHAR(50), @_Event_Id INT
AS
BEGIN
	INSERT INTO Options(ItemName, Event_Id) VALUES(@_ItemName, @_Event_Id)
END;
GO;

CREATE PROCEDURE DeleteOption @_ItemName VARCHAR(50), @_Event_Id INT
AS
BEGIN
	DELETE FROM Options WHERE ItemName = @_ItemName AND Event_Id = @_Event_Id
END;
GO;

--EXEC [ProcedureName] @Variable = "", @Variable2 = ""