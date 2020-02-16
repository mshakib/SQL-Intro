# 1. Report the number of female, male members and the total number.  Use proper column names.
SELECT Gender, COUNT(*) AS 'Number of members'
FROM Members
GROUP BY Gender
UNION
SELECT 'Total', COUNT(*)
FROM Members;

# 2. For each title id, report the number of sound files.
SELECT TitleID, COUNT(*)
FROM (
    SELECT TitleID, MP3 AS 'Sound File'
    FROM Tracks
    WHERE MP3 = 1
    UNION ALL
    SELECT TitleID, RealAud AS 'Sound File'
    FROM Tracks
    WHERE RealAud = 1
) T
GROUP BY TitleID;

# 3. The following SQL statement uses an Intersect to list all cities and regions that have both members and artists:
SELECT DISTINCT City, Region
FROM Artists
INNER JOIN Members
USING(City, Region);

# 4.Produce a list of all of the area codes used in both member's home phones and studio's phones along with a count of the phone numbers for each area code.
SELECT AreaCode,
    COUNT(areaCode) AS 'Number of Area Codes'
FROM (
    SELECT LEFT(homephone,3) AS areaCode
    FROM Members
    UNION All
    SELECT LEFT(phone,3)
    FROM Studios
) P
GROUP BY AreaCode;

# Data manipulation

# 1. The title 'Time Flies' now has a new track, the 11th track 'Spring', which is 150 seconds long and has only a MP3 file. Insert the new track into Tracks table.
INSERT INTO Tracks
(TitleID, TrackNum, TrackTitle, LengthSeconds, MP3)
SELECT TitleID, 11, 'Spring', 150, 1
FROM Titles
WHERE Title = 'Time Flies';

# 2. The area code for Columbus, Ohio has been changed from 277 to 899. Update the homephone and workphone numbers of all members in Members2 table accordingly.
UPDATE Members
SET HomePhone = CONCAT('899', RIGHT(HomePhone,7)),
WorkPhone = CONCAT('899 ', RIGHT(WorkPhone,7))
WHERE City='Columbus' AND Region='OH' AND (HomePhone LIKE '277%' OR WorkPhone LIKE '277%');

# 3. Salesperson Bob Bentley has agreed to turn over all his female members to salesperson Lisa Williams whose sales id is 2. Update the Members2 table accordingly.
UPDATE Members
SET SalesID = 2
WHERE Gender = 'F' AND SalesID IN (
    SELECT SalesID
    FROM SalesPeople
    WHERE FirstName = 'Bob' AND
    LastName = 'Bentley'
);

# 4. Members Doug Finney and Terry Irving are forming a new artist to be called "Doug and Terry." Add this record to the Artists table, using ArtistID 13, the address information of Doug Finney, no web address, today's entry date, and no lead source. Don’t hand-code any data for insert that can be looked up from the Members table.
INSERT INTO Artists
(ArtistID,Artistname,City,Region,Country,EntryDate)
SELECT 13, 'Doug and Terry', City, Region, Country, NOW()
    FROM Members
    WHERE FirstName='Doug' AND LastName='Finney';

# 5. Add the appropriate new records to the XrefArtistsMembers table for the artist "Doug and Terry" (see #4). Doug is the responsible party. Don’t hand-code any data for insert that can be looked up from the Members table.
INSERT INTO XrefArtistsMembers
(ArtistID,MemberID,RespParty)
SELECT 13, MemberID, (
    CASE Firstname
        When 'Doug' Then 1
        Else 0
    End
)
FROM Members
WHERE (Firstname='Doug' AND Lastname='Finney') OR (Firstname='Terry' AND Lastname='Irving');

##########################################
# Evening section

# 1. Report the number of artists who entered in the same year  and the total number.
SELECT Year(EntryDate) AS Year,
    Count(*) As 'Number'
FROM Artists
GROUP BY Year
UNION
SELECT 'Total', COUNT(*)
FROM Artists;

# 2. For title id 1, report  the title ID, track title, lengthseconds, the average lengthseconds for all tracks of title id 1 , and the difference value between the lengthseconds and the average value.
SELECT Titleid, TrackTitle, LengthSeconds,
(
    SELECT AVG(LengthSeconds)
    FROM Tracks WHERE TitleID = 1
) AS AvgSec,
LengthSeconds - (
    SELECT AVG(LengthSeconds)
    FROM Tracks WHERE TitleID = 1
) AS Difference
FROM Tracks 
WHERE TitleID = 1;

# 3. Report the title name, number of tracks, and total time in minutes for each title.
SELECT Title, (
    SELECT COUNT(*) 
    FROM Tracks
    WHERE TitleID = Titles.titleID
) AS NumTracks,
(
    SELECT SUM(LengthSeconds)/60 
    FROM Tracks
    WHERE TitleID = Titles.titleID
) AS NumMinutes
FROM Titles;

# OR the following produces the same result
SELECT Title, COUNT(*) AS Count, SUM(LengthSeconds)/60 As NumMinutes
FROM Titles, Tracks
WHERE Titles.TitleID = Tracks.TitleID
GROUP BY Title
ORDER BY Title;

# 4. For each artist list the artist name and the first and last name (together in one column) of every member associated with that artist followed on the next line by a count of the number of members associated with that artist. Include all artists whether they have members or not.
SELECT 0 As Seq, ArtistName, CONCAT(FirstName, ' ', LastName ) as Member
FROM (
    Artists A
    LEFT JOIN XrefArtistsMembers X
    ON A.artistID=X.artistID
)
LEFT JOIN Members M 
ON X.memberID=M.memberID
UNION
SELECT 1, ArtistName, CONCAT(Count(MemberID), ' ', ' Members')
FROM Artists A
LEFT JOIN XrefArtistsMembers X
ON A.artistID=X.artistID
GROUP BY ArtistName
ORDER BY ArtistName, seq;

# 5. List the artist id and the artist name of all artist who have members not in USA
SELECT DISTINCT A.ArtistID, A.ArtistName 
FROM (
    Artists A
    INNER JOIN XrefArtistsMembers X
    ON A.artistID = X.artistID
)
INNER JOIN (
    SELECT memberID 
    FROM Members M 
    WHERE M.country != 'USA'
) M 
ON M.memberID = X.memberID; 

# Data manipulation

# 1. Add a new artist with the following information. Use a proper function to automatically get today's date.
INSERT INTO Artists
(ArtistID,Artistname,City,Region,Country, WebAddress,EntryDate,LeadSource) 
VALUES (12,'November','New Orleans','LA','USA','www.November.com',NOW(),'Directmail');

# 2. Lyric Music has decided to set up a web page for every artist who doesn't have a web site. The web address will be www.lyricmusic.com/ followed by the artistID. Fill this in for every artist record that doesn't already have a web site.
UPDATE Artists
SET WebAddress = CONCAT('www.lyricmusic.com/', ArtistID)
WHERE WebAddress IS NULL;

# 3. Delete all members who work for the artist 'Sonata' from Members2 table.
DELETE FROM Members2
WHERE MemberID IN (
    SELECT memberID
    FROM Artists A, XrefArtistsMembers X
    WHERE A.ArtistID = X.ArtistID AND A.ArtistName = 'Sonata'
);

# 4. The area code for Columbus, Ohio has been changed from 277 to 899. Update the homephone and workphone numbers of all members in Members2 table accordingly.
UPDATE Members2
SET HomePhone = CONCAT('899', right(HomePhone,7)),
WorkPhone = CONCAT('899 ', right(WorkPhone,7))
WHERE City='Columbus' AND Region='OH' AND (HomePhone LIKE '277%' OR WorkPhone LIKE '277%');