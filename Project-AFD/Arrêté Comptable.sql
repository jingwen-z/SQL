-- Remove empty rows
DELETE *
FROM [Arrêté Comptable]
WHERE [N° concours] IS NULL;

-- Remove columns
ALTER TABLE [Arrêté Comptable]
DROP COLUMN Clé, [Commentaires DBO au 31/12/2015]
