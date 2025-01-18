


/* Queries */ 

DROP VIEW IF EXISTS `query-hotlist-60`;

CREATE VIEW `query-hotlist-60` AS   
   SELECT DISTINCT winner_name AS name, (SELECT COUNT(winner_name) FROM data
   WHERE winner_name = name AND DATEDIFF(CURDATE(), tourney_date) < 60) AS wins 
   FROM data ORDER BY wins DESC LIMIT 10;;

DROP VIEW IF EXISTS `query-hotlist-90`;

CREATE VIEW `query-hotlist-90` AS   
   SELECT DISTINCT winner_name AS name, (SELECT COUNT(winner_name) FROM data
   WHERE winner_name = name AND DATEDIFF(CURDATE(), tourney_date) < 90) AS wins 
   FROM data ORDER BY wins DESC LIMIT 10;;


DROP VIEW IF EXISTS `query-hotlist-30`;

CREATE VIEW `query-hotlist-30` AS   
   SELECT DISTINCT winner_name AS name, (SELECT COUNT(winner_name) FROM data
   WHERE winner_name = name AND DATEDIFF(CURDATE(), tourney_date) < 30) AS wins 
   FROM data ORDER BY wins DESC LIMIT 10;


