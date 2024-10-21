USE FIFADB
GO
CREATE TABLE Club (
    ClubID INT PRIMARY KEY,
    ClubName VARCHAR(100) NOT NULL,
    ClubLocation VARCHAR(100) NOT NULL
);

CREATE TABLE Player (
    PlayerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Birthdate DATE NOT NULL,
    ClubID INT,
    CONSTRAINT FK_Player_Club FOREIGN KEY (ClubID) REFERENCES Club(ClubID)
);
CREATE TABLE Position (
    PositionID INT PRIMARY KEY,
    PositionName VARCHAR(50) NOT NULL
);
CREATE TABLE PlayerPosition (
    PlayerPositionID INT PRIMARY KEY,
    PlayerID INT,
    PositionID INT,
    CONSTRAINT FK_PlayerPosition_Player FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID),
    CONSTRAINT FK_PlayerPosition_Position FOREIGN KEY (PositionID) REFERENCES Position(PositionID)
);
CREATE TABLE Match (
    MatchID INT PRIMARY KEY,
    MatchDate DATETIME NOT NULL,
    HomeClubID INT,
    AwayClubID INT,
    CONSTRAINT FK_Match_HomeClub FOREIGN KEY (HomeClubID) REFERENCES Club(ClubID),
    CONSTRAINT FK_Match_AwayClub FOREIGN KEY (AwayClubID) REFERENCES Club(ClubID)
);
CREATE TABLE Goal (
    GoalID INT PRIMARY KEY,
    MatchID INT,
    PlayerID INT,
    GoalTime TIME NOT NULL,
    CONSTRAINT FK_Goal_Match FOREIGN KEY (MatchID) REFERENCES Match(MatchID),
    CONSTRAINT FK_Goal_Player FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID)
);
CREATE TABLE Stadium (
    StadiumID INT PRIMARY KEY,
    StadiumName VARCHAR(100) NOT NULL,
    ClubID INT,
    CONSTRAINT FK_Stadium_Club FOREIGN KEY (ClubID) REFERENCES Club(ClubID)
);

--Indexes--
USE FIFADB
GO
-- Creating an index on the Club table to improve performance on queries that filter by ClubName
CREATE NONCLUSTERED INDEX IX_Club_ClubName ON dbo.Club (ClubName);

-- Creating an index on the Player table to improve performance on queries that filter by LastName
CREATE NONCLUSTERED INDEX IX_Player_LastName ON Player (LastName);

-- Creating an index on the Match table to improve performance on queries that filter by MatchDate
CREATE NONCLUSTERED INDEX IX_Match_MatchDate ON Match (MatchDate);

-- Creating an index on the Goal table to improve performance on queries that filter by GoalTime
CREATE NONCLUSTERED INDEX IX_Goal_GoalTime ON Goal (GoalTime);

-- Creating an index on the Stadium table to improve performance on queries that filter by StadiumName
CREATE NONCLUSTERED INDEX IX_Stadium_StadiumName ON Stadium (StadiumName);

--Club Table records--
USE FIFADB
GO
--Club Table records--
INSERT INTO Club (ClubID, ClubName, ClubLocation)
VALUES
    (1, 'Real Madrid', 'Madrid'),
    (2, 'Barcelona', 'Barcelona'),
    (3, 'Manchester United', 'Manchester'),
    (4, 'Chelsea', 'London'),
    (5, 'Bayern Munich', 'Munich'),
    (6, 'Paris Saint-Germain', 'Paris'),
    (7, 'Liverpool', 'Liverpool'),
    (8, 'Juventus', 'Turin'),
    (9, 'AC Milan', 'Milan'),
    (10, 'Inter Milan', 'Milan'),
    (11, 'Arsenal', 'London'),
    (12, 'Tottenham Hotspur', 'London');

	--RECORDS IN PLAYER--
	USE FIFADB
GO
INSERT INTO Player (PlayerID, FirstName, LastName, Birthdate, ClubID)
VALUES 
  (1, 'Lionel', 'Messi', '1987-06-24', 1),
  (2, 'Cristiano', 'Ronaldo', '1985-02-05', 2),
  (3, 'Neymar', 'Jr.', '1992-02-05', 1),
  (4, 'Kylian', 'Mbappé', '1998-12-20', 3),
  (5, 'Kevin', 'De Bruyne', '1991-06-28', 4),
  (6, 'Sadio', 'Mané', '1992-04-10', 5),
  (7, 'Virgil', 'van Dijk', '1991-07-08', 6),
  (8, 'Robert', 'Lewandowski', '1988-08-21', 7),
  (9, 'Mohamed', 'Salah', '1992-06-15', 5),
  (10, 'Manuel', 'Neuer', '1986-03-27', 7),
  (11, 'Harry', 'Kane', '1993-07-28', 8),
  (12, 'Erling', 'Haaland', '2000-07-21', 9);

   --RECORDS IN POSITION TABLE--
   USE FIFADB
