
SELECT tournament.date, tournament.name AS tournament, winner.name AS winner, loser.name AS loser, matches.score, matches.A, matches.DF
	FROM matches
   		LEFT JOIN tournaments AS tournament ON matches.tournament = tournament.id
   		LEFT JOIN players AS winner ON matches.winner = winner.id
   		LEFT JOIN players AS loser ON matches.loser = loser.id;