# Midterm

You have the entire class to finish this exam! There will be 20 sql questions you have to do in 4 hours.

A couple things you can do and a couple you cannot do:

Can:

* Open book/notes
* Open internet
* Yes, you can use your laptop to do test

Cannot:

* No talking to other classmates
* No messaging to your classmates or friends
* No, I will not be as helpful like labs

> You can still ask for clarification if you don't understand what question is

**Total points: 10 pts**

Time: entire class period

* Section 7 and 8: 12:00 - 4:30
* Section 9 and 10: 4:30 - 8:30

> For question 1 to 10, please use `lyric.sql` database:

1. List the TitleID, Track Title of all tracks whose Track Number is 3 and are at least 250 seconds long.
2. List the Title and Genre and UPC of all Titles whose second leftmost digit of UPC is '2'.
3. List the number of tracks and the average length under title id 4.
4. Find the name(s) of the artist(s) that have more than one members related to him/her.
5. List the following information of all members: the first name, the position of the first occurrence of 'e' within the first name, the last name, the position of the first occurrence of 'ar' within the last name. Use proper column names.
6. Find the track title of the longest track, the CD title of it and the artist's name.
7. List the artist name of all artists with ' ' anywhere in the artist's name.
8. List the number of tracks and the total length of the tracks with length longer than 3 minutes.
9. For each member, list the member id, area code, and the phone number without the area code.
10. List the member names in the form `{first initial}{period}{space}{last name}`, e.g. R. Alvarez. Order the results first by last name, then by first name. Only list those member who have both a first name and a last name in the database.  

  > For question 11 to 20, please use `book.sql` database:

11. List the author name and address of any authors. Rename the attributes au_name, address as Author Name, Street Address.
12. Report the number of titles for each authors
13. List all the information of titles that do not have a price.
14. Report the number of Authors who are in CA.
15. Report the titleid, average, smallest and largest price for each type with average price greater than 20. Use proper column alias.
16. List the title name, type and pages of the longest book (count in pages) without using max(). (Hint: use a subquery and ALL)
17. List name of publisher from California (CA) and their authors.
18. Report all the unique types from the titles table. Capitalize the first letter of each and the rest of the letters should be lower case.
19. Report the publisher name and the last word of each publisher name. Hint: the last word is the part that follows the space.
20. List the names of books published by the 'PTR Press'.
