-- Remove the columns
ALTER TABLE MEJ
DROP COLUMN [Impayés-Date du 1er impayé survenu], [Nombre d'années écoulé entre date de signature et demande d'avan], [Nombre de jours entre date de demande paiement GAR et date paiem], [DBO-Date de saisie comptable], [DBO-Montant de l'avance comptabilisée en €], [DBO-Ecart GAR - DBO], [DBO-Commentaires], [DBO-N° MEJ DBO Compta], [DBO-Contrôle 1er niveau];

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
