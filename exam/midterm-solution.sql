use lyric;

# 1. List the TitleID, Track Title of all tracks whose Track Number is 3 and are at least 250 seconds long.
SELECT TitleID, TrackTitle
FROM Tracks
WHERE TrackNum = 3 AND LengthSeconds > 250;

# 2. List the Title and Genre and UPC of all Titles whose second leftmost digit of UPC is '2'.
SELECT Title, Genre, UPC
FROM Titles
WHERE UPC LIKE '_2%';

# 3. List the number of tracks and the average length under title id 4.
SELECT COUNT(*), AVG(LengthSeconds)
FROM Tracks
WHERE TitleID = 4;

# 4. Find the name(s) of the artist(s) that have more than one members related to him/her.
SELECT ArtistName
FROM Artists a 
INNER JOIN XRefArtistsMembers x
USING (ArtistID)
GROUP BY ArtistName
HAVING COUNT(*) > 1;

# 5. List the following information of all members: the first name, the position of the first occurrence of 'e' within the first name, the last name, the position of the first occurrence of 'ar' within the last name. Use proper column names.
SELECT FirstName, 
    LOCATE('e', FirstName) AS 'Occurence of e in FirstName',
    LOCATE('ar', LastName) AS 'Occurence of ar in LastName'
FROM Members;

# 6. Find the track title of the longest track, the CD title of it and the artist's name.
SELECT TrackTitle, Title, ArtistName
FROM Tracks
INNER JOIN Titles
USING(TitleID)
INNER JOIN Artists
USING(ArtistID)
WHERE LengthSeconds = (
    SELECT MAX(LengthSeconds)
    FROM Tracks
);

# 7. List the artist name of all artists with ' ' anywhere in the artist's name.
SELECT ArtistName
FROM Artists
WHERE ArtistName LIKE '% %';

# 8. List the number of tracks and the total length of the tracks with length longer than 3 minutes.
SELECT COUNT(*), SUM(LengthSeconds)
FROM Tracks
WHERE LengthSeconds > (60 * 3);

# 9. For each member, list the member id, area code, and the phone number without the area code.
SELECT MemberID, 
    LEFT(HomePhone, 3) AS 'Area Code', 
    SUBSTRING(HomePhone, 4) AS 'Phone Number without area code'
FROM Members;

# 10. List the member names in the form `{first initial}{period}{space}{last name}`, e.g. R. Alvarez. Order the results first by last name, then by first name. Only list those member who have both a first name and a last name in the database.
SELECT CONCAT(
    LEFT(FirstName, 1),
    '. ',
    LastName
)
FROM Members
WHERE FirstName IS NOT NULL AND LastName IS NOT NULL AND -- for null checking
FirstName != '' AND LastName != '' -- for empty string checking
ORDER BY LastName, FirstName;

use books;

# 11. List the author name as '{FirstName}{space}{LastName}' (e.g. Eric Liao) and address of any authors. Rename the attributes name, address as Author Name, Street Address.
SELECT CONCAT(au_fname, ' ', au_lname) AS 'Author Name',
Address AS 'Street Address'
FROM Authors;

# 12. Report author id and the number of titles for each authors
SELECT au_id, COUNT(*) AS 'Number of titles'
FROM Authors
INNER JOIN title_authors
USING (au_id)
GROUP BY au_id;

# 13. List all the information of titles that do not have a price.
SELECT * 
FROM Titles
WHERE price IS NULL;

# 14. Report the number of Authors who are in CA.
SELECT COUNT(*)
FROM Authors
WHERE State = 'CA';

# 15. Report the type, average, smallest and largest price for each type with average price greater than 20. Use proper column alias.
SELECT type, AVG(price), MIN(price), MAX(price) 
FROM Titles
GROUP BY type
HAVING AVG(price) > 20;

# 16. List the title name, type and pages of the longest book (count in pages) without using max(). (Hint: use a subquery and ALL)
SELECT title_name, type, pages
FROM Titles
WHERE pages IS NOT NULL AND pages >= ALL (
    SELECT pages
    FROM Titles
    WHERE pages IS NOT NULL
);

# 17. List unique name of publisher from California (CA) and their authors.
SELECT DISTINCT pub_name, au_fname, au_lname
FROM Publishers
LEFT JOIN Titles
USING (pub_id)
LEFT JOIN Title_Authors
USING (title_id)
LEFT JOIN Authors
USING (au_id)
WHERE Publishers.state = 'CA';

# 18. Report all the unique types from the titles table. Capitalize the first letter of each and the rest of the letters should be lower case.
SELECT DISTINCT CONCAT(UPPER(LEFT(type, 1)), LOWER(SUBSTRING(type, 2)))
FROM Titles;

# 19. Report the publisher name and the last word of each publisher name. Hint: the last word is the part that follows the space.
# only display the last word not the last two words
SELECT pub_name, TRIM(SUBSTRING(pub_name, LOCATE(' ', pub_name)))
FROM Publishers;

# 20. List the names of books published by the 'Tenterhooks Press'.
SELECT title_name
FROM Titles
INNER JOIN Publishers
USING(pub_id)
WHERE pub_name = 'Tenterhooks Press';
