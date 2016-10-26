-- Remove empty rows
DELETE *
FROM Banques
WHERE ENTITE IS NULL;

-- Update “Date fin validité éligibilité”
UPDATE Banques 
SET [Date fin validité éligibilité] = ""
WHERE [Arrêté des comptes utilisés pour cotation] IS NULL;

-- Creation of a new column “GO/Remarque”
ALTER TABLE Banques
ADD COLUMN [GO/Remarque] Text;

 
-- the field “Date transmission DPC au GO”
-- Standardization of a value in the field "Date transmission DPC au GO"
UPDATE Banques 
SET [Date transmission DPC au GO] = "Dématérialisé 25/08/2016"
WHERE [Date transmission DPC au GO] = "25/08/2016 Dématérialisé";

-- Separation of the column “Date transmission DPC au GO”
UPDATE Banques
SET [GO/Remarque] = Left([Date transmission DPC au GO],(Instr([Date transmission DPC au GO]," ")-1)), 
    [Date transmission DPC au GO] = Mid([Date transmission DPC au GO],(InStr([Date transmission DPC au GO]," ")+1));

-- Concatenation of “Date transmission DPC” and “GO/Rq”
UPDATE Banques
SET [GO/Remarque] = [GO/Remarque] & " " & [Date transmission DPC au GO]
WHERE ENTITE = "STANDARD BANK SOUTH AFRICA"
       OR ENTITE = "FTB"
       OR ENTITE = "MUCODEC"
       OR ENTITE = "BNDA"
       OR ENTITE = "MCB Ltd"
       OR ENTITE = "Banque de Kigali";

-- Update “Date transmission DPC” after the concatenation
UPDATE Banques
SET [Date transmission DPC au GO] = " "
WHERE ENTITE = "STANDARD BANK SOUTH AFRICA"
       OR ENTITE = "FTB"
       OR ENTITE = "MUCODEC"
       OR ENTITE = "BNDA"
       OR ENTITE = "MCB Ltd"
       OR ENTITE = "Banque de Kigali";
 
-- Copying and pasting partially of a row (BOA Ouganda)
INSERT INTO Banques ( [ENTITE RESPONSABLE COTATION (Pays si agence OU Siège)], ENTITE, [Eligibilité DRC], [Notation Bque + origine notation], [Arrêté des comptes utilisés pour cotation], [Date fin validité éligibilité], [Facturation commission éligibilité 2015], [Encours existant au 30/09/2015], [Type Eligibilité], [Watch list et restrictions], [Conclusions DRC], [Réf Avis CPC], [Recommandations de CPC], [Risque Pays], [Date dernière MAJ lab par GAR], [Actualisation Dossier LAB en cas de mise en jeu], Commentaires, Chaff )
SELECT [ENTITE RESPONSABLE COTATION (Pays si agence OU Siège)], [ENTITE], [Eligibilité DRC], [Notation Bque + origine notation], [Arrêté des comptes utilisés pour cotation], [Date fin validité éligibilité], [Facturation commission éligibilité 2015], [Encours existant au 30/09/2015], [Type Eligibilité], [Watch list et restrictions], [Conclusions DRC], [Réf Avis CPC], [Recommandations de CPC], [Risque Pays], [Date dernière MAJ lab par GAR], [Actualisation Dossier LAB en cas de mise en jeu], [Commentaires], [Chaff]
FROM Banques
WHERE [Date transmission DPC au GO]="05/08/2011 + MAJ 22/09/2014";

-- Update the new row (BOA Ouganda bis)
UPDATE Banques
SET [Date transmission DPC au GO] = "22/09/2014", [GO/Remarque] = "AFR (MAJ)"
WHERE ENTITE = "BOA Ouganda" AND [Date transmission DPC au GO] IS NULL;

-- Update the original row (BOA Ouganda)
UPDATE Banques
SET [Date transmission DPC au GO] = "05/08/2011"
WHERE [ENTITE] = "BOA Ouganda" AND [GO/Remarque] = "AFR";

-- Update the column “Date transmission DPC”
UPDATE Banques
SET [Date transmission DPC au GO] = Trim([Date transmission DPC au GO]);

-- Transformation of the column “Date transmission DPC”’s format
UPDATE Banques
SET [Date transmission DPC au GO] = Format([Date transmission DPC au GO],"dd/mm/yyyy");

-- Correct "Date transmission DPC au GO"'s format
ALTER TABLE Banques
ALTER COLUMN [Date transmission DPC au GO] Date;


