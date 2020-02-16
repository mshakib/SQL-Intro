/**
Section 1
**/

/*
Question 1
List the first name, last name, home phone, and gender of all members from Georgia who either have a home phone in area code 822 or are female
*/
SELECT FirstName, LastName, HomePhone, Gender
FROM Members
WHERE Region = 'GA' AND (HomePhone LIKE '822%' OR Gender = 'f');

/*
Question 2
List all the information of tracks that do not have an MP3.
*/
SELECT *
FROM Tracks
WHERE MP3 = 0;

/*
3.
List the TitleID, Title, and UPC of any titles whose UPC end with '2'
*/
SELECT TitleID, Title, UPC
FROM Titles
WHERE UPC LIKE '%2';

/*
4.
If the Base field reports the daily base salary of each salesperson, report the Fristname, Lastname, and weekly (5 work days) salary of each salesperson whose weekly salary is greater than $1000. The format of the results should be: First Name  Last Name  Weekly Salary
*/
SELECT FirstName, LastName, (Base * 5) AS 'Weekly Salary'
FROM SalesPeople
WHERE Base * 5 > 1000;

/*
5.
Report the average, shortest and longest track length in minutes of all tracks.
*/
SELECT AVG(LengthSeconds) / 60 AS 'Average length',
MAX(LengthSeconds) / 60 AS 'Longest length',
MIN(LengthSeconds) / 60 AS 'Shortest length'
FROM Tracks;

/*
6.
List the number of track titles that begin with the letter 's' and the average length of these tracks in seconds
*/
SELECT TrackNum AS 'Number of tracks title',
AVG(LengthSeconds) AS 'Average length'
FROM Tracks
WHERE TrackTitle LIKE 's%'
GROUP BY TrackNum;

/*
7.
Report the number of tracks for each TitleID
*/
SELECT TitleID, COUNT(*)
FROM Tracks
GROUP BY TitleID;

/*
8.
Report the total time in minutes for each titleid
*/
SELECT TitleID, SUM(LengthSeconds) / 60
FROM Tracks
GROUP BY TitleID;

/*
9.
Report region and the number of members in each region in the members table. Sort the results by the region.
*/
SELECT Region, COUNT(*)
FROM Members
GROUP BY Region
ORDER BY Region;

/*
10.
For any region that has more than one member with an e-mail address, list the region and the number of members with an e-mail address.
*/
SELECT Region, COUNT(Email)
FROM Members
GROUP BY Region
HAVING COUNT(Email) > 1;

SELECT Region, COUNT(*)
FROM Members
WHERE Email IS NOT NULL
GROUP BY Region
HAVING COUNT(*) > 1;

/**
SECTION 2
**/

/*
Q1
List the first name, last name, and region of all members from Virginia who either have a work phone or an email address.
/*/
SELECT FirstName, LastName, Region
FROM Members
WHERE Region = 'VA' AND (WorkPhone IS NOT NULL OR Email IS NOT NULL);

/*
2.
List the artist name and web address of any artists who has a web address. Rename the attributes artistname, webaddress as Artist Name, Web Address.
*/
SELECT ArtistName AS 'Artist Name',
WebAddress AS 'Web Address'
FROM Artists
WHERE WebAddress IS NOT NULL;

/*
3.
List the TitleID, TrackNum, and TrackTitle of all tracks with 'Song' at the beginning of the TrackTitle
*/
SELECT TitleID, TrackNum, TrackTitle
FROM Tracks
WHERE TrackTitle LIKE 'Song%';

/*
4.
Report the total time in minutes of all tracks with length greater than 150.
*/
SELECT SUM(LengthSeconds) / 60
FROM Tracks
WHERE LengthSeconds > 150;

/*
5.
List the number of tracks, total length in seconds and the average length in seconds of  all tracks with titleID 4.
*/
SELECT COUNT(*), SUM(LengthSeconds), AVG(LegnthSeconds)
FROM Tracks
WHERE TitleID = 4;

/*
6.
Report the number of male members who are in US.
*/
SELECT COUNT(*)
FROM Members
WHERE Gender = 'm' AND Country = 'USA';

/*
7.
Report the number of members by state and gender. Sort the results by the region
*/
SELECT Region, Gender, COUNT(*)
FROM Members
GROUP BY Region, Gender
ORDER BY Region;

/*
8.
For each kind of LeadSource, report the number of artists who came in to the system through that lead source, the earliest EntryDate, and the most recent EntryDate.
*/
SELECT LeadSource, COUNT(*), MAX(EntryDate), MIN(EntryDate)
FROM Artists
GROUP BY LeadSource;

/*
9.
Report the titleid, average, shortest and longest track length in minutes of all tracks for each titleid with average length greater than 300. Use proper column alias.
*/
SELECT TitleID,
AVG(LengthSeconds) / 60 AS 'Average',
MIN(LengthSeconds) / 60 AS 'Shortest',
MAX(LengthSeconds) / 60 AS 'Longest'
FROM Tracks
GROUP BY TitleID
HAVING AVG(LengthSeconds) > 300;

/*
10.
Report the TitleID and number of tracks for any TitleID with fewer than nine tracks.
*/
SELECT TitleID, COUNT(*)
FROM Tracks
GROUP BY TitleID
HAVING COUNT(*) < 9;
