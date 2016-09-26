-- MEJ-Update "Impayés-Date du 1er impayé survenu"
UPDATE MEJ 
SET [Impayés-Date du 1er impayé survenu] = "01/11/2013"
WHERE [Impayés-Date du 1er impayé survenu] = "nov.-13";

-- MEJ-Standardization of "Impayés-Date du 1er impayé survenu"'s format
UPDATE MEJ 
SET [Impayés-Date du 1er impayé survenu] = Format([Impayés-Date du 1er impayé survenu],"dd/mm/yyyy");

-- MEJ-Update "Impayés-Date de l'information des impayés par la banque à l'AFD"
UPDATE MEJ 
SET [Impayés-Date de l'information des impayés par la banque à l'AFD] = "02/10/2006"
WHERE [Impayés-Date de l'information des impayés par la banque à l'AFD] = "07/05/2006-02/10/2006";

-- MEJ-Standardization of "Impayés-Date de l'information des impayés par la banque à l'AFD"'s format
UPDATE MEJ 
SET [Impayés-Date de l'information des impayés par la banque à l'AFD] = Format([Impayés-Date de l'information des impayés par la banque à l'AFD],"dd/mm/yyyy");

-- MEJ-Update a value in "Date de signature"
UPDATE MEJ 
SET [Date de signature] = "07/09/2005"
WHERE [N° concours & Bénéficiaire Final] = "CSN120901_CFIA Sénégal";

-- MEJ-Update "Nombre d'années entre date de signature et demande d'avance"
UPDATE MEJ 
SET [Nombre d'années entre date de signature et demande d'avance] = DateDiff("yyyy",[Date de signature],[MEJ-Date de demande d'avance])
WHERE [Nombre d'années entre date de signature et demande d'avance] = "#VALUE!";
