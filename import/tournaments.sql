
TRUNCATE TABLE tournaments;

INSERT INTO tournaments
    SELECT DISTINCT 
        tourney_id, NULL, NULL, NULL, NULL, NULL
    FROM data WHERE tourney_level <> 'D' ORDER BY tourney_name;

UPDATE tournaments
    SET 
        name = (SELECT tourney_name FROM data WHERE tourney_id = tournaments.id ORDER BY tourney_date DESC LIMIT 1),
        date = (SELECT tourney_date FROM data WHERE tourney_id = tournaments.id ORDER BY tourney_date DESC LIMIT 1),
        surface = (SELECT surface FROM data WHERE tourney_id = tournaments.id ORDER BY tourney_date DESC LIMIT 1),
        level = (SELECT tourney_level FROM data WHERE tourney_id = tournaments.id ORDER BY tourney_date DESC LIMIT 1),
        draw = (SELECT draw_size FROM data WHERE tourney_id = tournaments.id ORDER BY tourney_date DESC LIMIT 1);
