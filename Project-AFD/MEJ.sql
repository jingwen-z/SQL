-- Remove the empty lines
DELETE *
FROM MEJ
WHERE [N° concours] IS NULL;

-- Update the column "DI-Différence sur l'assiette de garantie de la MEJ"
UPDATE MEJ
SET [DI-Différence sur l'assiette de garantie de la MEJ] = [DI-Perte provisoire calculée par la banque en devise] - [DI-Perte provisoire accordée par l'AFD en devise];

-- Update the column "Solde-Délai respecté "
UPDATE MEJ
SET [Solde-Délai respecté] = " "
WHERE [Solde-Délai respecté] = "N/A";

-- Update the column "Solde-Date de paiement (accord GAR à DBO)"
UPDATE MEJ
SET [Solde-Date de paiement (accord GAR à DBO)] = " "
WHERE [Solde-Date de paiement (accord GAR à DBO)] = "N/A";

-- Update the column "Solde-Date de paiement DBO (swift)"
UPDATE MEJ 
SET [Solde-Date de paiement DBO (swift)] = " "
WHERE [Solde-Date de paiement DBO (swift)] = "N/A";

-- Update a date in the field "Impayés-Date du 1er impayé survenu"_10
UPDATE MEJ 
SET [Impayés-Date du 1er impayé survenu] = "01/05/2010"
WHERE [Impayés-Date du 1er impayé survenu] = "mai-10";

-- Update a date in the field "Impayés-Date du 1er impayé survenu"_11
UPDATE MEJ 
SET [Impayés-Date du 1er impayé survenu] = "01/02/2011"
WHERE [Impayés-Date du 1er impayé survenu] = "févr.-11";

-- Update a date in "Impayés-Date du 1er impayé non régularisé "
UPDATE MEJ
SET  [Impayés-Date du 1er impayé non régularisé] = "01/05/2012"
WHERE [Impayés-Date du 1er impayé non régularisé] = "mai-12";

-- Standardization of "Impayés-Date du 1er impayé non régularisé"'s format
UPDATE MEJ
SET [Impayés-Date du 1er impayé non régularisé] = Format([Impayés-Date du 1er impayé non régularisé], "dd/mm/yyyy");

-- Correct "Impayés-Date du 1er impayé non régularisé"'s format
ALTER TABLE MEJ
ALTER COLUMN [Impayés-Date du 1er impayé non régularisé] Date;

-- Update "Impayés-Délai respecté"_1
UPDATE MEJ
SET [Impayés-Délai respecté] = IIf(DateDiff("d", [Impayés-Date du 1er impayé survenu], [Impayés-Date de l'information des impayés par la banque à l'AFD]) BETWEEN 0 AND 60, "OK", "NOK");

-- Update "Impayés-Délai respecté"_2
UPDATE MEJ
SET [Impayés-Délai respecté] = ""
WHERE [Impayés-Date du 1er impayé survenu] IS NULL 
   OR [Impayés-Date de l'information des impayés par la banque à l'AFD] IS NULL;

-- Update "Solde-Rappel date limite de paiement du solde"
UPDATE MEJ
SET [Solde-Rappel date limite de paiement du solde] = IIf( [Avance-Date de paiement DBO (swift)]<>"déchéance", DateAdd("w",1096,[Avance-Date de paiement DBO (swift)]), "" );

-- Transformation of the format of “Solde-Date de demande du solde” and "Solde-Rappel date limite de paiement du solde"
UPDATE MEJ
SET [Solde-Date de demande du solde] = Format( [Solde-Date de demande du solde], "dd/mm/yyyy" ), 
        [Solde-Rappel date limite de paiement du solde] = Format( [Solde-Rappel date limite de paiement du solde], "dd/mm/yyyy" );

-- Update "Solde-Délai respecté"_1
UPDATE MEJ
SET [Solde-Délai respecté] = IIf([Solde-Date de demande du solde] < [Solde-Rappel date limite de paiement du solde],"OK","NOK");

-- Update "Solde-Délai respecté"_2
UPDATE MEJ
SET [Solde-Délai respecté ] = ""
WHERE [Solde-Date de demande du solde] IS NULL
       OR [Solde-Rappel date limite de paiement du solde] IS NULL;

-- Standardization of "Date de signature"'s format
UPDATE MEJ
SET [Date de signature] = Format([Date de signature], "dd/mm/yyyy");

