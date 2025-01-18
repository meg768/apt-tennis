

  SELECT  DISTINCT
   
   winner_name AS name, 

   	(SELECT COUNT(winner_name) FROM data WHERE winner_name = name) as wins, 
   	(SELECT COUNT(loser_name) FROM data WHERE loser_name = name) as losses, 

   (
   		SELECT COUNT(winner_name) FROM data WHERE winner_name = name) / 
   		(
   			(SELECT COUNT(loser_name) FROM data WHERE loser_name = name) +
   			(SELECT COUNT(winner_name) FROM data WHERE winner_name = name)
   		
   ) * 100
   AS percent

   
   FROM data WHERE winner_rank < 100 
   ORDER BY percent DESC
   ;
