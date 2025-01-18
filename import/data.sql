
TRUNCATE TABLE import;
TRUNCATE TABLE data;

INSERT INTO import SELECT * FROM `2025`;
INSERT INTO import SELECT * FROM `2024`;
INSERT INTO import SELECT * FROM `2023`;
/*
INSERT INTO import SELECT * FROM `2022`;
INSERT INTO import SELECT * FROM `2021`;
INSERT INTO import SELECT * FROM `2020`;
INSERT INTO import SELECT * FROM `2019`;
INSERT INTO import SELECT * FROM `2018`;
INSERT INTO import SELECT * FROM `2017`;
INSERT INTO import SELECT * FROM `2016`;
INSERT INTO import SELECT * FROM `2015`;
INSERT INTO import SELECT * FROM `2014`;
INSERT INTO import SELECT * FROM `2013`;
INSERT INTO import SELECT * FROM `2012`;
INSERT INTO import SELECT * FROM `2011`;
INSERT INTO import SELECT * FROM `2010`;
*/

/* Adjust for cr/lf and junk */
UPDATE import SET l_bpFaced = REGEXP_REPLACE(l_bpFaced, '[^0-9]+', '');
UPDATE import SET draw_size = REGEXP_REPLACE(draw_size, '[^0-9]+', '');

UPDATE import SET surface = NULL WHERE surface = '';

UPDATE import SET tourney_date = NULL WHERE tourney_date = '';
UPDATE import SET match_num = NULL WHERE match_num = '';
UPDATE import SET minutes = NULL WHERE minutes = '';
UPDATE import SET draw_size = NULL WHERE draw_size = '';

UPDATE import SET winner_ht = NULL WHERE winner_ht = '';
UPDATE import SET winner_age = NULL WHERE winner_age = '';
UPDATE import SET winner_rank = NULL WHERE winner_rank = '';
UPDATE import SET winner_rank_points = NULL WHERE winner_rank_points = '';
UPDATE import SET winner_seed = NULL WHERE winner_seed = '';

UPDATE import SET loser_ht = NULL WHERE loser_ht = '' OR loser_ht = 'U';
UPDATE import SET loser_age = NULL WHERE loser_age = '';
UPDATE import SET loser_rank = NULL WHERE loser_rank = '';
UPDATE import SET loser_rank_points = NULL WHERE loser_rank_points = '';
UPDATE import SET loser_seed = NULL WHERE loser_seed = '';

UPDATE import SET w_ace = NULL WHERE w_ace = '';
UPDATE import SET w_df = NULL WHERE w_df = '';
UPDATE import SET w_svpt = NULL WHERE w_svpt = '';
UPDATE import SET w_1stin = NULL WHERE w_1stin = '';
UPDATE import SET w_1stWon = NULL WHERE w_1stWon = '';
UPDATE import SET w_2ndWon = NULL WHERE w_2ndWon = '';
UPDATE import SET w_SvGms = NULL WHERE w_SvGms = '';
UPDATE import SET w_bpSaved = NULL WHERE w_bpSaved = '';
UPDATE import SET w_bpFaced = NULL WHERE w_bpFaced = '';

UPDATE import SET l_ace = NULL WHERE l_ace = '';
UPDATE import SET l_df = NULL WHERE l_df = '';
UPDATE import SET l_svpt = NULL WHERE l_svpt = '';
UPDATE import SET l_1stin = NULL WHERE l_1stin = '';
UPDATE import SET l_1stWon = NULL WHERE l_1stWon = '';
UPDATE import SET l_2ndWon = NULL WHERE l_2ndWon = '';
UPDATE import SET l_SvGms = NULL WHERE l_SvGms = '';
UPDATE import SET l_bpSaved = NULL WHERE l_bpSaved = '';
UPDATE import SET l_bpFaced = NULL WHERE l_bpFaced = '';

INSERT INTO data SELECT * FROM import;

TRUNCATE  TABLE import;
