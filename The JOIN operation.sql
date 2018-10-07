/*1*/
/*Modify it to show the matchid AND player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
*/

SELECT matchid, player FROM goal 
WHERE teamid = 'GER'


/*2*/
/*Show id, stadium, team1, team2 for just game 1012*/

SELECT g.matchid, stadium, team1, team2
FROM goal AS g LEFT JOIN game AS h ON g.matchid=h.id
WHERE g.matchid=1012 AND player='Lars Bender'


/*3*/
/*Modify it to show the player, teamid, stadium AND mdate for every German goal.*/

SELECT player, teamid, stadium, mdate
FROM game JOIN goal ON (id=matchid)
WHERE teamid='GER'


/*4*/
/*Show the team1, team2 AND player for every goal scored by a player called Mario player LIKE 'Mario%'
*/

SELECT team1, team2, player
FROM game JOIN goal ON (id=matchid)
WHERE player LIKE 'Mario%'


/*5*/
/*Show player, teamid, coach, gtime for all goals scored IN the first 10 minutes gtime<=10*/

SELECT player, teamid, coach, gtime
FROM goal JOIN eteam ON (teamid=id)
WHERE gtime<=10


/*6*/
/*List the the dates of the matches AND the name of the team IN which 'Fernando Santos' was the team1 coach.*/

SELECT mdate, teamname 
FROM game AS g JOIN eteam AS e ON (g.team1=e.id)
WHERE coach='Fernando Santos'


/*7*/
/*List the player for every goal scored IN a game WHERE the stadium was 'National Stadium, Warsaw'*/

SELECT player
FROM game AS g JOIN goal AS e ON (e.matchid=g.id)
WHERE stadium ='National Stadium, Warsaw'


/*8*/
/*The example query shows all goals scored IN the Germany-Greece quarterfinal.
Instead show the name of all players who scored a goal against Germany.
*/

SELECT distinct player
FROM game JOIN goal ON matchid = id 
WHERE (teamid!='GER' AND team1='GER') OR (teamid!='GER' AND team2='GER')


/*9*/
/*Show teamname AND the total number of goals scored.*/

SELECT teamname, Count(matchid)
FROM eteam JOIN goal ON id=teamid
GROUP BY teamname
ORDER BY teamname


/*10*/
/*Show the stadium AND the number of goals scored IN each stadium.
*/

SELECT stadium, Count(stadium)
FROM game JOIN goal ON (id = matchid)
GROUP BY stadium


/*11*/
/*For every match involving 'POL', show the matchid, date AND the number of goals scored.
*/

SELECT matchid, mdate, Count(id)
FROM game JOIN goal ON (id= matchid) 
WHERE team1 = 'POL' OR team2 = 'POL'
GROUP BY matchid, mdate


/*12*/
/*For every match WHERE 'GER' scored, show matchid, match date AND the number of goals scored by 'GER'
*/

SELECT matchid, mdate, Count(matchid)
FROM game JOIN goal ON (id=matchid)
WHERE teamid='GER'
GROUP BY matchid, mdate


/*13*/
/*List every match with the goals scored by each team AS shown. This will use "CASE WHEN" which has not been explained IN any previous exercises.*/

SELECT mdate,team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) AS score1, team2,
  SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) AS score2
FROM game LEFT JOIN goal ON matchid = id
GROUP BY mdate, team1,team2
ORDER BY mdate,matchid,team1,team2



