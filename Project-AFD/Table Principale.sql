-- Remove empty columns
ALTER TABLE [Table Principale]
DROP COLUMN F55, F56, F57, F58, F59, F60, F61, F62, F63, F64, F65, F66, F67, F68, F69, 
            F70, F71, F72, F73, F74, F75, F76, F77, F78, F79, F80, F81, F82, F83, F84, 
            F85, F86, F87, F88, F89, F90, F91, F92, F93, F94, F95, F96, F97, F98, F99, 
            F100, F101, F102, F103, F104, F105, F106, F107, F108, F109, F110, F111, 
            F112, F113, F114, F115, F116, F117, F118, F119, F120, F121, F122, F123, 
            F124, F125, F126, F127, F128, F129, F130, F131, F132, F133, F134, F135, 
            F136, F137, F138, F139, F140, F141, F142, F143, F144, F145, F146, F147, 
            F148, F149, F150, F151, F152, F153, F154, F155, F156, F157, F158, F159, 
            F160, F161, F162, F163, F164, F165, F166, F167, F168, F169, F170, F171, 
            F172, F173, F174, F175, F176, F177, F178, F179, F180, F181, F182, F183, 
            F184, F185, F186, F187, F188, F189, F190, F191, F192, F193, F194, F195, 
            F196, F197, F198, F199, F200, F201, F202, F203, F204, F205, F206, F207, 
            F208, F209, F210, F211, F212, F213, F214, F215, F216, F217, F218, F219, 
            F220, F221, F222, F223, F224, F225, F226, F227, F228, F229, F230, F231, 
            F232, F233, F234, F235, F236, F237, F238, F239, F240, F241, F242, F243, 
            F244, F245, F246, F247, F248, F249, F250, F251, F252, F253, F254, F255;

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
