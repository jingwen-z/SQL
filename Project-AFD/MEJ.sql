-- Remove the columns
ALTER TABLE MEJ
DROP COLUMN [Impayés-Date du 1er impayé survenu], [DBO-Date de saisie comptable], [DBO-Montant de l'avance comptabilisée en €], [DBO-Ecart GAR - DBO], [DBO-Commentaires], [DBO-N° MEJ DBO Compta], [DBO-Contrôle 1er niveau];

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

-- Update a date in "Impayés-Date du 1er impayé non régularisé "
UPDATE MEJ
SET  [Impayés-Date du 1er impayé non régularisé] = "01/05/2012"
WHERE [Impayés-Date du 1er impayé non régularisé] = "mai-12";

-- Update "Impayés-Délai respecté "_1
UPDATE MEJ
SET [Impayés-Délai respecté] = IIf(DateDiff("d", [Impayés-Date du 1er impayé non régularisé], [Impayés-Date de l'information des impayés par la banque à l'AFD]) BETWEEN 0 AND 60, "OK", "NOK");

-- Update "Impayés-Délai respecté"_2
UPDATE MEJ
SET [Impayés-Délai respecté] = ""
WHERE [Impayés-Date du 1er impayé non régularisé] IS NULL
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

-- Correct 'MEJ $'_ImportErrors-Date de demande d'avance 
UPDATE MEJ
SET [MEJ-Date de demande d'avance] = ""
WHERE [MEJ-Date de demande d'avance] = "-";