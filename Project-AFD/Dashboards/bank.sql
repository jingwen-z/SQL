-- Conformité
SELECT [ENTITE], [Réf Avis CPC] AS [Dernier avis CPC], [Risque Pays], [Date dernière MAJ lab par GAR] AS [Dernière maj diligences LAB]
FROM Banques
WHERE [ENTITE RESPONSABLE COTATION (Pays si agence OU Siège)] = "COTE D'IVOIRE";

-- Eligibilité financière
SELECT [ENTITE], [Type Eligibilité] AS [Eligibilité Fin], [Date fin validité éligibilité] AS [Validité], [Watch list et restrictions] AS [Vigilance]
FROM Banques
WHERE [ENTITE RESPONSABLE COTATION (Pays si agence OU Siège)] = "COTE D'IVOIRE";
