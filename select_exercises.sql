USE albums_db;

SHOW tables;
DESCRIBE albums;

-- 3
-- a. How many rows are in the albums table?
# 31 Rows
SELECT * FROM albums;

-- b. How many unique artist names are in the albums table?
# 31
SELECT DISTINCT artist FROM albums;

-- c. What is the primary key for the albums table?
SELECT id FROM albums;

-- d. What is the oldest release date for any album in the albums table? What is the most recent release date?
-- SELECT release_date FROM albums WHERE release_date = 2011 AND release_date = 1967;
SELECT MAX(release_date) AS 'Recent Release', MIN(release_date) AS 'Oldest Release' FROM albums;

-- 4
-- a. The name of all albums by Pink Floyd
SELECT name FROM albums WHERE artist = 'Pink Floyd';

-- b. The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date FROM albums WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

-- c. The genre for the album Nevermind
SELECT genre FROM albums WHERE name = 'Nevermind';

-- d. Which albums were released in the 1990s
SELECT * FROM albums WHERE release_date > 1990;

-- e. Which albums had less than 20 million certified sales
SELECT * FROM albums WHERE sales > 20;

-- f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
SELECT * FROM albums WHERE genre = 'Rock';