-- Correct 'MEJ $'_ImportErrors-Date de demande d'avance 
UPDATE MEJ
SET [MEJ-Date de demande d'avance] = ""
WHERE [MEJ-Date de demande d'avance] = "-";

-- Correct "MEJ-Date de demande d'avance"'s format
ALTER TABLE MEJ
ALTER COLUMN [MEJ-Date de demande d'avance] Date;

-- Update the column "Nombre d'années entre date de signature et demande d'avance"_1
UPDATE MEJ
SET [Nombre d'années entre date de signature et demande d'avance] = DateDiff("yyyy",[Date de signature],[MEJ-Date de demande d'avance]);

-- Update the column "Nombre d'années entre date de signature et demande d'avance"_2
UPDATE MEJ
SET [Nombre d'années entre date de signature et demande d'avance] = ""
WHERE [Date de signature] IS NULL
        OR [MEJ-Date de demande d'avance] IS NULL ;

-- Update the column "Nombre de mois écoulé entre dossier complet et fin instruction"
UPDATE MEJ
SET [Nombre de mois écoulé entre dossier complet et fin instruction] = DateDiff("m", [MEJ-Date à laquelle le dossier est complet], [MEJ-Date fin instruction]);

-- Update the column "Nombre de jours écoulé entre fin d'instruction et visa JUR"
UPDATE MEJ
SET [Nombre de jours écoulé entre fin d'instruction et visa JUR] = DateDiff("d",[MEJ-Date fin instruction],[MEJ-Date visa JUR]);

-- Update the column "Nombre de jours écoulé entre visa JUR et décision GAR"
UPDATE MEJ
SET [Nombre de jours écoulé entre visa JUR et décision GAR] = DateDiff("d", [MEJ-Date visa JUR], [MEJ-Date décision GAR]);

-- Update the column "MEJ-Délai respecté"_1
UPDATE MEJ
SET [MEJ-Délai respecté] = IIf( DateDiff("d",[EG-Date décheance du terme],[MEJ-Date de demande d'avance]) < 360, "OK", "NOK"  );

-- Update the column "MEJ-Délai respecté"_2
UPDATE MEJ
SET [MEJ-Délai respecté] = ""
WHERE [EG-Date décheance du terme] IS NULL
        OR [MEJ-Date de demande d'avance] IS NULL;

-- Update the column "Nombre de jours entre demande paiement GAR et paiement DBO"
UPDATE MEJ
SET [Nombre de jours entre demande paiement GAR et paiement DBO] = DateDiff("d",[Avance-Date de paiement (accord GAR à DBO)],[Avance-Date de paiement DBO (swift)]);

-- Standardization of "Avance-Date de paiement (accord GAR à DBO)"'s format
UPDATE MEJ
SET [Avance-Date de paiement (accord GAR à DBO)] = Format([Avance-Date de paiement (accord GAR à DBO)], "dd/mm/yyyy");

-- Standardization of "Avance-Date de paiement DBO (swift)"'s format
UPDATE MEJ
SET [Avance-Date de paiement DBO (swift)] = Format([Avance-Date de paiement DBO (swift)], "dd/mm/yyyy");

-- Standardization of "Solde-Date de paiement (accord GAR à DBO)"'s format
UPDATE MEJ
SET [Solde-Date de paiement (accord GAR à DBO)] = Format([Solde-Date de paiement (accord GAR à DBO)], "dd/mm/yyyy");

-- Standardization of "Solde-Date de paiement DBO (swift)"'s format
UPDATE MEJ
SET [Solde-Date de paiement DBO (swift)] = Format([Solde-Date de paiement DBO (swift)], "dd/mm/yyyy");

-- Update the column "DBO-Ecart GAR – DBO"
UPDATE MEJ
SET [DBO-Ecart GAR - DBO] = [Avance-Montant de l'avance en €] - [DBO-Montant de l'avance comptabilisée en €];

-- Creation of a new column “DBO-Contrôle 1er niveau-Contrôleur”
ALTER TABLE MEJ
ADD COLUMN [DBO-Contrôle 1er niveau-Contrôleur] Text;

-- Creation of a new column “DBO-Contrôle 1er niveau-Date”
ALTER TABLE MEJ
ADD COLUMN [DBO-Contrôle 1er niveau-Date] Date;

-- Change the fields' order « DBO-Contrôle 1er niveau-Contrôleur » and « DBO-Contrôle 1er niveau-Date » by hand (Mode Création) 

-- Update a value of "DBO-Contrôle 1er niveau"
UPDATE MEJ
SET [DBO-Contrôle 1er niveau] = "OK - AP - 03/06/2016"
WHERE [DBO-Contrôle 1er niveau] = "OK - AP - 030616";

-- Fill the field "DBO-Contrôle 1er niveau-Contrôleur"
UPDATE MEJ
SET [DBO-Contrôle 1er niveau-Contrôleur] = Mid([DBO-Contrôle 1er niveau],(InStr([DBO-Contrôle 1er niveau],"A")), 2);

-- Fill the field "DBO-Contrôle 1er niveau-Date"
UPDATE MEJ
SET [DBO-Contrôle 1er niveau-Date] = IIf( Mid([DBO-Contrôle 1er niveau],(InStr([DBO-Contrôle 1er niveau],"P") + 3), 1) = " ", Mid([DBO-Contrôle 1er niveau],(InStr([DBO-Contrôle 1er niveau],"P") + 4)), Mid([DBO-Contrôle 1er niveau],(InStr([DBO-Contrôle 1er niveau],"P") + 2)) );

-- Standardization of "DBO-Contrôle 1er niveau-Date"'s format
UPDATE MEJ
SET [DBO-Contrôle 1er niveau-Date] = Format([DBO-Contrôle 1er niveau-Date], "dd/mm/yyyy");

-- Rename the field "DBO-Contrôle 1er niveau" by hand (Mode Création) : "DBO-Contrôle 1er niveau-Statu"

-- Update the field "DBO-Contrôle 1er niveau-Statu"
UPDATE MEJ
SET [DBO-Contrôle 1er niveau-statu] = Left([DBO-Contrôle 1er niveau-statu], 2);
