/*1*/
/*List the films WHERE the yr is 1962 [Show id, title]
*/

SELECT id, title
FROM movie
WHERE yr=1962


/*2*/
/*Give year of 'Citizen Kane'.
*/

SELECT yr FROM movie
WHERE title= 'Citizen Kane'


/*3*/
/*List all of the Star Trek movies, include the id, title AND yr (all of these movies include the words Star Trek IN the title). Order results by year.
*/

SELECT id, title, yr FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr


/*4*/
/*What id number does the actor 'Glenn Close' have?
*/

SELECT id FROM actor
WHERE name='Glenn Close'


/*5*/
/*What is the id of the film 'Casablanca'
*/

SELECT id FROM movie
WHERE title='Casablanca'


/*6*/
/*Use movieid=11768, (OR whatever value you got FROM the previous question)*/

SELECT name 
FROM actor JOIN casting ON id=actorid
WHERE movieid=11768


/*7*/
/*Obtain the cast list for the film 'Alien'
*/

SELECT name 
FROM actor AS a JOIN casting AS c ON a.id=c.actorid
                JOIN movie AS m ON m.id=c.movieid
WHERE title='Alien'


/*8*/
/*List the films IN which 'Harrison Ford' has appeared*/

SELECT title
FROM movie AS m JOIN casting AS c ON m.id=c.movieid
                JOIN actor AS a ON a.id=c.actorid
WHERE director='Harrison Ford' OR name='Harrison Ford'


/*9*/
/*List the films WHERE 'Harrison Ford' has appeared - but not IN the starring role. [Note: the ordfield of casting gives the position of the actor. If ord=1 then this actor is IN the starring role]
*/

SELECT title
FROM movie AS m JOIN casting AS c ON m.id=c.movieid
                JOIN actor AS a ON a.id=c.actorid
WHERE (director='Harrison Ford' OR name='Harrison Ford') AND ord!=1


/*10*/
/*List the films together with the leading star for all 1962 films.
*/

SELECT title,name
FROM movie AS m JOIN casting AS c ON m.id=c.movieid
                JOIN actor AS a ON a.id=c.actorid
WHERE yr=1962 AND ord=1


/*11*/
/*Which were the busiest years for 'John Travolta', show the year AND the number of movies he made each year for any year IN which he made more than 2 movies.
*/

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
WHERE name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM movie 
         JOIN casting ON movie.id=movieid
         JOIN actor ON actorid=actor.id
 WHERE name='John Travolta'
 GROUP BY yr) AS t
)


/*12*/
/*List the film title AND the leading actor for all of the films 'Julie Andrews' played IN.
*/

SELECT title, name
FROM movie AS m JOIN casting AS c ON m.id=c.movieid
                JOIN actor AS a ON a.id=c.actorid
WHERE m.id IN (SELECT movieid FROM casting
               WHERE actorid IN (SELECT id FROM actor
                                 WHERE name='Julie Andrews')) AND ord=1


/*13*/
/*Obtain a list, IN alphabetical order, of actors who've had at least 30 starring roles.
*/

SELECT DISTINCT name FROM actor JOIN casting ON id=actorid
WHERE id IN (SELECT actorid FROM casting 
WHERE ord=1
GROUP BY actorid
HAVING Count(movieid)>=30
)


/*14*/
/*List the films released IN the year 1978 ordered by the number of actors IN the cast, then by title.
*/
SELECT title, Count(actorid) FROM movie JOIN casting ON id=movieid
WHERE yr=1978
GROUP BY movieid, title
ORDER BY Count(actorid) DESC, title
          


/*15*/
/*List all the people who have worked with 'Art Garfunkel'.
*/

SELECT name FROM actor JOIN casting ON id=actorid
WHERE movieid IN (

SELECT movieid FROM casting
WHERE actorid=(SELECT id FROM actor WHERE name='Art Garfunkel')
) AND name!='Art Garfunkel'