GO
INSERT INTO Position (PositionID, PositionName)
VALUES 
    (1, 'Goalkeeper'),
    (2, 'Defender'),
    (3, 'Midfielder'),
    (4, 'Forward'),
    (5, 'Left-back'),
    (6, 'Right-back'),
    (7, 'Centre-back'),
    (8, 'Defensive midfielder'),
    (9, 'Attacking midfielder'),
    (10, 'Left winger'),
    (11, 'Right winger'),
    (12, 'Centre forward');

	--RECORDS IN PP TABLE--
	USE FIFADB
GO
INSERT INTO PlayerPosition (PlayerPositionID, PlayerID, PositionID)
VALUES (1, 1, 2),
       (2, 1, 3),
       (3, 2, 1),
       (4, 3, 4),
       (5, 4, 2),
       (6, 4, 3),
       (7, 5, 4),
       (8, 6, 1),
       (9, 6, 2),
       (10, 7, 3),
       (11, 8, 4),
       (12, 9, 1);

	   --RECORDS IN MATCH TBL--
	   USE FIFADB
GO
INSERT INTO Match (MatchID, MatchDate, HomeClubID, AwayClubID)
VALUES (1, '2022-01-01 18:00:00', 3, 4),
(2, '2022-02-02 19:00:00', 1, 2),
(3, '2022-03-03 20:00:00', 5, 6),
(4, '2022-04-04 21:00:00', 2, 4),
(5, '2022-05-05 18:30:00', 1, 3),
(6, '2022-06-06 19:30:00', 2, 5),
(7, '2022-07-07 20:30:00', 4, 6),
(8, '2022-08-08 21:30:00', 3, 5),
(9, '2022-09-09 18:45:00', 2, 6),
(10, '2022-10-10 19:45:00', 1, 4),
(11, '2022-11-11 20:45:00', 3, 6),
(12, '2022-12-12 21:45:00', 1, 5);

--RECORDS IN GOAL--
USE FIFADB
GO
INSERT INTO Goal (GoalID, MatchID, PlayerID, GoalTime)
VALUES 
  (1, 1, 1, '00:12:30'),
  (2, 1, 2, '00:20:45'),
  (3, 1, 3, '01:05:12'),
  (4, 2, 4, '00:05:23'),
  (5, 2, 5, '00:10:18'),
  (6, 2, 6, '00:37:50'),
  (7, 3, 7, '00:15:30'),
  (8, 3, 8, '00:29:08'),
  (9, 4, 9, '00:08:57'),
  (10, 4, 10, '00:27:16'),
  (11, 5, 11, '00:02:43'),
  (12, 5, 12, '00:17:35')

  --RECORDS IN STADIUM--
  USE FIFADB
GO
INSERT INTO Stadium (StadiumID, StadiumName, ClubID)
VALUES 
  (1, 'Old Trafford', 1),
  (2, 'Anfield', 2),
  (3, 'Emirates Stadium', 3),
  (4, 'Etihad Stadium', 4),
  (5, 'Stamford Bridge', 5),
  (6, 'Tottenham Hotspur Stadium', 6),
  (7, 'King Power Stadium', 7),
  (8, 'Villa Park', 8),
  (9, 'Goodison Park', 9),
  (10, 'Elland Road', 10),
  (11, 'St Mary''s Stadium', 11),
  (12, 'The Hawthorns', 12);


  --RETRIVAL OF DATA MADE EASIER--
USE FIFADB
GO
--ALL MATCHES PLAYED BY A SPECIFIC CLUB--
SELECT *
FROM Match
WHERE HomeClubID = 1 OR AwayClubID = 1;

--ALL PLAYERS WHO PLAY IN A SPECIFIC POSITION
SELECT Player.*
FROM Player
JOIN PlayerPosition ON Player.PlayerID = PlayerPosition.PlayerID
JOIN Position ON PlayerPosition.PositionID = Position.PositionID
WHERE Position.PositionName = 'Defender';

--ALL PLAYERS WHO HAVE NOT SCORED IN A SEASON--
SELECT Player.*
FROM Player
LEFT JOIN Goal ON Player.PlayerID = Goal.PlayerID
LEFT JOIN Match ON Goal.MatchID = Match.MatchID
WHERE YEAR(Match.MatchDate) = 2
      AND Goal.GoalID IS NULL;


