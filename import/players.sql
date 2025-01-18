TRUNCATE TABLE players;

INSERT INTO players
	SELECT DISTINCT id, NULL AS name, NULL AS country, NULL AS handed FROM 
		(SELECT winner_id AS id FROM data UNION SELECT loser_id AS id FROM data) AS data
        WHERE id <> '';

UPDATE players
    SET name = (SELECT winner_name FROM data WHERE winner_id = players.id ORDER BY tourney_date DESC LIMIT 1)
    WHERE name IS NULL;

UPDATE players
    SET name = (SELECT loser_name FROM data WHERE loser_id = players.id ORDER BY tourney_date DESC LIMIT 1)
    WHERE name IS NULL;

UPDATE players
    SET country = (SELECT winner_ioc FROM data WHERE winner_name = players.name ORDER BY tourney_date DESC LIMIT 1)
    WHERE country IS NULL;

UPDATE players
    SET country = (SELECT loser_ioc FROM data WHERE loser_name = players.name ORDER BY tourney_date DESC LIMIT 1)
    WHERE country IS NULL;

UPDATE players
    SET handed = (SELECT winner_hand FROM data WHERE winner_name = players.name ORDER BY tourney_date DESC LIMIT 1)
    WHERE handed IS NULL;

UPDATE players
    SET handed = (SELECT loser_hand FROM data WHERE loser_name = players.name ORDER BY tourney_date DESC LIMIT 1)
    WHERE handed IS NULL;
