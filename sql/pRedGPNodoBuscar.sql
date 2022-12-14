USE [Coiron]
GO
/****** Object:  StoredProcedure [dbo].[pRedGPNodoBuscar]    Script Date: 22/4/2022 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[pRedGPNodoBuscar]  
				@IdNodo int, 
				@Descripcion varchar (1000)
AS
BEGIN
	
	set @Descripcion = '%' + @Descripcion + '%' 

	select IdNodo, Descripcion = descripcion +  (case P.NroDocumento when '' then '' when null then null else ' (' + NroDocumento + ')' end), Valor 
	from RedGPNodo R inner join Persona P 
		on R.IdNodo = P.IdPersona
	where (R.IdNodo = @IdNodo or @IdNodo = 0) 
		AND (
			 (R.Descripcion COLLATE Modern_Spanish_CI_AI) LIKE @Descripcion
			or 
			(P.NroDocumento like @Descripcion)
			)
	order by Descripcion asc 
END

