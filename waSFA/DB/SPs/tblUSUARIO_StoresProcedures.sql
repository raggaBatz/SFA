USE PROYECTO_FINAL_BD
GO
CREATE PROCEDURE [dbo].[spi_USUARIO]
    @IDEMPLEADO AS int,
    @LOGIN AS varchar(50),
    @PASSWORD AS varchar(50),
    @ESTADO AS char(1),
    @FECHACREACION AS datetime,
    @FECHAMODIFICACION AS datetime

AS BEGIN
    DECLARE @FilasInsertadas TABLE (Id int)

    INSERT INTO [USUARIO]
    (
        [ID_EMPLEADO],
        [LOGIN],
        [PASSWORD],
        [ESTADO],
        [FECHA_CREACION],
        [FECHA_MODIFICACION]
    )
    OUTPUT	INSERTED.ID_USUARIO
    INTO	@FilasInsertadas
    VALUES
    (
        @IDEMPLEADO,
        @LOGIN,
        @PASSWORD,
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

CREATE PROCEDURE [dbo].[spu_USUARIO]
    @IDUSUARIO AS int,
    @IDEMPLEADO AS int,
    @LOGIN AS varchar(50),
    @PASSWORD AS varchar(50),
    @ESTADO AS char(1),
    @FECHACREACION AS datetime,
    @FECHAMODIFICACION AS datetime
AS BEGIN

   UPDATE
        [USUARIO]   SET

        [ID_EMPLEADO] = @IDEMPLEADO,
        [LOGIN] = @LOGIN,
        [PASSWORD] = @PASSWORD,
        [ESTADO] = @ESTADO,
        [FECHA_CREACION] = @FECHACREACION,
        [FECHA_MODIFICACION] = @FECHAMODIFICACION
   WHERE
        [ID_USUARIO] = @IDUSUARIO 

END
GO

CREATE PROCEDURE [dbo].[spd_USUARIO]
    @IDUSUARIO AS int
AS BEGIN

    DELETE FROM
        [USUARIO]
    WHERE
        [ID_USUARIO] = @IDUSUARIO 

END
GO

CREATE PROCEDURE [dbo].[spc_USUARIO]
    @IDUSUARIO AS int = NULL,
    @IDEMPLEADO AS int = NULL,
    @LOGIN AS varchar(50) = NULL,
    @PASSWORD AS varchar(50) = NULL,
    @ESTADO AS char(1) = NULL,
    @FECHACREACION AS datetime = NULL,
    @FECHAMODIFICACION AS datetime = NULL
AS BEGIN

    SELECT
        [ID_USUARIO] ,
        [ID_EMPLEADO] ,
        [LOGIN] ,
        [PASSWORD] ,
        [ESTADO] ,
        [FECHA_CREACION] ,
        [FECHA_MODIFICACION] 
    FROM
        [USUARIO]
    WHERE
isnull(@IDUSUARIO,isnull(ID_USUARIO,0)) = isnull(ID_USUARIO,0) AND
isnull(@IDEMPLEADO,isnull(ID_EMPLEADO,0)) = isnull(ID_EMPLEADO,0) AND
isnull(@LOGIN,isnull(LOGIN,'')) = isnull(LOGIN,'') AND
isnull(@PASSWORD,isnull(PASSWORD,'')) = isnull(PASSWORD,'') AND
isnull(@ESTADO,isnull(ESTADO,'')) = isnull(ESTADO,'') AND
isnull(@FECHACREACION,isnull(FECHA_CREACION,getdate())) = isnull(FECHA_CREACION,getdate()) AND
isnull(@FECHAMODIFICACION,isnull(FECHA_MODIFICACION,getdate())) = isnull(FECHA_MODIFICACION,getdate()) 

END
GO
CREATE PROCEDURE [dbo].[spc_USUARIO_LOGIN]
    @LOGIN AS varchar(50) = NULL,
    @PASSWORD AS varchar(50) = NULL
AS BEGIN

    SELECT
        [ID_USUARIO] ,
        [USUARIO].[ID_EMPLEADO]
    FROM
        [USUARIO]
	INNER JOIN 
		[EMPLEADO] ON [EMPLEADO].[ESTADO] = 1
    WHERE
isnull(@LOGIN,isnull(LOGIN,'')) = isnull(LOGIN,'') AND
isnull(@PASSWORD,isnull(PASSWORD,'')) = isnull(PASSWORD,'')
END
GO


