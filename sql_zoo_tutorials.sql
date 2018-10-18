#### 0 SELECT basics

# 1
SELECT population FROM world
  WHERE name = 'Germany'

# 2
SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');

# 3
SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000

##################################################

#### 1 SELECT name
mmmmm got escaped

##################################################

#### 2 SELECT from World

# 1
SELECT name, continent, population FROM world

# 2
SELECT name FROM world
WHERE population >= 200000000

# 3
SELECT name, (GDP / population) as per_capita_GDP
 FROM world WHERE population >= 200000000

 # 4
 SELECT name, population / 1000000 FROM world
  WHERE continent = 'South America'

# 5
SELECT name, population FROM world WHERE name
 IN ('France', 'Germany', 'Italy')

# 6
SELECT name FROM world WHERE name LIKE '%United%'

# 7
SELECT name, population, area FROM world
 WHERE area > 3000000 OR population > 250000000

# 8
SELECT name, population, area FROM world
 WHERE area > 3000000 XOR population > 250000000

# 9
SELECT name, ROUND(population / 1000000, 2), ROUND(GDP / 1000000000, 2)
 FROM world WHERE continent = 'South America'

# 10
SELECT name, ROUND(GDP/ population , -3)  FROM world
 WHERE GDP  >= 1000000000000

# 11
SELECT name, capital FROM world
 WHERE LENGTH(name) = LENGTH(capital)

# 12
SELECT name, capital FROM world where
 LEFT(name,1) = LEFT(capital,1) and name <> capital

# 13
SELECT name FROM world WHERE name
 LIKE '%a%' AND name LIKE '%e%' AND name LIKE '%i%'
 AND name LIKE '%o%' AND name LIKE '%u%' AND name NOT LIKE '% %'

 ##################################################

 #### 3 SELECT from Nobel

 # 1
 SELECT yr, subject, winner FROM nobel WHERE yr = 1950

 # 2
 SELECT winner FROM nobel WHERE yr = 1962
  AND subject = 'Literature'

 # 3
 SELECT yr, subject FROM nobel WHERE winner = 'Albert Einstein'

 # 4
 SELECT winner FROM nobel WHERE subject = 'Peace' AND yr >= 2000

 # 5
 SELECT yr, subject, winner FROM nobel WHERE subject = 'Literature '
  AND yr BETWEEN 1980 AND 1989

 # 6
 SELECT * FROM nobel WHERE winner IN ('Theodore Roosevelt',
  'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama')
  AND yr BETWEEN 1980 AND 1989

 # 7
 SELECT winner FROM nobel WHERE winner LIKE 'john%'

 # 8
 SELECT * FROM nobel WHERE subject = 'Physics' AND yr = 1980
  OR subject = 'Chemistry' AND yr = 1984

 # 9
 SELECT * FROM nobel WHERE yr = 1980 AND subject NOT IN ('Chemistry ','Medicine')

 # 10
 SELECT * FROM nobel WHERE subject = 'Medicine' AND yr < 1910
  OR subject = 'Literature' AND yr >= 2004

 # 11
 SELECT * FROM nobel WHERE winner = 'PETER GRÜNBERG'

 # 12
 SELECT * FROM nobel WHERE winner = 'EUGENE O\'NEILL'

 # 13
 SELECT winner, yr, subject FROM nobel WHERE winner LIKE 'Sir%' order by yr desc, winner asc

 # 14
 SELECT winner, subject FROM nobel WHERE y r= 1984 ORDER BY CASE
  WHEN subject IN ('Physics','Chemistry') THEN 1 ELSE 0 END, subject,winner

##################################################

