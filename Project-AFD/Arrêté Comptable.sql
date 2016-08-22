-- Remove empty rows
DELETE *
FROM [Arrêté Comptable]
WHERE [N° concours] IS NULL;

-- Remove column
ALTER TABLE [Arrêté Comptable]
DROP COLUMN [Commentaires DBO au 31/12/2015];

-- Update repeated "N° concours"
UPDATE [Arrêté Comptable] SET [N° concours] = [N° concours] & "-" & Right([Année d'octroi],2)
WHERE [N° concours] = "CCM116901"
       OR [N° concours] = "CCM117601"
       OR [N° concours] = "CGA110701"
       OR [N° concours] = "CGH108001"
       OR [N° concours] = "CMG118901"
       OR [N° concours] = "CMG119201";

-- Update the column "CNE"
UPDATE [Arrêté Comptable] 
SET CNE = ""
WHERE [CNE GAR] IS NULL
       OR [CNE DBO] IS NULL;

-- Update the column "RAV sur signé "
UPDATE [Arrêté Comptable]
SET [RAV sur signé] = ""
WHERE [RAV sur signé GAR] IS NULL
       OR [RAV sur signé DBO] IS NULL;

-- Update the column "RAV non signé "
UPDATE [Arrêté Comptable]
SET [RAV non signé] = ""
WHERE [RAV sur non signé GAR] IS NULL
       OR [RAV sur non signé DBO] IS NULL;

-- Update the column "Risque"
UPDATE [Arrêté Comptable]
SELECT [Risque] = ""
WHERE [Risque GAR] IS NULL
       OR [Risque DBO] IS NULL;
