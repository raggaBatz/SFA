USE PROYECTO_FINAL_BD
GO
CREATE PROCEDURE [dbo].[spi_ARTICULO]
    @NOMBRE AS varchar(100),
    @PRECIO AS decimal(20,5),
    @ESTADO AS char(1),
    @FECHACREACION AS datetime,
    @FECHAMODIFICACION AS datetime

AS BEGIN
    DECLARE @FilasInsertadas TABLE (Id int)
    INSERT INTO [ARTICULO]
    (
        [NOMBRE],
        [PRECIO],
        [ESTADO],
        [FECHA_CREACION],
        [FECHA_MODIFICACION]
    )
    OUTPUT	INSERTED.ID_ARTICULO
    INTO	@FilasInsertadas
    VALUES
    (
        @NOMBRE,
        @PRECIO,
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
CREATE PROCEDURE [dbo].[spu_ARTICULO]
    @IDARTICULO AS int,
    @NOMBRE AS varchar(100),
    @PRECIO AS decimal(20,5),
    @ESTADO AS char(1),
    @FECHACREACION AS datetime,
    @FECHAMODIFICACION AS datetime
AS BEGIN

   UPDATE
        [ARTICULO]   SET

        [NOMBRE] = @NOMBRE,
        [PRECIO] = @PRECIO,
        [ESTADO] = @ESTADO,
        [FECHA_CREACION] = @FECHACREACION,
        [FECHA_MODIFICACION] = @FECHAMODIFICACION
   WHERE
        [ID_ARTICULO] = @IDARTICULO 

END
GO
CREATE PROCEDURE [dbo].[spd_ARTICULO]
    @IDARTICULO AS int
AS BEGIN

    DELETE FROM
        [ARTICULO]
    WHERE
        [ID_ARTICULO] = @IDARTICULO 

END
GO
CREATE PROCEDURE [dbo].[spc_ARTICULO]
    @IDARTICULO AS int = NULL,
    @NOMBRE AS varchar(100) = NULL,
    @PRECIO AS decimal(20,5) = NULL,
    @ESTADO AS char(1) = NULL,
    @FECHACREACION AS datetime = NULL,
    @FECHAMODIFICACION AS datetime = NULL
AS BEGIN

    SELECT
        [ID_ARTICULO] ,
        [NOMBRE] ,
        [PRECIO] ,
        [ESTADO] ,
        [FECHA_CREACION] ,
        [FECHA_MODIFICACION] 
    FROM
        [ARTICULO]
    WHERE
isnull(@IDARTICULO,isnull(ID_ARTICULO,0)) = isnull(ID_ARTICULO,0) AND
isnull(@NOMBRE,isnull(NOMBRE,'')) = isnull(NOMBRE,'') AND
isnull(@PRECIO,isnull(PRECIO,0)) = isnull(PRECIO,0) AND
isnull(@ESTADO,isnull(ESTADO,'')) = isnull(ESTADO,'') AND
isnull(@FECHACREACION,isnull(FECHA_CREACION,getdate())) = isnull(FECHA_CREACION,getdate()) AND
isnull(@FECHAMODIFICACION,isnull(FECHA_MODIFICACION,getdate())) = isnull(FECHA_MODIFICACION,getdate()) 

END
GO

CREATE PROCEDURE [dbo].[spg_ARTICULO]
AS BEGIN

    SELECT
        [ID_ARTICULO] ,
        [NOMBRE] ,
        [PRECIO] ,
        [ESTADO] ,
        [FECHA_CREACION] ,
        [FECHA_MODIFICACION] 
    FROM
        [ARTICULO]
    WHERE
		[ESTADO] = 1
END
GO