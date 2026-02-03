Author(authorID, name)
Authoring(articleID, authorID)
Article(articleID, title, venue, year, month)

-- problem 1: list the articles authored by john smith

SELECT DISTINCT A.articleID, A.title, A.venue, A.year, A.month
FROM Article A
JOIN Authoring Ag ON A.articleID = Ag.articleID
JOIN Author Au ON Ag.authorID = Au.authorID
WHERE Au.name = 'John Smith';

-- problem 2: list the articls authored by both john smith and marc antoine

SELECT title 
FROM Article
WHERE articleID IN (
    SELECT articleID FROM Authoring JOIN Author USING (authorID) WHERE name = 'John Smith'
)
INTERSECT
SELECT title 
FROM Article
WHERE articleID IN (
    SELECT articleID FROM Authoring JOIN Author USING (authorID) WHERE name = 'Marc Antoine'
);

-- problem 3: list the coauthors of john smith

SELECT DISTINCT name
FROM Author
JOIN Authoring USING (authorID)
WHERE articleID IN (
    SELECT articleID 
    FROM Authoring 
    JOIN Author USING (authorID) 
    WHERE name = 'John Smith'
)
AND name <> 'John Smith';

-- problem 4: list all the articles published in the last year

SELECT *
FROM Article
WHERE year = 2025;

-- problem 5: list pairs of articles that have the same titles with different IDs

SELECT A1.articleID, A2.articleID, A1.title
FROM Article A1, Article A2
WHERE A1.title = A2.title 
AND A1.articleID < A2.articleID;