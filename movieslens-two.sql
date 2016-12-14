/*Get the average rating for a movie*/
SELECT m.movieid, m.title, avg(r.movieid)
FROM movies m
LEFT JOIN ratings r ON m.movieid = r.movieid
  WHERE m.movieid = 102
GROUP BY m.movieid;

/*Get the total ratings for a movie*/
SELECT m.title, count(r.rating)
FROM movies m
LEFT JOIN ratings r on m.movieid = r.movieid
  WHERE m.movieid = 102
GROUP BY m.movieid;

/*Get total movies for a genre*/
SELECT g.genres, count(m.movieid)
FROM genre g
JOIN movie_genre mg on g.id = mg.genre_id
JOIN movies m ON mg.movieid = m.movieid
  WHERE g.id = 11
GROUP BY g.genres;

/*Get the average rating for a user*/
SELECT avg(rating), userid
FROM ratings
  WHERE userid = 6
GROUP BY userid;

/*Find the user with the most ratings*/
SELECT userid, count(rating)
FROM ratings
GROUP BY userid
ORDER BY count(rating) DESC
LIMIT 1;

/*Find the user with the highest average rating with more than 50 reviews*/
SELECT userid, count(rating), avg(rating)
FROM ratings
GROUP BY userid
  HAVING count(rating) > 50
ORDER BY avg(rating) DESC
LIMIT 1;

/*Find the movies with an average rating over 4*/
SELECT m.title, avg(r.rating)
FROM movies m
JOIN ratings r ON m.movieid = r.movieid
GROUP BY m.title
HAVING avg(r.rating) > 4;

/*For each genre find the total number of reviews as well as the average review, sort by highest average review*/
SELECT g.genres, count(r.rating), avg(r.rating)
FROM genre g
JOIN movie_genre mg on  g.id = mg.genre_id
JOIN movies m on mg.movieid = m.movieid
JOIN ratings r ON m.movieid = r.movieid
GROUP BY g.genres
ORDER BY avg(r.rating) DESC;

/*Pick 3 movies and create insert statements for 10 actors each.You should use the multi value insert statements*/
INSERT INTO actors (actor_name, character_name, movieid, date_of_brith) VALUES ('Tom Hanks', 'Sheriff Woody', 1,
                                                                                '7/9/1956'),
  ('Tim Allen', 'Buzz lightyear', 1, '6/13/1953'), ('Don Rickles', 'Mr.potato Head', 1, '5/8/1965'),
  ('Wallace Shawn', 'Rex', 1, '11/12/1943'), ('John Ratzenberger', 'Hamm', 1, '4/6/1947'),
  ('John Morris', 'Andy', 1, '10/2/1984'), ('Jim Varney', 'Slinky Dog', 1, '6/15/1949'),
  ('Laurie Metcalf', 'Andys Mom', 1, '6/16/1955'), ('R. Lee Ermey', 'Sergeant', 1, '3/24/1944'),
  ('Annie Potts', 'Little Bo Peep', 1, '10/28/1952'), ('Robin Williams', 'Alan PArrish', 2, '8/21/1951'),
  ('Kirsten Dunst', 'Judy Shepherd', 2, '4/30/1982'), ('Bradley Pierce', 'Peter Shepherd', 2, '10/23/1982'),
  ('Bonnie Hunt', 'Sarah Whittle', 2, '9/22/1961'), ('Jonathan Hyde', 'Sam Parrish', 2, '5/21/1948'),
  ('Bebe Neuwirth', 'Nora Shepherd', 2, '12/31/1958'), ('David Alan Grier', 'Carl Bentley', 2, '6/30/1956'),
  ('Adam Hann-byrd', 'Alan Parrish', 2, '2/23/1982'), ('Patricia Clarkson', 'Carol Parrish', 2, '12/29/1959'),
  ('Gillian Barber', 'Mrs.Thomas', 2, '2/22/1958'), ('Jim Carrey', 'Ace Ventura', 16, '1/17/1962'),
  ('Ian McNeice', 'Fulton Greenwall', 16, '10/2/1950'), ('Simon Callow', 'Vincent Cadby', 16, '6/15/1949'),
  ('Bob Gunton', 'Burton Quinn', 16, '11/15/1945'), ('Sophie Okonedo', 'Wachati Princess', 16, '8/11/1968'),
  ('Maynard Eziashi', 'Ouda', 16, '1/1/1995'), ('Tommy Davidson', 'Tiny Warrior', 16, '11/10/1963'),
  ('Adewale Akinnuoye-Agbaje','Hitu', 16, '8/22/1967'), ('Bruce Spence', 'Gahjii', 16, '9/17/1945'),
  ('Michael Reid Mackay', 'Skinny Husband', 16, '6/24/1953');

/*Create a new column in the movie table to hold the MPAA rating. Update 5 Different movies to their correct rating*/
ALTER TABLE public.movies ADD mpaa_rating VARCHAR(10) NULL;
UPDATE movies SET mpaa_rating = 'PG-13' WHERE movieid = 10;
UPDATE movies SET mpaa_rating = 'PG-13' WHERE movieid = 44;
UPDATE movies SET mpaa_rating = 'G' WHERE movieid = 48;
UPDATE movies SET mpaa_rating = 'R' WHERE movieid = 69;
UPDATE movies SET mpaa_rating = 'R' WHERE movieid = 145;
/*testing to see mpaa ratings*/
SELECT mpaa_rating, title, movieid
FROM movies
ORDER BY mpaa_rating;

/*Create a new field on the movies table for the year. Using an update query and a substring method update that column
for every movie with the year found in the title column*/
ALTER TABLE public.movies ADD year VARCHAR(4) NULL;
UPDATE movies SET year = substring(title, '\d{4}');
/*testing to see years on movies*/
SELECT title, year, movieid
FROM movies
ORDER BY year;