-- Creation of a new column “Date d’Avis CPC”
ALTER TABLE Banques
ADD COLUMN [Date d'Avis CPC] Text;

-- The field “Date et réf Avis CPC”
-- Update the column “Date d’Avis CPC”
UPDATE Banques
SET [Date d'Avis CPC] = Mid([Réf Avis CPC],InStr([Réf Avis CPC],"du ")+3)
WHERE InStr([Réf Avis CPC],"du ")<>0;

-- Update the column “Réf Avis CPC”
UPDATE Banques
SET [Réf Avis CPC] = Left([Réf Avis CPC],InStr([Réf Avis CPC],"du ")-2);

-- Creation of a column “Réf Avis CPC complémentaire”
ALTER TABLE Banques
ADD COLUMN [Réf Avis CPC complémentaire] Text;

-- Moving additional information of “Réf Avis CPC”
UPDATE Banques
SET [Réf Avis CPC complémentaire] = Mid([Date d'Avis CPC],InStr([Date d'Avis CPC]," "));

-- Adding information into the column “Réf Avis CPC”
UPDATE Banques
SET [Réf Avis CPC] = [Réf Avis CPC] & [Réf Avis CPC complémentaire ];

-- Removing the field “Réf Avis CPC complémentaire”
ALTER TABLE Banques
DROP COLUMN [Réf Avis CPC complémentaire];
 
-- Only keep the date in “Date d'Avis CPC”
UPDATE Banques
SET [Date d'Avis CPC] = Left([Date d'Avis CPC], InStr([Date d'Avis CPC],  " ")-1)
WHERE InStr([Date d'Avis CPC],  " ") <> 0;
 
-- Transformation of the column “Date d'Avis CPC”’s format
UPDATE Banques
SET [Date d'Avis CPC] = Format([Date d'Avis CPC], "dd/mm/yyyy");

-- Correct "Date d'Avis CPC"'s format
ALTER TABLE Banques
ALTER COLUMN [Date d'Avis CPC] Date;
 
-- Removing the superfluous date in “Date dernière MAJ lab par GAR”
UPDATE Banques
SET [Date dernière MAJ lab par GAR] = "01/10/2012"
WHERE ENTITE = "BIO sa";

-- Removing the remark in “Date dernière MAJ lab par GAR ”
UPDATE Banques
SET [Date dernière MAJ lab par GAR] = "13/05/2014"
WHERE ENTITE = "BOA Niger";

-- Transformation of the column “Date dernière MAJ lab par GAR”’s format
UPDATE Banques
SET [Date dernière MAJ lab par GAR ] = Format([Date dernière MAJ lab par GAR ], "dd/mm/yyyy");

-- Correct "Date dernière MAJ lab par GAR"'s format
ALTER TABLE Banques
ALTER COLUMN [Date dernière MAJ lab par GAR] Date;

-- Movement of comment
UPDATE Banques
SET [Commentaires] = Mid([Actualisation Dossier LAB en cas de mise en jeu],InStr([Actualisation Dossier LAB en cas de mise en jeu],": ")+2)
WHERE [ENTITE]="ALIOS FINANCE GABON / SOGACA";
 
 -- Keep the date in "Actualisation Dossier LAB en cas de mise en jeu"
SELECT Left([Actualisation Dossier LAB en cas de mise en jeu],InStr([Actualisation Dossier LAB en cas de mise en jeu],": ")-1)
FROM Banques
WHERE [ENTITE]="ALIOS FINANCE GABON / SOGACA";
 
-- Transformation of the column “Date transmission DPC”’s format 
UPDATE Banques
SET [Actualisation Dossier LAB en cas de mise en jeu] = Format([Actualisation Dossier LAB en cas de mise en jeu ], "dd/mm/yyyy");

-- Correct "Actualisation Dossier LAB en cas de mise en jeu"'s format
ALTER TABLE Banques
ALTER COLUMN [Actualisation Dossier LAB en cas de mise en jeu] Date;
 
-- Standardization of spelling in the field "Type Eligibilité"
UPDATE Banques
SET [Type Eligibilité] = "Non Eligible"
WHERE [Type Eligibilité] = "Non éligible";
 
-- Correction of spelling in the field "Risque Pays"
UPDATE Banques
SET [Risque Pays] = "très élevé"
WHERE [Risque Pays] = "très élévé";

-- Create a column "RESPONSABLE & ENTITE"
ALTER TABLE Banques
ADD COLUMN [RESPONSABLE & ENTITE] Text; 

-- Assign values in "RESPONSABLE & ENTITE"
UPDATE Banques 
SET [RESPONSABLE & ENTITE] = [ENTITE RESPONSABLE COTATION (Pays si agence OU Siège)] & "_" & [ENTITE];

-- Update particular "RESPONSABLE & ENTITE"
UPDATE Banques SET [RESPONSABLE & ENTITE] = "OUGANDA_BOA Ouganda(MAJ)"
WHERE [RESPONSABLE & ENTITE] = "OUGANDA_BOA Ouganda"
  AND [GO/Remarque] = "AFR (MAJ)";

-- Determine a primary key
ALTER TABLE [Banques]
ADD PRIMARY KEY ([RESPONSABLE & ENTITE ]);