#### 4 SELECT within SELECT

 # 1
 SELECT name FROM world WHERE population > (SELECT population FROM world WHERE name='Russia')

 # 2
 SELECT name FROM world WHERE (GDP / population ) > (SELECT (GDP / population )FROM world
  WHERE name='United Kingdom') AND continent = 'Europe'

 # 3
 SELECT name, continent FROM world WHERE continent IN (SELECT continent FROM world
    WHERE name IN('Argentina',  'Australia')) ORDER BY name

 # 4
 SELECT name, population FROM world WHERE population > (SELECT population FROM world
    WHERE name = 'Canada') AND population < (SELECT population FROM world
       WHERE name = 'Poland') ORDER BY population

 # 5
 SELECT name, CONCAT(ROUND((population / (SELECT population FROM world WHERE name = 'Germany')
  *100),0), '%')FROM world WHERE continent = 'Europe'

 # 6
 SELECT name FROM world WHERE GDP > ALL (SELECT GDP FROM world WHERE continent = 'Europe' and GDP > 0)

 # 7
 SELECT continent, name, area FROM world x WHERE area >= ALL (SELECT area FROM world y WHERE
    y.continent=x.continent AND area >0)

 # 8
 SELECT continent, name FROM world x WHERE name = (SELECT name from world y where
    x.continent = y.continent order by name asc limit 1)

 # 9
 SELECT name, continent, population FROM world WHERE continent NOT IN (SELECT DISTINCT
   continent FROM world WHERE population > 25000000)

 # 10
 SELECT name, continent FROM world x WHERE population > ALL (SELECT population * 3 FROM
    world y WHERE y.continent = x.continent AND y.name != x.name)

##################################################

#### 5 SUM and COUNT

# 1
SELECT SUM(population) FROM world

# 2
SELECT DISTINCT continent FROM world

# 3
SELECT SUM(GDP) FROM world WHERE continent = 'Africa'

# 4
SELECT COUNT(area) FROM world WHERE area > 1000000

# 5
SELECT SUM(population) FROM world WHERE name IN ('Estonia','Latvia','Lithuania')

# 6
SELECT DISTINCT continent, COUNT(name) FROM world GROUP BY continent

# 7
SELECT DISTINCT continent, COUNT(name) FROM world WHERE population >= 10000000 GROUP BY continent

# 8
SELECT DISTINCT continent FROM world  GROUP BY continent HAVING SUM(population) >= 100000000

##################################################

#### 6 JOIN

# 1
SELECT matchid, player FROM goal WHERE teamid = 'GER'

# 2
SELECT id,stadium,team1,team2 FROM game where id = 1012

# 3
SELECT player, teamid, stadium, mdate FROM game JOIN goal ON (id=matchid) WHERE teamid = 'Ger'

# 4
SELECT  team1, team2, player FROM game JOIN goal ON (id=matchid) WHERE player LIKE 'Mario%'

# 5
SELECT player, teamid, coach, gtime FROM goal JOIN eteam on teamid = id WHERE gtime<=10

# 6
SELECT mdate, teamname  FROM game JOIN eteam ON (team1=eteam.id) WHERE coach = 'Fernando Santos'

# 7
SELECT player FROM goal JOIN game ON matchid = game.id WHERE stadium = 'National Stadium, Warsaw'

# 8
SELECT DISTINCT player FROM game JOIN goal ON matchid = id WHERE (teamid!='GER' AND (team1='GER'
   OR team2='GER'))

# 9
SELECT teamname, count(player) FROM eteam JOIN goal ON id=teamid GROUP BY teamname
 ORDER BY teamname

# 10
SELECT stadium, count(player) FROM game JOIN goal ON id=matchid GROUP BY stadium
 ORDER BY stadium

# 11
SELECT matchid,mdate, count(player) FROM game JOIN goal ON matchid = id
WHERE (team1 = 'POL' OR team2 = 'POL') GROUP BY matchid,mdate

# 12
SELECT matchid,mdate, count(teamid) FROM game JOIN goal ON matchid = id
 WHERE (teamid = 'GER') GROUP BY matchid,mdate

# 13
SELECT  game.mdate, game.team1,
        SUM(CASE WHEN goal.teamid=game.team1 THEN 1 ELSE 0 END) score1, game.team2,
        SUM(CASE WHEN goal.teamid=game.team2 THEN 1 ELSE 0 END) score2
FROM game INNER JOIN goal  ON game.id=goal.matchid
GROUP BY game.mdate, goal.matchid, game.team1, game.team2

##################################################

#### 7 More JOIN operations

# 1
SELECT id, title FROM movie WHERE yr=1962

# 2
SELECT yr FROM movie WHERE title = 'Citizen Kane'

# 3
SELECT id, title, yr FROM movie WHERE title LIKE '%Star Trek%'

# 4
SELECT id FROM actor WHERE name = 'Glenn Close'

# 5
SELECT id FROM movie WHERE title = 'Casablanca'

