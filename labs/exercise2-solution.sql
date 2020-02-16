# 3. List the artistid, artistname and entrydate of all artists whose entrydate is earlier than anyone who has a 'directmail' leadsource.
SELECT ArtistId, ArtistName, EntryDate
FROM Artists
WHERE EntryDate < ANY(
  SELECT EntryDate
  FROM Artists
  WHERE LeadSource = 'directmail'
);

# 6. List all genres from the Genre table that are not represented in the Titles table.
SELECT *
FROM Genre
WHERE Genre NOT IN (
  SELECT Genre
  FROM Titles
);

# 9. List the first name, last name and the birth date of the oldest member without using min(). (Hint: use a subquery and ALL)
SELECT LastName, FirstName, Birthday
FROM Members
WHERE Birthday <= ALL(
  SELECT Birthday
  FROM Members
);

# 10.List the first name, last name and the birth date of the second oldest member.
SELECT FirstName, LastName, Birthday
FROM Members
WHERE Birthday = (
  SELECT MIN(Birthday)
  FROM Members
  WHERE Birthday > (
    SELECT MIN(Birthday)
    FROM Members
  )
);

# JOINS

# 2. List each title from the Title table along with the name of the studio where it was recorded
SELECT Title, StudioName
FROM Titles
  INNER JOIN Studios ON Titles.StudioID = Studios.StudioID;
