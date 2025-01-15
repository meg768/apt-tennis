DROP VIEW `matches`;
CREATE VIEW `matches`
AS SELECT
   `data`.`tourney_date` AS `date`,
   `data`.`tourney_name` AS `tournament`,
   `data`.`tourney_level` AS `level`,
   `data`.`surface` AS `surface`,
   `data`.`winner_name` AS `winner`,
   `data`.`loser_name` AS `loser`,
   `data`.`round` AS `round`
FROM `data`;