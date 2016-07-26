--Remove the columns
ALTER TABLE GI
DROP COLUMN [Commentaires Déclassement/Reclassement au 30/09/2014], [Commentaires Déclassement/Reclassement au 31/03/2016], [Données Tableau MEJ], F34, F35, F36, F37, F38, F39, F40, F41, F42, F43, F44, F45, F46, F47, F48, F49, F50, F51, F52, F53, F54, F55, F56, F57, F58, F59, F60, F61, F62; 

-- Remove the empty lines
DELETE *
FROM GI
WHERE [N° concours] IS NULL;

-- Determine the primary key
ALTER TABLE GI
ADD PRIMARY KEY ([N° concours]);
-- Put in order
SELECT *
FROM GI
ORDER BY [Date d'octroi] DESC;
