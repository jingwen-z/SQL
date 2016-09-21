-- Remove empty rows
DELETE *
FROM [Table Principale]
WHERE [N° concours] IS NULL;

-- Update repeated "N° concours"
UPDATE [Table Principale]
SET [N° concours] = [N° concours] & "-" & Right([Année d'octroi],2)
WHERE [N° concours] = "CCM116901"
   OR [N° concours] = "CCM117601"
   OR [N° concours] = "CCM132901"
   OR [N° concours] = "CGA110701"
   OR [N° concours] = "CGH108001"
   OR [N° concours] = "CMG118901"
   OR [N° concours] = "CMG119201";
   
-- Determine the primary key
ALTER TABLE  [Table Principale]
ADD PRIMARY KEY ([N° concours]);

-- Update the colomn "dont femmes"
UPDATE [Table Principale]
SET [dont femmes] = " "
WHERE [dont femmes] = "non";

-- Remove the faux values in "Durée du prêt-En mois"
UPDATE [Table Principale]
SET [Durée du prêt-En mois] = ""
WHERE [Durée du prêt-En mois] = "15/06/2017"
   OR [Durée du prêt-En mois] = "30/09/2010"
   OR [Durée du prêt-En mois] = "30/04/2010"
   OR [Durée du prêt-En mois] = "28/02/2010";

-- Correct a value in "TA transmis à DBO"
UPDATE [Table Principale]
SET [TA transmis à DBO] = "16/09/2013"
WHERE [TA transmis à DBO] = "30/04/2013-16/09/2013";

-- Standardization of spelling in the column "Durée du prêt-En mois"
UPDATE [Table Principale]
SET [Durée du prêt-En mois] = "jusqu'au 30/06/2010"
WHERE [N° concours] = "CMG131601";

-- Transformation information from "En mois" to "Observation"
UPDATE [Table Principale]
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
   OR [Durée du prêt-En mois] = "Min 93 et Max 99 mois";

-- Remove irregular data in "En mois"
UPDATE [Table Principale]
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
   OR [Durée du prêt-En mois] = "Min 93 et Max 99 mois";

-- Transformation information from "Dont différé en mois" to "Observation"
UPDATE [Table Principale]
SET [Observations ou modalités commission GPP après signature] = [Observations ou modalités commission GPP après signature] & "   Durée du prêt-Dont différé en mois: " & [Durée du prêt-Dont différé en mois] 
WHERE [Durée du prêt-Dont différé en mois] = "entre 9 et 15 mois";

-- Remove irregular data in "Dont différé en mois"
UPDATE [Table Principale]
SET [Durée du prêt-Dont différé en mois] = ""
WHERE [Durée du prêt-Dont différé en mois] = "entre 9 et 15 mois";

-- Transformation information from "Date 1ère échéance" to "Observation"
UPDATE [Table Principale]
SET [Observations ou modalités commission GPP après signature] = [Observations ou modalités commission GPP après signature] & "   Échéances en capital-Date 1ère échéance: " & [Échéances en capital-Date 1ère échéance] 
WHERE [Échéances en capital-Date 1ère échéance] = "OC"
   OR [Échéances en capital-Date 1ère échéance] = "en attente TA modificatif"
   OR [Échéances en capital-Date 1ère échéance] = "ok"
   OR [Échéances en capital-Date 1ère échéance] = "reçu 10122009"
   OR [Échéances en capital-Date 1ère échéance] = "att nv TA"
   OR [Échéances en capital-Date 1ère échéance] = "pas TA reçu"
   OR [Échéances en capital-Date 1ère échéance] = "mail 11/02/10";

-- Remove irregular data in "Date 1ère échéance"
UPDATE [Table Principale]
SET [Échéances en capital-Date 1ère échéance] = ""
WHERE [Échéances en capital-Date 1ère échéance] = "OC"
   OR [Échéances en capital-Date 1ère échéance] = "en attente TA modificatif"
   OR [Échéances en capital-Date 1ère échéance] = "ok"
   OR [Échéances en capital-Date 1ère échéance] = "reçu 10122009"
   OR [Échéances en capital-Date 1ère échéance] = "att nv TA"
   OR [Échéances en capital-Date 1ère échéance] = "pas TA reçu"
   OR [Échéances en capital-Date 1ère échéance] = "mail 11/02/10";

-- Transformation of the column “TA transmis à DBO”’s format
UPDATE [Table Principale]
SET [TA transmis à DBO] = Format([TA transmis à DBO],"dd/mm/yyyy");

-- Correct "TA transmis à DBO"'s format
--ALTER TABLE [Table Principale]
--ALTER COLUMN [TA transmis à DBO] Date;

-- Correction of "N° Béné Primaire"
UPDATE [Table Principale] 
SET [N°Tiers Bénéficiaire Primaire] = "6571"
WHERE [Bénéficiaire Primaire] = "SGBC"
  AND [N°Tiers Bénéficiaire Primaire] = "510934";
  
-- Update "Echéances en capital"_1
UPDATE [Table Principale]
SET [Échéances en capital-Date 1ère échéance] = "01/07/2010", [Échéances en capital-Date dernière échéance] = "01/06/2012"
WHERE [Échéances en capital-Date 1ère échéance] = "juillet-10";

-- Update "Echéances en capital"_2
UPDATE [Table Principale]
SET [Échéances en capital-Date 1ère échéance] = "01/01/2017", [Échéances en capital-Date dernière échéance] = "01/06/2027"
WHERE [Échéances en capital-Date 1ère échéance] = "janv.-17";

-- Purification of "Nb Emplois existants" & "Emplois existants+créés"
UPDATE [Table Principale]
SET [Nb Emplois existants] = "", [Emplois existants+créés] = ""
WHERE [Nb Emplois existants] = "att info"
   OR [Nb Emplois existants] = "en attente"
   OR [Nb Emplois existants] = "NC";

-- Purification of "dont femmes"
UPDATE [Table Principale]
SET [dont femmes] = ""
WHERE [dont femmes] = "oui";

-- Correct "N°Tiers Bénéficiaire Primaire"'s format
ALTER TABLE [Table Principale]
ALTER COLUMN [N°Tiers Bénéficiaire Primaire] Numeric;

-- Correct "Durée du prêt-En mois"'s format
ALTER TABLE [Table Principale]
ALTER COLUMN [Durée du prêt-En mois] Numeric;

-- Correct "Durée du prêt-Dont différé en mois"'s format
ALTER TABLE [Table Principale]
ALTER COLUMN [Durée du prêt-Dont différé en mois] Numeric;

-- Correct "Nb Emplois existants"'s format
ALTER TABLE [Table Principale]
ALTER COLUMN [Nb Emplois existants] Numeric;

-- Correct "Emplois existants+créés"'s format
ALTER TABLE [Table Principale]
ALTER COLUMN [Emplois existants+créés] Numeric;

-- Correct "dont femmes"'s format
ALTER TABLE [Table Principale]
ALTER COLUMN [dont femmes] Numeric;

-- Transformation of the column “Taux commission”’s format
UPDATE [Table Principale]
SET [Taux commission] = Format([Taux commission],"Percent");

-- Correct "Taux commission"'s format
ALTER TABLE [Table Principale]
ALTER COLUMN [Taux commission] Numeric;

