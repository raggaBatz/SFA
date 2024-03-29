USE PROYECTO_FINAL_BD
GO
CREATE PROCEDURE [dbo].[spi_CLIENTE]
    @PRIMERNOMBRE AS varchar(100),
    @SEGUNDONOMBRE AS varchar(100),
    @TERCERNOMBRE AS varchar(100),
    @PRIMERAPELLIDO AS varchar(100),
    @SEGUNDOAPELLIDO AS varchar(100),
    @APELLIDOCASADA AS varchar(100),
    @GENERO AS varchar(15),
    @DIRECCIONRESIDENCIA AS varchar(200),
    @DEPARTAMENTO AS varchar(50),
    @MUNICIPIO AS varchar(50),
    @ESTADO AS char(1),
    @FECHACREACION AS datetime,
    @FECHAMODIFICACION AS datetime

AS BEGIN
    DECLARE @FilasInsertadas TABLE (Id int)
    INSERT INTO [CLIENTE]
    (
        [PRIMER_NOMBRE],
        [SEGUNDO_NOMBRE],
        [TERCER_NOMBRE],
        [PRIMER_APELLIDO],
        [SEGUNDO_APELLIDO],
        [APELLIDO_CASADA],
        [GENERO],
        [DIRECCION_RESIDENCIA],
        [DEPARTAMENTO],
        [MUNICIPIO],
        [ESTADO],
        [FECHA_CREACION],
        [FECHA_MODIFICACION]
    )
    OUTPUT	INSERTED.ID_CLIENTE
    INTO	@FilasInsertadas
    VALUES
    (
        @PRIMERNOMBRE,
        @SEGUNDONOMBRE,
        @TERCERNOMBRE,
        @PRIMERAPELLIDO,
        @SEGUNDOAPELLIDO,
        @APELLIDOCASADA,
        @GENERO,
        @DIRECCIONRESIDENCIA,
        @DEPARTAMENTO,
        @MUNICIPIO,
        @ESTADO,
        @FECHACREACION,
        @FECHAMODIFICACION
    )
    SELECT TOP 1
        Id
    FROM
        @FilasInsertadas


END
GO

CREATE PROCEDURE [dbo].[spu_CLIENTE]
    @IDCLIENTE AS int,
    @PRIMERNOMBRE AS varchar(100),
    @SEGUNDONOMBRE AS varchar(100),
    @TERCERNOMBRE AS varchar(100),
    @PRIMERAPELLIDO AS varchar(100),
    @SEGUNDOAPELLIDO AS varchar(100),
    @APELLIDOCASADA AS varchar(100),
    @GENERO AS varchar(15),
    @DIRECCIONRESIDENCIA AS varchar(200),
    @DEPARTAMENTO AS varchar(50),
    @MUNICIPIO AS varchar(50),
    @ESTADO AS char(1),
    @FECHACREACION AS datetime,
    @FECHAMODIFICACION AS datetime
AS BEGIN

   UPDATE
        [CLIENTE]   SET

        [PRIMER_NOMBRE] = @PRIMERNOMBRE,
        [SEGUNDO_NOMBRE] = @SEGUNDONOMBRE,
        [TERCER_NOMBRE] = @TERCERNOMBRE,
        [PRIMER_APELLIDO] = @PRIMERAPELLIDO,
        [SEGUNDO_APELLIDO] = @SEGUNDOAPELLIDO,
        [APELLIDO_CASADA] = @APELLIDOCASADA,
        [GENERO] = @GENERO,
        [DIRECCION_RESIDENCIA] = @DIRECCIONRESIDENCIA,
        [DEPARTAMENTO] = @DEPARTAMENTO,
        [MUNICIPIO] = @MUNICIPIO,
        [ESTADO] = @ESTADO,
        [FECHA_CREACION] = @FECHACREACION,
        [FECHA_MODIFICACION] = @FECHAMODIFICACION
   WHERE
        [ID_CLIENTE] = @IDCLIENTE 

END
GO

CREATE PROCEDURE [dbo].[spd_CLIENTE]
    @IDCLIENTE AS int
AS BEGIN

    DELETE FROM
        [CLIENTE]
    WHERE
        [ID_CLIENTE] = @IDCLIENTE 

END
GO