# 6
SELECT DISTINCT name from actor join casting on actor.id = casting.actorid where movieid = 11768

# 7
SELECT name FROM movie JOIN casting ON movie.id = movieid JOIN actor ON actorid=actor.id
 WHERE movie.title = 'Alien'

# 8
SELECT title FROM movie JOIN casting ON movie.id = casting.movieid JOIN actor
 ON casting.actorid = actor.id WHERE name = 'Harrison Ford'

# 9
SELECT title FROM movie JOIN casting ON movie.id=movieid JOIN actor
 ON actorid=actor.id WHERE actor.name = 'Harrison Ford' AND ord > 1

# 10
SELECT title, name FROM movie JOIN casting ON movie.id=movieid JOIN actor
 ON actorid=actor.id WHERE yr=1962 AND ord=1

# 11
SELECT yr,COUNT(title) FROM movie JOIN casting ON movie.id=movieid JOIN actor
   ON actorid=actor.id where name='John Travolta' GROUP BY yr HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM movie JOIN casting ON movie.id=movieid JOIN actor
   ON actorid=actor.id where name='John Travolta' GROUP BY yr) AS t)

# 12
SELECT title, name FROM movie JOIN casting ON movie.id=movieid JOIN actor
   ON actorid=actor.id WHERE ord=1 AND movie.id IN (SELECT movie.id  FROM movie
   JOIN casting ON movie.id=movieid JOIN actor ON actorid=actor.id WHERE name = 'Julie Andrews')

# 13
SELECT name FROM movie JOIN casting ON movie.id=movieid
  JOIN  actor   ON actorid=actor.id GROUP BY name HAVING COUNT(title)>=30 ORDER BY name

# 14
SELECT title, COUNT(movieid) FROM movie JOIN casting ON movie.id=movieid JOIN actor
 ON actorid=actor.id WHERE yr = 1978 GROUP BY title ORDER BY COUNT(movieid) DESC

# 15
SELECT DISTINCT name FROM movie JOIN casting ON  movie.id=movieid
  JOIN actor ON actorid=actor.id WHERE movie.id IN (SELECT movie.id
FROM movie JOIN casting ON movie.id=movieid JOIN actor ON actorid=actor.id
WHERE name = 'Art Garfunkel') AND name!= 'Art Garfunkel'

##################################################

#### 8 Using Null

# 1
SELECT name FROM teacher WHERE dept IS NULL

# 2
SELECT teacher.name, dept.name FROM teacher INNER JOIN dept ON (teacher.dept=dept.id)

# 3
SELECT teacher.name, dept.name FROM teacher LEFT JOIN dept ON (teacher.dept=dept.id)

# 4
SELECT teacher.name, dept.name FROM teacher RIGHT JOIN dept ON (teacher.dept=dept.id)

# 5
SELECT name, COALESCE(mobile,'07986 444 2266') FROM teacher

# 6
SELECT teacher.name, COALESCE(dept.name,'None') FROM teacher LEFT JOIN dept ON (teacher.dept=dept.id)

# 7
SELECT COUNT(name), COUNT(mobile) FROM teacher

# 8
SELECT dept.name, COUNT(teacher.name) FROM teacher RIGHT JOIN dept ON (teacher.dept=dept.id) GROUP BY dept.name

# 9
SELECT name, CASE WHEN dept IN (1,2) THEN 'Sci' ELSE  'Art' END FROM teacher

# 10
SELECT name, CASE WHEN dept IN (1,2) THEN 'Sci' WHEN dept = 3  THEN 'Art' ELSE  'None' END FROM teacher

##################################################

#### 9 Self join

# 1
SELECT COUNT(*) FROM stops

# 2
SELECT id FROM stops WHERE name = 'Craiglockhart'

# 3
SELECT id, name FROM stops JOIN route ON id = stop WHERE num = 4 AND company = 'LRT'

# 4
SELECT company, num, COUNT(*) FROM route WHERE stop=149 OR stop=53
 GROUP BY company, num HAVING COUNT(*) > 1

# 5
SELECT a.company, a.num, a.stop, b.stop FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num) WHERE a.stop=53 AND b.stop = 149

# 6
SELECT a.company, a.num, stopa.name, stopb.name FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num) JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id) WHERE stopa.name='Craiglockhart' AND stopb.name = 'London Road'
