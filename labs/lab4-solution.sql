# 1. Create `ArtistStudioContract` Table containing ArtistID, StudioID, and a ContractDate (Date type).
CREATE TABLE ArtistStudioContract (
    ArtistID int,
    StudioID int,
    ContractDate Date
);

# 2.Change `ArtistStudioContract` table from question 1 to have foreign keys of ArtistID to Artists table and StudioID to Studios table
ALTER TABLE Artists
ADD CONSTRAINT pk_artists PRIMARY KEY (ArtistID);
ALTER TABLE Studios
ADD CONSTRAINT pk_studios PRIMARY KEY (StudioID);

ALTER TABLE ArtistStudioContract 
ADD CONSTRAINT fk_ArtistStudioContract_artists FOREIGN KEY (ArtistID)
REFERENCES Artists (ArtistID);
ALTER TABLE ArtistStudioContract 
ADD CONSTRAINT fk_ArtistStudioContract_studios FOREIGN KEY (StudioID)
REFERENCES Studios (StudioID);

# 3. 
ALTER TABLE ArtistStudioContract
ADD COLUMN SalesID smallint;

ALTER TABLE SalesPeople
ADD CONSTRAINT pk_salespeople PRIMARY KEY (SalesID);

ALTER TABLE ArtistStudioContract 
ADD CONSTRAINT fk_ArtistStudioContract_sales FOREIGN KEY (SalesID)
REFERENCES SalesPeople (SalesID);

# 4. Add a record to `ArtistStudioContract` table indicating artist id 1 signed up contract sales person id 3 for studio id 2 and artist id 5 signed up with sales person id 1 with studio id 3 while both having contract date being Artist's entry date
INSERT INTO ArtistStudioContract (ArtistID, StudioId, SalesID, ContractDate)
SELECT 1, 2, 3, (SELECT EntryDate from Artists where ArtistID = 1);

INSERT INTO ArtistStudioContract (ArtistID, StudioId, SalesID, ContractDate)
SELECT 5, 3, 1, (SELECT EntryDate from Artists where ArtistID = 5);

# 5. Artist ID 1 decide to leave the company, delete Artist id 1 from the Artist table
-- also works but not ideal
DELETE FROM ArtistStudioContract
WHERE ArtistID = 1;
DELETE FROM Artists
WHERE ArtistID = 1;

-- prefered solution
ALTER TABLE ArtistStudioContract
DROP FOREIGN KEY fk_ArtistStudioContract_artists;

ALTER TABLE ArtistStudioContract 
ADD CONSTRAINT fk_ArtistStudioContract_artists FOREIGN KEY (ArtistID)
REFERENCES Artists (ArtistID)
ON DELETE CASCADE;
DELETE FROM Artists
WHERE ArtistID = 1;