CREATE PROCEDURE [dbo].[spc_CLIENTE]
    @IDCLIENTE AS int = NULL,
    @PRIMERNOMBRE AS varchar(100) = NULL,
    @SEGUNDONOMBRE AS varchar(100) = NULL,
    @TERCERNOMBRE AS varchar(100) = NULL,
    @PRIMERAPELLIDO AS varchar(100) = NULL,
    @SEGUNDOAPELLIDO AS varchar(100) = NULL,
    @APELLIDOCASADA AS varchar(100) = NULL,
    @GENERO AS varchar(15) = NULL,
    @DIRECCIONRESIDENCIA AS varchar(200) = NULL,
    @DEPARTAMENTO AS varchar(50) = NULL,
    @MUNICIPIO AS varchar(50) = NULL,
    @ESTADO AS char(1) = NULL,
    @FECHACREACION AS datetime = NULL,
    @FECHAMODIFICACION AS datetime = NULL
AS BEGIN

    SELECT
        [ID_CLIENTE] ,
        [PRIMER_NOMBRE] ,
        [SEGUNDO_NOMBRE] ,
        [TERCER_NOMBRE] ,
        [PRIMER_APELLIDO] ,
        [SEGUNDO_APELLIDO] ,
        [APELLIDO_CASADA] ,
        [GENERO] ,
        [DIRECCION_RESIDENCIA] ,
        [DEPARTAMENTO] ,
        [MUNICIPIO] ,
        [ESTADO] ,
        [FECHA_CREACION] ,
        [FECHA_MODIFICACION] 
    FROM
        [CLIENTE]
    WHERE
isnull(@IDCLIENTE,isnull(ID_CLIENTE,0)) = isnull(ID_CLIENTE,0) AND
isnull(@PRIMERNOMBRE,isnull(PRIMER_NOMBRE,'')) = isnull(PRIMER_NOMBRE,'') AND
isnull(@SEGUNDONOMBRE,isnull(SEGUNDO_NOMBRE,'')) = isnull(SEGUNDO_NOMBRE,'') AND
isnull(@TERCERNOMBRE,isnull(TERCER_NOMBRE,'')) = isnull(TERCER_NOMBRE,'') AND
isnull(@PRIMERAPELLIDO,isnull(PRIMER_APELLIDO,'')) = isnull(PRIMER_APELLIDO,'') AND
isnull(@SEGUNDOAPELLIDO,isnull(SEGUNDO_APELLIDO,'')) = isnull(SEGUNDO_APELLIDO,'') AND
isnull(@APELLIDOCASADA,isnull(APELLIDO_CASADA,'')) = isnull(APELLIDO_CASADA,'') AND
isnull(@GENERO,isnull(GENERO,'')) = isnull(GENERO,'') AND
isnull(@DIRECCIONRESIDENCIA,isnull(DIRECCION_RESIDENCIA,'')) = isnull(DIRECCION_RESIDENCIA,'') AND
isnull(@DEPARTAMENTO,isnull(DEPARTAMENTO,'')) = isnull(DEPARTAMENTO,'') AND
isnull(@MUNICIPIO,isnull(MUNICIPIO,'')) = isnull(MUNICIPIO,'') AND
isnull(@ESTADO,isnull(ESTADO,'')) = isnull(ESTADO,'') AND
isnull(@FECHACREACION,isnull(FECHA_CREACION,getdate())) = isnull(FECHA_CREACION,getdate()) AND
isnull(@FECHAMODIFICACION,isnull(FECHA_MODIFICACION,getdate())) = isnull(FECHA_MODIFICACION,getdate()) 

END
GO


CREATE FUNCTION  [dbo].[GET_NOMBRE_CLIENTE](@IDCLIENTE AS int = NULL)
RETURNS VARCHAR(200)
BEGIN
    RETURN(SELECT 
		COALESCE([PRIMER_NOMBRE] + ' ','') +
		COALESCE([SEGUNDO_NOMBRE] + ' ','') +
		COALESCE([TERCER_NOMBRE] + ' ','') +
		COALESCE([PRIMER_APELLIDO] + ' ','') +
		COALESCE([SEGUNDO_APELLIDO] + ' ','')
	FROM [dbo].[CLIENTE] WHERE [CLIENTE].[ID_CLIENTE] = @IDCLIENTE)
END
GO


