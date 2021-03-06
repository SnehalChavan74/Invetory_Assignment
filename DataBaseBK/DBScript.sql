USE [ThinkbridgeDB]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 02-04-2021 14:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[InventoryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
	[HSNCode] [nvarchar](50) NULL,
 CONSTRAINT [PK_Inventory] PRIMARY KEY CLUSTERED 
(
	[InventoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InventoryDetails]    Script Date: 02-04-2021 14:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryDetails](
	[InvnetoryDetailsId] [int] IDENTITY(1,1) NOT NULL,
	[InventroyId] [int] NULL,
	[Name] [nvarchar](50) NULL,
	[Quantity] [decimal](18, 2) NULL,
	[price] [decimal](18, 2) NULL,
 CONSTRAINT [PK_InventoryDetails] PRIMARY KEY CLUSTERED 
(
	[InvnetoryDetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Item_Master]    Script Date: 02-04-2021 14:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Item_Master](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Price] [decimal](18, 2) NULL,
	[Quantity] [decimal](18, 2) NULL,
	[Discount] [decimal](18, 2) NULL,
	[TotalAmount] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Item_Master] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[InventoryDetails]  WITH CHECK ADD  CONSTRAINT [FK_InventoryDetails_Inventory1] FOREIGN KEY([InventroyId])
REFERENCES [dbo].[Inventory] ([InventoryId])
GO
ALTER TABLE [dbo].[InventoryDetails] CHECK CONSTRAINT [FK_InventoryDetails_Inventory1]
GO
/****** Object:  StoredProcedure [dbo].[InventoryDelete]    Script Date: 02-04-2021 14:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[InventoryDelete]
(
@InventoryId int

)
AS 
BEGIN
SET NOCOUNT ON;
DECLARE @IdReturn int

	DELETE  FROM Inventory where InventoryId=@InventoryId

							
					
						


SET @IdReturn =CAST(SCOPE_IDENTITY() AS INT) 


select @IdReturn  as InventoryId
END
GO
/****** Object:  StoredProcedure [dbo].[InventoryDetailsItemDelete]    Script Date: 02-04-2021 14:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[InventoryDetailsItemDelete]
(

@InventroyId	int	

		
)
AS 
BEGIN
SET NOCOUNT ON;
DECLARE @IdReturn int

DELETE  FROM InventoryDetails where InventroyId=@InventroyId
						
							
					

SET @IdReturn =CAST(SCOPE_IDENTITY() AS INT) 


select @IdReturn  as InventroyId
END
GO
/****** Object:  StoredProcedure [dbo].[InventoryDetailsItemInsert]    Script Date: 02-04-2021 14:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[InventoryDetailsItemInsert]
(

@InventroyId	int	,
@Name	nvarchar(50)	,
@Quantity	decimal(18, 2)	,
@price	decimal(18, 2)	
		
)
AS 
BEGIN
SET NOCOUNT ON;
DECLARE @IdReturn int

INSERT INTO InventoryDetails(InventroyId,
						Name, 
						Quantity, 
						price 
						
							 )
					VALUES(
					@InventroyId,
						@Name, 
						@Quantity, 
						@price )

SET @IdReturn =CAST(SCOPE_IDENTITY() AS INT) 


select @IdReturn  as InventroyId
END
GO
/****** Object:  StoredProcedure [dbo].[InventoryDetailsItemUpdate]    Script Date: 02-04-2021 14:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[InventoryDetailsItemUpdate]
(

@InventroyId	int	,
@Name	nvarchar(50)	,
@Quantity	decimal(18, 2)	,
@price	decimal(18, 2)	
		
)
AS 
BEGIN
SET NOCOUNT ON;
DECLARE @IdReturn int

UPDATE InventoryDetails SET Name=@Name, Quantity=@Quantity, price =@price where InventroyId=@InventroyId
						
							
					

SET @IdReturn =CAST(SCOPE_IDENTITY() AS INT) 


select @IdReturn  as InventroyId
END
GO
/****** Object:  StoredProcedure [dbo].[InventoryInsert]    Script Date: 02-04-2021 14:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[InventoryInsert]
(
@Name nvarchar(50),
@Date date,
@HSNCode nvarchar(50)
)
AS 
BEGIN
SET NOCOUNT ON;
DECLARE @IdReturn int

INSERT INTO Inventory( Name,
						Date,
						HSNCode

							)
					VALUES(@Name,
						@Date,
						@HSNCode
)

SET @IdReturn =CAST(SCOPE_IDENTITY() AS INT) 


select @IdReturn  as InventoryId
END
GO
/****** Object:  StoredProcedure [dbo].[InventoryUpdate]    Script Date: 02-04-2021 14:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[InventoryUpdate]
(
@InventoryId int,
@Name nvarchar(50),
@Date date,
@HSNCode nvarchar(50)
)
AS 
BEGIN
SET NOCOUNT ON;
DECLARE @IdReturn int

	UPDATE  Inventory SET Name=@Name,Date=@Date,HSNCode=@HSNCode where InventoryId=@InventoryId

							
					
						


SET @IdReturn =CAST(SCOPE_IDENTITY() AS INT) 


select @IdReturn  as InventoryId
END
GO
/****** Object:  StoredProcedure [dbo].[SaveItem]    Script Date: 02-04-2021 14:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Proc [dbo].[SaveItem]
(

@Name	nvarchar(50)	,
@Price	decimal(18, 2)	,
@Quantity	decimal(18, 2)	,
@Discount	decimal(18, 2)	,
@TotalAmount	decimal(18, 2)	
		
)
AS
BEGIN
INSERT INTO Item_Master(
Name		,
Price		,
Quantity	,
Discount	,
TotalAmount		
)
VALUES(
@Name		,
@Price		,
@Quantity	,
@Discount	,
@TotalAmount
)
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_InventoryUpdate]    Script Date: 02-04-2021 14:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[Sp_InventoryUpdate]
(
    @InvnetoryDetailsId int,
@InventroyId	int	,
@Name	nvarchar(50)	,
@Quantity	decimal(18, 2)	,
@price	decimal(18, 2)	,
@IdReturn INT OUTPUT
)
AS
BEGIN
    IF @InventroyId = 'update' BEGIN

        SET NOCOUNT ON;

        SELECT @IdReturn AS SCOPE_IDENTITY

        UPDATE InventoryDetails
         SET InventroyId=@InventroyId,Name=@Name, Quantity=@Quantity, price =@price
		 
        WHERE InvnetoryDetailsId = @IdReturn
    END

END
GO
/****** Object:  StoredProcedure [dbo].[updateitem]    Script Date: 02-04-2021 14:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create Proc [dbo].[updateitem]
(
@id int,
@Name	nvarchar(50)	,
@Price	decimal(18, 2)	,
@Quantity	decimal(18, 2)	,
@Discount	decimal(18, 2)	,
@TotalAmount	decimal(18, 2)	
		
)
AS
BEGIN
update  Item_Master set Name=@Name,Price=@Price	,Quantity=@Quantity	,Discount=@Discount	,TotalAmount	=@TotalAmount	
where id=@id

END
GO
