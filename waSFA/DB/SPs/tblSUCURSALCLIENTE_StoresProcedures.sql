USE PROYECTO_FINAL_BD
GO
CREATE PROCEDURE [dbo].[spi_SUCURSAL_CLIENTE]
    @IDCLIENTE AS int,
    @IDSUCURSAL AS int,
    @ESTADO AS char(1),
    @FECHACREACION AS datetime,
    @FECHAMODIFICACION AS datetime

AS BEGIN

    DECLARE @FilasInsertadas TABLE (Id int)

    INSERT INTO [SUCURSAL_CLIENTE]
    (
        [ID_CLIENTE],
        [ID_SUCURSAL],
        [ESTADO],
        [FECHA_CREACION],
        [FECHA_MODIFICACION]
    )
    OUTPUT	INSERTED.ID_SUCURSAL_CLIENTE
    INTO	@FilasInsertadas
    VALUES
    (
        @IDCLIENTE,
        @IDSUCURSAL,
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

CREATE PROCEDURE [dbo].[spu_SUCURSAL_CLIENTE]
    @IDSUCURSALCLIENTE AS int,
    @IDCLIENTE AS int,
    @IDSUCURSAL AS int,
    @ESTADO AS char(1),
    @FECHACREACION AS datetime,
    @FECHAMODIFICACION AS datetime
AS BEGIN

   UPDATE
        [SUCURSAL_CLIENTE]   SET

        [ID_CLIENTE] = @IDCLIENTE,
        [ID_SUCURSAL] = @IDSUCURSAL,
        [ESTADO] = @ESTADO,
        [FECHA_CREACION] = @FECHACREACION,
        [FECHA_MODIFICACION] = @FECHAMODIFICACION
   WHERE
        [ID_SUCURSAL_CLIENTE] = @IDSUCURSALCLIENTE 

END
GO
CREATE PROCEDURE [dbo].[spd_SUCURSAL_CLIENTE]
    @IDSUCURSALCLIENTE AS int
AS BEGIN

    DELETE FROM
        [SUCURSAL_CLIENTE]
    WHERE
        [ID_SUCURSAL_CLIENTE] = @IDSUCURSALCLIENTE 

END
GO

CREATE PROCEDURE [dbo].[spc_SUCURSAL_CLIENTE]
    @IDSUCURSALCLIENTE AS int = NULL,
    @IDCLIENTE AS int = NULL,
    @IDSUCURSAL AS int = NULL,
    @ESTADO AS char(1) = NULL,
    @FECHACREACION AS datetime = NULL,
    @FECHAMODIFICACION AS datetime = NULL
AS BEGIN

    SELECT
        [ID_SUCURSAL_CLIENTE] ,
        [ID_CLIENTE] ,
        [ID_SUCURSAL] ,
        [ESTADO] ,
        [FECHA_CREACION] ,
        [FECHA_MODIFICACION] 
    FROM
        [SUCURSAL_CLIENTE]
    WHERE
isnull(@IDSUCURSALCLIENTE,isnull(ID_SUCURSAL_CLIENTE,0)) = isnull(ID_SUCURSAL_CLIENTE,0) AND
isnull(@IDCLIENTE,isnull(ID_CLIENTE,0)) = isnull(ID_CLIENTE,0) AND
isnull(@IDSUCURSAL,isnull(ID_SUCURSAL,0)) = isnull(ID_SUCURSAL,0) AND
isnull(@ESTADO,isnull(ESTADO,'')) = isnull(ESTADO,'') AND
isnull(@FECHACREACION,isnull(FECHA_CREACION,getdate())) = isnull(FECHA_CREACION,getdate()) AND
isnull(@FECHAMODIFICACION,isnull(FECHA_MODIFICACION,getdate())) = isnull(FECHA_MODIFICACION,getdate()) 

END
GO

CREATE PROCEDURE [dbo].[spc_CLIENTE_X_SUCURSAL]
    @IDSUCURSAL AS int = NULL
AS BEGIN
    SELECT
        [SUCURSAL_CLIENTE].[ID_CLIENTE],
        dbo.GET_NOMBRE_CLIENTE([CLIENTE].[ID_CLIENTE]) AS 'NOMBRE'
    FROM
        [SUCURSAL_CLIENTE]
	INNER JOIN 
		[CLIENTE] 
		ON [SUCURSAL_CLIENTE].[ID_CLIENTE] = [CLIENTE].[ID_CLIENTE]  
    WHERE
		isnull(@IDSUCURSAL,isnull(ID_SUCURSAL,0)) = isnull(ID_SUCURSAL,0)
		AND CLIENTE.ESTADO = 1
END
GO