--GOALS SCORED BY A PLAYER IN A SEASON--
SELECT Player.FirstName, Player.LastName, SUM(1) as TotalGoals
FROM Player
JOIN Goal ON Player.PlayerID = Goal.PlayerID
JOIN Match ON Goal.MatchID = Match.MatchID
WHERE YEAR(Match.MatchDate) = 1
GROUP BY Player.PlayerID, Player.FirstName, Player.LastName
ORDER BY TotalGoals DESC;

--ALL MATCHES PLAYED IN A SPECIFIC STADIUM--
SELECT *
FROM Match
JOIN Stadium ON Match.HomeClubID = Stadium.ClubID OR Match.AwayClubID = Stadium.ClubID
WHERE Stadium.StadiumID = 1;


	--VIEWS--
	USE FIFADB
	GO
--A view that shows the matches played by each club in the Match table--
 CREATE VIEW MatchesPlayedByClub
AS
SELECT c.ClubName, COUNT(m.MatchID) AS MatchesPlayed
FROM Club c
LEFT JOIN Match m ON c.ClubID = m.HomeClubID OR c.ClubID = m.AwayClubID
GROUP BY c.ClubName;

	-- Returns a list of all players along with their positions--
CREATE VIEW PlayerPositions AS
SELECT Player.FirstName, Player.LastName, Position.PositionName
FROM Player
LEFT JOIN PlayerPosition ON Player.PlayerID = PlayerPosition.PlayerID
LEFT JOIN Position ON PlayerPosition.PositionID = Position.PositionID;

--CONSTRAINTS--
USE FIFADB
GO

-- Adding a NOT NULL constraint on ClubName in the Club table
ALTER TABLE Club
ALTER COLUMN ClubName VARCHAR(100) NOT NULL;


-- Adding a FOREIGN KEY constraint on AwayClubID in the Match table to reference the Club table
ALTER TABLE Match
ADD CONSTRAINT FK_Match_AwayClub2 FOREIGN KEY (AwayClubID) REFERENCES Club(ClubID);


--STORED PROCEDURES--
USE FIFADB
GO
--returns goals by a player--
CREATE PROCEDURE GetPlayerStats
    @PlayerID INT
AS
BEGIN
    SELECT COUNT(g.GoalID) AS GoalsScored, COUNT(DISTINCT m.MatchID) AS MatchesPlayed
    FROM Goal g
    INNER JOIN Match m ON g.MatchID = m.MatchID
    WHERE g.PlayerID = 2;
END;

--Adds new matches--
CREATE PROCEDURE AddMatch
    @MatchDate DATETIME,
    @HomeClubID INT,
    @AwayClubID INT
AS
BEGIN
    INSERT INTO Match (MatchDate, HomeClubID, AwayClubID)
    VALUES (@MatchDate, @HomeClubID, @AwayClubID);
END;


--Triggers--
USE FIFADB
GO
--Updates the club's last modified date whenever a record is updated 

CREATE TRIGGER UpdateClubRecord1
ON Club
AFTER UPDATE
AS
BEGIN
  UPDATE Club
  SET LastModifiedDate = GETDATE()
  FROM Club c
  INNER JOIN inserted i ON c.ClubID = i.ClubID
END

--automatically adds a player to a club when their club ID is updated 
CREATE TRIGGER AddPlayerToClub
ON Player
AFTER UPDATE
AS
BEGIN
  IF UPDATE(ClubID)
  BEGIN
    DECLARE @playerID INT
    DECLARE @clubID INT
    SELECT @playerID = PlayerID, @clubID = ClubID FROM inserted
    
    IF NOT EXISTS(SELECT 1 FROM PlayerClub WHERE PlayerID = @playerID AND ClubID = @clubID)
    BEGIN
      INSERT INTO PlayerClub(PlayerID, ClubID) VALUES(@playerID, @clubID)
    END
  END
END


--LOGINS--
USE FIFADB
GO
-- Create login with full access
CREATE LOGIN full_access_login WITH PASSWORD = 'strong_password';
USE [FIFADB];
CREATE USER full_access_user FOR LOGIN full_access_login;
ALTER ROLE db_owner ADD MEMBER full_access_user;

-- Create login with read-only access
CREATE LOGIN readonly_login WITH PASSWORD = 'secure_password';
USE [FIFADB];
CREATE USER readonly_user FOR LOGIN readonly_login;
ALTER ROLE db_datareader ADD MEMBER readonly_user;


--BACKUP--
BACKUP DATABASE [FIFADB_database]
TO DISK ='C:\backup\full_backup.bak'
WITH INIT;


