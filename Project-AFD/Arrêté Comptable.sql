-- Remove empty rows
DELETE *
FROM [Arrêté Comptable]
WHERE [N° concours] IS NULL;

-- Update repeated "N° concours"
UPDATE [Arrêté Comptable] SET [N° concours] = [N° concours] & "-" & Right([Année d'octroi],2)
WHERE [N° concours] = "CCM116901"
       OR [N° concours] = "CCM117601"
       OR [N° concours] = "CGA110701"
       OR [N° concours] = "CGH108001"
       OR [N° concours] = "CMG118901"
       OR [N° concours] = "CMG119201";

-- Determine the primary key
ALTER TABLE  [Arrêté Comptable]
ADD PRIMARY KEY ([N° concours]);

-- Update the column "Ecart-CNE"
UPDATE [Arrêté Comptable] 
SET [Ecart-CNE] = ""
WHERE [CNE GAR] IS NULL
   OR [CNE DBO] IS NULL;

-- Update the column "Ecart-RAV sur signé "
UPDATE [Arrêté Comptable]
SET [Ecart-RAV sur signé] = ""
WHERE [RAV sur signé GAR] IS NULL
   OR [RAV sur signé DBO] IS NULL;

-- Update the column "Ecart-RAV non signé "
UPDATE [Arrêté Comptable]
SET [Ecart-RAV non signé] = ""
WHERE [RAV sur non signé GAR] IS NULL
   OR [RAV sur non signé DBO] IS NULL;

-- Update the column "Ecart-Risque"
UPDATE [Arrêté Comptable]
SET [Ecart-Risque] = ""
WHERE [Risque GAR] IS NULL
       OR [Risque DBO] IS NULL;

-- Remove the faux values in "Durée du prêt-En mois"
UPDATE [Arrêté Comptable] SET [Durée du prêt-En mois] = ""
WHERE [Durée du prêt-En mois] = "15/06/2017"
       OR [Durée du prêt-En mois] = "30/09/2010"
       OR [Durée du prêt-En mois] = "30/04/2010"
       OR [Durée du prêt-En mois] = "28/02/2010";

-- Correct a value in "TA transmis à DBO"
UPDATE [Arrêté Comptable]
SET [TA transmis à DBO] = "16/09/2013"
WHERE [TA transmis à DBO] = "30/04/2013-16/09/2013";

-- Creation of a new column “Observations ou modalités”
ALTER TABLE  [Arrêté Comptable]
ADD COLUMN [Observations ou modalités commission GPP après signature] Text;

-- Transformation information from "Table Principale"
UPDATE [Arrêté Comptable]
LEFT JOIN  [Table Principale]
ON [Arrêté Comptable].[N° concours] = [Table Principale].[N° concours]
SET [Arrêté Comptable].[Observations ou modalités commission GPP après signature] = [Table Principale].[Observations ou modalités commission GPP après signature];

-- Standardization of spelling in the column "Durée du prêt-En mois"
UPDATE [Arrêté Comptable]
SET [Durée du prêt-En mois] = "jusqu'au 30/06/2010"
WHERE [N° concours] = "CMG131601";

-- Transformation information from "En mois" to "Observation"
UPDATE [Arrêté Comptable]
SET [Observations ou modalités commission GPP après signature] = [Observations ou modalités commission GPP après signature] & "   Durée du prêt-En mois: " & [Durée du prêt-En mois] 
WHERE [Durée du prêt-En mois] = "jusqu'au 30/06/2012"
   OR [Durée du prêt-En mois] = "6 mois renouvelable"
   OR [Durée du prêt-En mois] = "jusqu'au 30/06/2011"
   OR [Durée du prêt-En mois] = "31/03/2011"
   OR [Durée du prêt-En mois] = "30/06/2012"
   OR [Durée du prêt-En mois] = "Validité 30/06/2010 renouvelable 6 mois"
   OR [Durée du prêt-En mois] = "validité 31/08/2010 attent date débloc ?"
   OR [Durée du prêt-En mois] = "jusqu'au 30/11/2010"
   OR [Durée du prêt-En mois] = "validité 31/03/2010"
   OR [Durée du prêt-En mois] = "validité 31/01/2010"
   OR [Durée du prêt-En mois] = "jusqu'au 30/06/2010"
   OR [Durée du prêt-En mois] = "30/06/2009"
   OR [Durée du prêt-En mois] = "30/04/2009"
   OR [Durée du prêt-En mois] = "31/03/2009"
   OR [Durée du prêt-En mois] = "31/08/2012 dt 4 mois"
   OR [Durée du prêt-En mois] = "(prêt) 8 ans dont 1 et (leasing) 5 ans"
   OR [Durée du prêt-En mois] = "jusqu'au 31/07/2011"
   OR [Durée du prêt-En mois] = "jusqu'au 30/11/2010";

-- Remove irregular data in "En mois"
UPDATE [Arrêté Comptable]
SET [Durée du prêt-En mois] = ""
WHERE [Durée du prêt-En mois] = "jusqu'au 30/06/2012"
   OR [Durée du prêt-En mois] = "6 mois renouvelable"
   OR [Durée du prêt-En mois] = "jusqu'au 30/06/2011"
   OR [Durée du prêt-En mois] = "31/03/2011"
   OR [Durée du prêt-En mois] = "30/06/2012"
   OR [Durée du prêt-En mois] = "Validité 30/06/2010 renouvelable 6 mois"
   OR [Durée du prêt-En mois] = "validité 31/08/2010 attent date débloc ?"
   OR [Durée du prêt-En mois] = "jusqu'au 30/11/2010"
   OR [Durée du prêt-En mois] = "validité 31/03/2010"
   OR [Durée du prêt-En mois] = "validité 31/01/2010"
   OR [Durée du prêt-En mois] = "jusqu'au 30/06/2010"
   OR [Durée du prêt-En mois] = "30/06/2009"
   OR [Durée du prêt-En mois] = "30/04/2009"
   OR [Durée du prêt-En mois] = "31/03/2009"
   OR [Durée du prêt-En mois] = "31/08/2012 dt 4 mois"
   OR [Durée du prêt-En mois] = "(prêt) 8 ans dont 1 et (leasing) 5 ans"
   OR [Durée du prêt-En mois] = "jusqu'au 31/07/2011"
   OR [Durée du prêt-En mois] = "jusqu'au 30/11/2010";

-- Transformation information from "Date 1ère échéance" to "Observation"
UPDATE [Arrêté Comptable]
SET [Observations ou modalités commission GPP après signature] = [Observations ou modalités commission GPP après signature] & "   Échéances en capital-Date 1ère échéance: " & [Échéances en capital-Date 1ère échéance] 
WHERE [Échéances en capital-Date 1ère échéance] = "OC"
   OR [Échéances en capital-Date 1ère échéance] = "en attente TA modificatif"
   OR [Échéances en capital-Date 1ère échéance] = "ok"
   OR [Échéances en capital-Date 1ère échéance] = "ok" 
   OR [Échéances en capital-Date 1ère échéance] = "reçu 10122009"
   OR [Échéances en capital-Date 1ère échéance] = "att nv TA"
   OR [Échéances en capital-Date 1ère échéance] = "pas TA reçu"
   OR [Échéances en capital-Date 1ère échéance] = "mail 11/02/10";

-- Remove irregular data in "Date 1ère échéance"
UPDATE [Arrêté Comptable]
SET [Échéances en capital-Date 1ère échéance] = ""
WHERE [Échéances en capital-Date 1ère échéance] = "OC"
   OR [Échéances en capital-Date 1ère échéance] = "en attente TA modificatif"
   OR [Échéances en capital-Date 1ère échéance] = "ok"
   OR [Échéances en capital-Date 1ère échéance] = "ok"
   OR [Échéances en capital-Date 1ère échéance] = "reçu 10122009"
   OR [Échéances en capital-Date 1ère échéance] = "att nv TA"
   OR [Échéances en capital-Date 1ère échéance] = "pas TA reçu"
   OR [Échéances en capital-Date 1ère échéance] = "mail 11/02/10";

-- Transformation of the column “TA transmis à DBO”’s format
UPDATE [Arrêté Comptable]
SET [TA transmis à DBO] = Format([TA transmis à DBO],"dd/mm/yyyy");

-- Correct "TA transmis à DBO"'s format
ALTER TABLE [Arrêté Comptable]
ALTER COLUMN [TA transmis à DBO] Date;

-- Correct "N°Tiers Bénéficiaire Primaire"'s format
ALTER TABLE [Arrêté Comptable]
ALTER COLUMN [N°Tiers Bénéficiaire Primaire] Numeric;

-- Correct "Durée du prêt-En mois"'s format
ALTER TABLE [Arrêté Comptable]
ALTER COLUMN [Durée du prêt-En mois] Numeric;

-- Transformation of the column “Échéances en capital-Date 1ère échéance”’s format
UPDATE [Arrêté Comptable]
SET [Échéances en capital-Date 1ère échéance] = Format([Échéances en capital-Date 1ère échéance],"dd/mm/yyyy");

-- Correct "Échéances en capital-Date 1ère échéance"'s format
ALTER TABLE [Arrêté Comptable]
ALTER COLUMN [Échéances en capital-Date 1ère échéance] Date;

