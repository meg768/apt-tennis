SELECT DISTINCT winner_name AS name, (SELECT COUNT(winner_name) FROM data
WHERE winner_name = name AND tourney_date > '2024-10-01') AS wins 
FROM data ORDER BY wins DESC;



SELECT DISTINCT winner_name AS name, (SELECT COUNT(winner_name) FROM data
WHERE winner_name = name AND DATEDIFF(tourney_date, DATE()) < 30 AS wins 
FROM data ORDER BY wins DESC;


SELECT DISTINCT winner_name AS name, (SELECT COUNT(winner_name) FROM data
WHERE winner_name = name) AS wins 
FROM data ORDER BY wins DESC;