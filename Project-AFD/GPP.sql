-- Remove the empty lines
DELETE *
FROM GPP
WHERE [N° de convention AFD] IS NULL;

-- Determine the primary key
ALTER TABLE GPP
ADD PRIMARY KEY ([N° de convention AFD]);
 
-- Put in increasing order
SELECT *
FROM GPP
ORDER BY Pays;

-- update the column "Moyenne des prêts en EUR "
UPDATE GPP 
SET [Moyenne des prêts en EUR] = 0
WHERE [Min des prêts en EUR] = 0 And [Max des prêts en EUR] = 0;
