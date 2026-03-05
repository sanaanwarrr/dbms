/* Sana Anwar & Hengjiali Xu CS 631 854 Homework2 */
-- Q1
PRAGMA foreign_keys = ON;

CREATE TABLE Studio (
    studioID INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    city TEXT
);

CREATE TABLE Movie (
    movieID INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    year INTEGER,
    length INTEGER,
    rating REAL,
    studioID INTEGER,
    FOREIGN KEY (studioID) REFERENCES Studio(studioID)
);

CREATE TABLE Actor (
    personID INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    gender TEXT
);

CREATE TABLE StarsIn (
    personID INTEGER,
    movieID INTEGER,
    PRIMARY KEY (personID, movieID),
    FOREIGN KEY (personID) REFERENCES Actor(personID),
    FOREIGN KEY (movieID) REFERENCES Movie(movieID)
);

-- Q2 (citation: used Gemini 3 Pro to find movie data)
INSERT INTO Studio (studioID, name, city) VALUES 
(1, 'MGM Studios', 'Los Angeles'),
(2, 'Lucasfilm', 'San Francisco'),
(3, 'Paramount Pictures', 'Los Angeles'),
(4, '20th Century Fox', 'Los Angeles'),
(5, 'Warner Bros.', 'Burbank'),
(6, 'Universal Pictures', 'Universal City');

INSERT INTO Actor (personID, name, gender) VALUES
(1, 'Daniel Craig', 'M'),
(2, 'Pierce Brosnan', 'M'),
(3, 'Reese Witherspoon', 'F'),
(4, 'Mark Hamill', 'M'),
(5, 'Harrison Ford', 'M'),
(6, 'Carrie Fisher', 'F'),
(7, 'Ewan McGregor', 'M'),
(8, 'Natalie Portman', 'F'),
(9, 'Leonardo DiCaprio', 'M'),
(10, 'Kate Winslet', 'F'),
(11, 'Tom Hardy', 'M'),
(12, 'Jonah Hill', 'M'),
(13, 'Emma Stone', 'F'),
(14, 'Ryan Gosling', 'M');

INSERT INTO Movie (movieID, title, year, length, studioID, rating) VALUES
(101, 'GoldenEye', 1995, 130, 1, 7.2),
(102, 'Casino Royale', 2006, 144, 1, 8.0),
(103, 'Skyfall', 2012, 143, 1, 7.8),
(104, 'Legally Blonde', 2001, 96, 1, 6.4),
(105, 'Creed', 2015, 133, 1, 7.6),
(106, 'No Time to Die', 2021, 163, 1, 7.3),
(201, 'Star Wars: Episode IV - A New Hope', 1977, 121, 2, 8.6),
(202, 'Star Wars: Episode V - The Empire Strikes Back', 1980, 124, 2, 8.7),
(203, 'Star Wars: Episode VI - Return of the Jedi', 1983, 131, 2, 8.3),
(204, 'Star Wars: Episode I - The Phantom Menace', 1999, 136, 2, 6.5),
(205, 'Star Wars: Episode III - Revenge of the Sith', 2005, 140, 2, 7.6),
(301, 'Titanic', 1997, 194, 3, 7.9), 
(302, 'Inception', 2010, 148, 5, 8.8), 
(303, 'The Wolf of Wall Street', 2013, 180, 3, 8.2), 
(304, 'The Revenant', 2015, 156, 4, 8.0), 
(305, 'Catch Me If You Can', 2002, 141, 6, 8.1),
(401, 'La La Land', 2016, 128, 5, 8.0),
(402, 'Jurassic Park', 1993, 127, 6, 8.2), 
(403, 'The Dark Knight', 2008, 152, 5, 9.0), 
(404, 'Forrest Gump', 1994, 142, 3, 8.8);

INSERT INTO StarsIn (personID, movieID) VALUES
-- MGM / Bond movies
(2, 101), 
(1, 102), 
(1, 103), 
(3, 104), 
(1, 106), 
-- Star Wars
(4, 201), 
(5, 201), 
(6, 201), 
(5, 202), 
(7, 204), 
(8, 204),
(7, 205), 
-- Leonardo DiCaprio Movies
(9, 301), 
(10, 301),
(9, 302), 
(11, 302),
(9, 303), 
(12, 303),
(9, 304), 
(11, 304),
(9, 305),
-- Other LA Studio Movies
(13, 401), 
(14, 401); 

-- Q3
.www
SELECT m.*
FROM Movie m
JOIN Studio s
ON m.studioID = s.studioID
WHERE s.name = 'MGM Studios' AND m.year > 1990 AND m.length > 90
ORDER BY m.length DESC;

-- Q4
.www
SELECT *
FROM Movie 
ORDER BY length ASC;

-- Q5
.www
SELECT name
FROM Actor
WHERE gender = 'F'
ORDER BY name ASC;

-- Q6
.www
SELECT DISTINCT s.name
FROM Studio s
JOIN Movie m ON s.studioID = m.studioID
WHERE m.title LIKE '%Star Wars%'
ORDER BY s.name ASC;

-- Q7
.www
SELECT m.title, s.name AS studio_name, m.rating, m.year
FROM Movie m
JOIN Studio s ON m.studioID = s.studioID
JOIN StarsIn si ON m.movieID = si.movieID
JOIN Actor a ON si.personID = a.personID
WHERE a.name = 'Leonardo DiCaprio'
ORDER BY m.year ASC;

-- Q8
.www
SELECT s.name, SUM(m.length) AS total_length
FROM Studio s
JOIN Movie m ON s.studioID = m.studioID
GROUP BY s.name
ORDER BY total_length DESC;

-- Q9
.www
SELECT name
FROM Studio
WHERE city = 'Los Angeles'
ORDER BY name ASC;

-- Q10
.www
SELECT a.name, AVG(m.rating) AS avg_rating
FROM Actor a
JOIN StarsIn si ON a.personID = si.personID
JOIN Movie m ON si.movieID = m.movieID
GROUP BY a.name
ORDER BY avg_rating DESC;