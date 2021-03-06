USE [master]
GO
/****** Object:  Database [FinalProject]    Script Date: 2021/9/16 下午 03:51:51 ******/
CREATE DATABASE [FinalProject]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FinalProject', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\FinalProject.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FinalProject_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\FinalProject_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [FinalProject] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FinalProject].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FinalProject] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FinalProject] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FinalProject] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FinalProject] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FinalProject] SET ARITHABORT OFF 
GO
ALTER DATABASE [FinalProject] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FinalProject] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FinalProject] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FinalProject] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FinalProject] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FinalProject] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FinalProject] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FinalProject] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FinalProject] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FinalProject] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FinalProject] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FinalProject] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FinalProject] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FinalProject] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FinalProject] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FinalProject] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FinalProject] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FinalProject] SET RECOVERY FULL 
GO
ALTER DATABASE [FinalProject] SET  MULTI_USER 
GO
ALTER DATABASE [FinalProject] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FinalProject] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FinalProject] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FinalProject] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FinalProject] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [FinalProject] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'FinalProject', N'ON'
GO
ALTER DATABASE [FinalProject] SET QUERY_STORE = OFF
GO
USE [FinalProject]
GO
/****** Object:  UserDefinedFunction [dbo].[getChainsEmployeeID]    Script Date: 2021/9/16 下午 03:51:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Jeff HUANG>
-- Create date: <Create Date, 20210812>
-- Description:	<Description, Chains Employee ID Maker>
-- =============================================
CREATE FUNCTION [dbo].[getChainsEmployeeID]()

RETURNS varchar(10)
AS
BEGIN
	DECLARE @employeeID varchar(20)
    DECLARE @date varchar(20)

	SELECT @date = CONVERT(varchar(4), GETDATE(), 112)
	SELECT @employeeID = @date + '-' + RIGHT('000' + RTRIM(ISNULL(MAX(CAST(RIGHT(c.EmployeeID, 4) AS int)), 0) + 1), 4)
    FROM ChainsEmployees c
    WHERE LEFT( c.EmployeeID, 4 ) = @date

    RETURN @employeeID

END
GO
/****** Object:  UserDefinedFunction [dbo].[getCustomerOrderNo]    Script Date: 2021/9/16 下午 03:51:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Jeff HUANG>
-- Create date: <Create Date, 20210812>
-- Description:	<Description, Customer OrderID Maker>
-- =============================================
CREATE FUNCTION [dbo].[getCustomerOrderNo]()

RETURNS varchar(20)
AS
BEGIN
	DECLARE @orderNo varchar(20)
    DECLARE @date varchar(20)

	SELECT @date = CONVERT(varchar(8), GETDATE(), 112)
	SELECT @orderNo = @date + '-' + RIGHT('00' + RTRIM(ISNULL(MAX(CAST(RIGHT(c.OrderNo, 3) AS int)), 0) + 1), 3)
    FROM CustomerOrders c
    WHERE LEFT( c.OrderNo, 8 ) = @date

    RETURN @orderNo

END
GO
/****** Object:  UserDefinedFunction [dbo].[getHeadquartersEmployeeID]    Script Date: 2021/9/16 下午 03:51:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Jeff HUANG>
-- Create date: <Create Date, 20210812>
-- Description:	<Description, Customer OrderID Maker>
-- =============================================
CREATE FUNCTION [dbo].[getHeadquartersEmployeeID]()

RETURNS varchar(10)
AS
BEGIN
	DECLARE @employeeID varchar(20)
    DECLARE @date varchar(20)

	SELECT @date = CONVERT(varchar(4), GETDATE(), 112)
	SELECT @employeeID = @date + '-' + RIGHT('000' + RTRIM(ISNULL(MAX(CAST(RIGHT(h.EmployeeID, 4) AS int)), 0) + 1), 4)
    FROM HeadquartersEmployees h
    WHERE LEFT( h.EmployeeID, 4 ) = @date

    RETURN @employeeID

END
GO
/****** Object:  UserDefinedFunction [dbo].[getLogisticsOrderNo]    Script Date: 2021/9/16 下午 03:51:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Jeff HUANG>
-- Create date: <Create Date, 20210812>
-- Description:	<Description, Logistics OrderID Maker>
-- =============================================
CREATE FUNCTION [dbo].[getLogisticsOrderNo]()

RETURNS varchar(20)
AS
BEGIN
	DECLARE @LNo varchar(20)
    DECLARE @date varchar(20)

	SELECT @date = 'L' + CONVERT(varchar(8), GETDATE(), 112)
	SELECT @LNo = @date + '-' + RIGHT('00' + RTRIM(ISNULL(MAX(CAST(RIGHT(l.LNo, 3) AS int)), 0) + 1), 3)
    FROM LogisticsOrders l
    WHERE LEFT( l.LNo, 9 ) = @date

    RETURN @LNo

END
GO
/****** Object:  UserDefinedFunction [dbo].[getSalesOrderNo]    Script Date: 2021/9/16 下午 03:51:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Jeff HUANG>
-- Create date: <Create Date, 20210812>
-- Description:	<Description, Sales Order SNo Maker>
-- =============================================
CREATE FUNCTION [dbo].[getSalesOrderNo]()

RETURNS varchar(20)
AS
BEGIN
	DECLARE @SNo varchar(20)
    DECLARE @date varchar(20)

	SELECT @date = 'S' + CONVERT(varchar(8), GETDATE(), 112)
	SELECT @SNo = @date + '-' + RIGHT('00' + RTRIM(ISNULL(MAX(CAST(RIGHT(s.SNo, 3) AS int)), 0) + 1), 3)
    FROM SalesOrders s
    WHERE LEFT( s.SNo, 9 ) = @date

    RETURN @SNo

END
GO
/****** Object:  UserDefinedFunction [dbo].[getWarehouseOrderNo]    Script Date: 2021/9/16 下午 03:51:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Jeff HUANG>
-- Create date: <Create Date, 20210812>
-- Description:	<Description, Warehouse Order WNo Maker>
-- =============================================
CREATE FUNCTION [dbo].[getWarehouseOrderNo]()

RETURNS varchar(20)
AS
BEGIN
	DECLARE @WNo varchar(20)
    DECLARE @date varchar(20)

	SELECT @date = 'W' + CONVERT(varchar(8), GETDATE(), 112)
	SELECT @WNo = @date + '-' + RIGHT('00' + RTRIM(ISNULL(MAX(CAST(RIGHT(W.WNo, 3) AS int)), 0) + 1), 3)
    FROM WarehouseOrders w
    WHERE LEFT( w.WNo, 9 ) = @date

    RETURN @WNo

END
GO
/****** Object:  Table [dbo].[ChainsEmployees]    Script Date: 2021/9/16 下午 03:51:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChainsEmployees](
	[EmployeeID] [nvarchar](50) NOT NULL,
	[EmployeeName] [nvarchar](50) NOT NULL,
	[EmployeePhone] [nvarchar](50) NOT NULL,
	[BranchNo] [nvarchar](50) NOT NULL,
	[Account] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[ActGUID] [uniqueidentifier] NULL,
	[ActTime] [datetime] NULL,
 CONSTRAINT [PK_ChainsEmployees] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerOrderDetails]    Script Date: 2021/9/16 下午 03:51:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerOrderDetails](
	[OrderNo] [varchar](20) NOT NULL,
	[ItemNo] [varchar](10) NOT NULL,
	[ItemCount] [int] NOT NULL,
	[ItemPrice] [int] NOT NULL,
	[WetherStock] [varchar](1) NULL,
	[Remark] [varchar](500) NULL,
 CONSTRAINT [PK_CustomerOrderDetails] PRIMARY KEY CLUSTERED 
(
	[OrderNo] ASC,
	[ItemNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerOrders]    Script Date: 2021/9/16 下午 03:51:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerOrders](
	[OrderNo] [varchar](20) NOT NULL,
	[OrderEmployeeID] [varchar](10) NOT NULL,
	[OrderBranch] [varchar](10) NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[PreShipmentDate] [datetime] NULL,
	[ShipmentDate] [datetime] NULL,
	[ArriveDate] [datetime] NULL,
	[Remark] [varchar](500) NULL,
	[OrderStatus] [int] NULL,
 CONSTRAINT [PK_CustomOrder] PRIMARY KEY CLUSTERED 
(
	[OrderNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HeadquartersEmployees]    Script Date: 2021/9/16 下午 03:51:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HeadquartersEmployees](
	[EmployeeID] [nvarchar](10) NOT NULL,
	[EmployeeName] [nvarchar](50) NOT NULL,
	[EmployeeAccount] [nvarchar](50) NOT NULL,
	[EmployeePassword] [nvarchar](50) NOT NULL,
	[Department] [nvarchar](50) NULL,
	[Section] [nvarchar](5) NULL,
	[EmployeeLevel] [nvarchar](1) NOT NULL,
	[EmployeePhone] [nvarchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Items]    Script Date: 2021/9/16 下午 03:51:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Items](
	[ItemNo] [varchar](10) NOT NULL,
	[Category] [int] NOT NULL,
	[ItemName] [varchar](50) NOT NULL,
	[StockCount] [int] NOT NULL,
	[ItemPrice] [int] NOT NULL,
 CONSTRAINT [PK_Goods] PRIMARY KEY CLUSTERED 
(
	[ItemNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesOrders]    Script Date: 2021/9/16 下午 03:51:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesOrders](
	[SNo] [varchar](20) NOT NULL,
	[OrderNo] [varchar](20) NOT NULL,
	[SalesNo] [varchar](10) NOT NULL,
	[SalesProcessDate] [datetime] NOT NULL,
	[SalesCheck] [varchar](1) NULL,
	[SalesManagerNo] [varchar](10) NOT NULL,
	[SalesManagerProcessDate] [datetime] NULL,
	[SalesManagerCheck] [varchar](1) NULL,
	[Remark] [varchar](500) NULL,
 CONSTRAINT [PK_SalesOrders] PRIMARY KEY CLUSTERED 
(
	[SNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WarehouseOrders]    Script Date: 2021/9/16 下午 03:51:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WarehouseOrders](
	[WNo] [varchar](20) NOT NULL,
	[SNo] [varchar](20) NOT NULL,
	[OrderNo] [varchar](20) NOT NULL,
	[WarehouseNo] [varchar](10) NOT NULL,
	[WarehouseProcessDate] [datetime] NOT NULL,
	[WarehouseCheck] [varchar](1) NULL,
	[WarehouseManagerNo] [varchar](10) NOT NULL,
	[WarehouseManagerProcessDate] [datetime] NULL,
	[WarehouseManagerCheck] [varchar](1) NULL,
	[Remark] [varchar](500) NULL,
 CONSTRAINT [PK_WarehouseOrders] PRIMARY KEY CLUSTERED 
(
	[WNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[ChainsEmployees] ([EmployeeID], [EmployeeName], [EmployeePhone], [BranchNo], [Account], [Password], [ActGUID], [ActTime]) VALUES (N'2021-0001', N'北區員工一', N'0222224444', N'N01', N'test01', N'test01test01', N'28198cb8-c87f-4847-a2d3-c85ee6cfcc25', CAST(N'2021-09-15T18:29:55.190' AS DateTime))
GO
INSERT [dbo].[ChainsEmployees] ([EmployeeID], [EmployeeName], [EmployeePhone], [BranchNo], [Account], [Password], [ActGUID], [ActTime]) VALUES (N'2021-0002', N'北區員工二', N'0222224444', N'N01', N'test02', N'test02test02', N'ede829af-abac-4599-8fbb-eeebd38b639e', CAST(N'2021-09-11T15:03:42.383' AS DateTime))
GO
INSERT [dbo].[ChainsEmployees] ([EmployeeID], [EmployeeName], [EmployeePhone], [BranchNo], [Account], [Password], [ActGUID], [ActTime]) VALUES (N'2021-0003', N'南區員工一', N'077778888', N'S01', N'test03', N'test03test03', N'7f09cdc5-b8fd-42e9-9cbb-5fe78b7ffc53', CAST(N'2021-09-15T18:10:46.430' AS DateTime))
GO
INSERT [dbo].[ChainsEmployees] ([EmployeeID], [EmployeeName], [EmployeePhone], [BranchNo], [Account], [Password], [ActGUID], [ActTime]) VALUES (N'2021-0004', N'南區員工二', N'077778888', N'S01', N'test04', N'test04test04', N'f4063dda-9902-4031-a416-b724485ce3f7', CAST(N'2021-09-07T13:23:40.370' AS DateTime))
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210830-001', N'F004', 300, 80, N'Y', N'菜梗少')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210830-001', N'M001', 300, 2000, N'Y', N'新鮮溫體豬')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210830-002', N'S001', 100, 400, N'Y', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210830-002', N'S002', 100, 350, N'Y', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210830-002', N'S003', 100, 350, N'Y', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210830-002', N'S004', 100, 350, N'Y', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210901-001', N'M001', 100, 1500, N'Y', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210901-001', N'M002', 200, 350, N'Y', N'油花多')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210901-001', N'M003', 300, 350, N'Y', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210901-002', N'S001', 100, 500, N'Y', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210901-002', N'S002', 100, 500, N'Y', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210901-002', N'S004', 100, 500, N'Y', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210901-003', N'M001', 100, 1200, NULL, N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210901-003', N'M002', 100, 500, NULL, N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210901-004', N'M001', 100, 1200, NULL, N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210901-005', N'S004', 100, 400, NULL, N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210901-006', N'O001', 200, 50, N'N', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210901-006', N'O002', 200, 50, N'N', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210901-006', N'O003', 200, 50, N'N', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210901-006', N'O004', 200, 50, N'N', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210901-007', N'M003', 350, 800, N'N', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210901-007', N'M004', 200, 500, N'Y', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210902-001', N'F001', 100, 2000, NULL, N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210902-001', N'F002', 100, 80, NULL, N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210903-001', N'F001', 100, 80, N'Y', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210903-001', N'F002', 100, 80, N'Y', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210907-001', N'M001', 100, 500, NULL, N'油花多')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210907-002', N'M001', 100, 500, NULL, N'油花多')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210907-003', N'M001', 100, 500, N'Y', N'油花多')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210907-003', N'M002', 100, 800, N'Y', N'油花多')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210907-004', N'O003', 100, 50, N'N', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210907-004', N'O004', 100, 50, N'N', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210909-001', N'M001', 100, 500, NULL, N'油花多')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210909-001', N'M002', 100, 800, NULL, N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210909-002', N'M001', 50, 500, N'Y', N'油花多')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210909-002', N'M002', 50, 800, N'Y', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210909-003', N'O005', 100, 35, N'Y', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210911-001', N'S001', 100, 400, N'Y', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210911-001', N'S002', 100, 350, N'Y', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210913-001', N'O006', 100, 5, NULL, N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210913-002', N'O006', 100, 5, N'Y', N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210913-003', N'O006', 100, 5, NULL, N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210915-001', N'O006', 100, 5, NULL, N'')
GO
INSERT [dbo].[CustomerOrderDetails] ([OrderNo], [ItemNo], [ItemCount], [ItemPrice], [WetherStock], [Remark]) VALUES (N'20210915-002', N'O006', 100, 5, N'Y', N'')
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210830-001', N'2021-0001', N'N01', CAST(N'2021-08-30T19:48:24.000' AS DateTime), CAST(N'2021-09-06T19:48:24.000' AS DateTime), CAST(N'2021-08-30T21:35:11.427' AS DateTime), CAST(N'2021-08-30T21:40:50.977' AS DateTime), N'分店:狀況1-1/r/n銷售部門:金額過高，下次請注意/r/n倉儲單位:', 1)
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210830-002', N'2021-0002', N'N01', CAST(N'2021-08-30T21:48:17.000' AS DateTime), CAST(N'2021-09-06T21:48:17.000' AS DateTime), CAST(N'2021-08-30T21:50:06.900' AS DateTime), CAST(N'2021-08-30T21:51:25.347' AS DateTime), N'分店:狀況1-2/r/n銷售部門:/r/n倉儲單位:', 1)
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210901-001', N'2021-0003', N'S01', CAST(N'2021-09-01T13:03:05.000' AS DateTime), CAST(N'2021-09-08T13:03:05.000' AS DateTime), CAST(N'2021-09-01T13:05:13.790' AS DateTime), CAST(N'2021-09-01T13:05:35.447' AS DateTime), N'分店:狀況2-1/r/n銷售部門:/r/n倉儲單位:', 1)
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210901-002', N'2021-0004', N'S01', CAST(N'2021-09-01T13:07:39.000' AS DateTime), CAST(N'2021-09-08T13:07:39.000' AS DateTime), CAST(N'2021-09-01T13:14:02.733' AS DateTime), CAST(N'2021-09-01T13:14:15.560' AS DateTime), N'分店:狀況2-2/r/n銷售部門:/r/n倉儲單位:', 1)
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210901-003', N'2021-0001', N'N01', CAST(N'2021-09-01T13:16:40.000' AS DateTime), CAST(N'2021-09-08T13:16:40.000' AS DateTime), NULL, CAST(N'2021-09-01T13:16:45.857' AS DateTime), N'分店:狀況3/r/n', 5)
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210901-004', N'2021-0001', N'N01', CAST(N'2021-09-01T14:40:03.000' AS DateTime), CAST(N'2021-09-08T14:40:03.000' AS DateTime), NULL, CAST(N'2021-09-01T14:44:45.077' AS DateTime), N'分店:狀況4/r/n銷售部門:金額過高，請聯絡銷售人員，再行下單/r/n', 5)
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210901-005', N'2021-0001', N'N01', CAST(N'2021-09-01T15:01:19.000' AS DateTime), CAST(N'2021-09-08T15:01:19.000' AS DateTime), NULL, CAST(N'2021-09-01T15:08:55.877' AS DateTime), N'分店:狀況5/r/n銷售部門:只訂購單一品項，運送成本過高，請增加品項後再行下單/r/n', 5)
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210901-006', N'2021-0001', N'N01', CAST(N'2021-09-01T15:37:09.000' AS DateTime), CAST(N'2021-09-08T15:37:09.000' AS DateTime), NULL, CAST(N'2021-09-01T15:46:17.803' AS DateTime), N'分店:狀況6/r/n銷售部門:/r/n倉儲部門:訂購之商品皆無庫存', 5)
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210901-007', N'2021-0001', N'N01', CAST(N'2021-09-01T16:58:24.000' AS DateTime), CAST(N'2021-09-08T16:58:24.000' AS DateTime), CAST(N'2021-09-01T17:47:26.083' AS DateTime), CAST(N'2021-09-01T17:48:42.190' AS DateTime), N'分店:狀況7/r/n銷售部門:/r/n倉儲單位:', 1)
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210902-001', N'2021-0001', N'N01', CAST(N'2021-09-02T08:04:06.000' AS DateTime), CAST(N'2021-09-09T08:04:06.000' AS DateTime), CAST(N'2021-09-02T12:47:04.290' AS DateTime), CAST(N'2021-09-02T19:23:02.893' AS DateTime), N'分店:Test20210902/r/n', 5)
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210903-001', N'2021-0001', N'N01', CAST(N'2021-09-03T07:52:06.000' AS DateTime), CAST(N'2021-09-10T07:52:06.000' AS DateTime), CAST(N'2021-09-07T11:25:00.950' AS DateTime), CAST(N'2021-09-07T12:03:54.280' AS DateTime), N'分店:20210903_Test/r/n銷售部門:/r/n倉儲單位:', 1)
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210907-001', N'2021-0001', N'N01', CAST(N'2021-09-07T12:03:44.000' AS DateTime), CAST(N'2021-09-14T12:03:44.000' AS DateTime), NULL, CAST(N'2021-09-07T12:04:53.417' AS DateTime), N'分店:20210907_Test/r/n', 5)
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210907-002', N'2021-0001', N'N01', CAST(N'2021-09-07T12:05:25.000' AS DateTime), CAST(N'2021-09-14T12:05:25.000' AS DateTime), NULL, CAST(N'2021-09-07T12:10:17.433' AS DateTime), N'分店:20210907_Test2/r/n銷售部門:下單品項過少，運費過高，請增加訂購品項後，再行下單/r/n', 5)
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210907-003', N'2021-0001', N'N01', CAST(N'2021-09-07T12:13:18.000' AS DateTime), CAST(N'2021-09-14T12:13:18.000' AS DateTime), CAST(N'2021-09-07T12:20:16.880' AS DateTime), CAST(N'2021-09-07T12:20:29.327' AS DateTime), N'分店:20210907_Test3/r/n銷售部門:/r/n倉儲單位:', 1)
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210907-004', N'2021-0004', N'S01', CAST(N'2021-09-07T13:16:09.000' AS DateTime), CAST(N'2021-09-14T13:16:09.000' AS DateTime), CAST(N'2021-09-07T13:17:19.247' AS DateTime), CAST(N'2021-09-07T13:18:32.253' AS DateTime), N'分店:20210907_Test4/r/n銷售部門:/r/n/r/n倉儲部門:訂購之商品皆無庫存', 5)
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210909-001', N'2021-0001', N'N01', CAST(N'2021-09-09T14:46:51.000' AS DateTime), CAST(N'2021-09-16T14:46:51.000' AS DateTime), NULL, CAST(N'2021-09-09T14:47:51.163' AS DateTime), N'分店:Test0909/r/n', 5)
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210909-002', N'2021-0001', N'N01', CAST(N'2021-09-09T14:48:40.000' AS DateTime), CAST(N'2021-09-16T14:48:40.000' AS DateTime), CAST(N'2021-09-09T15:07:30.407' AS DateTime), CAST(N'2021-09-09T15:08:47.563' AS DateTime), N'分店:/r/n銷售部門:此次訂單過大下次請注意/r/n倉儲單位:', 1)
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210909-003', N'2021-0001', N'N01', CAST(N'2021-09-09T17:59:40.000' AS DateTime), CAST(N'2021-09-16T17:59:40.000' AS DateTime), CAST(N'2021-09-09T18:09:22.437' AS DateTime), CAST(N'2021-09-11T14:54:45.877' AS DateTime), N'分店:/r/n銷售部門:/r/n倉儲單位:', 1)
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210911-001', N'2021-0002', N'N01', CAST(N'2021-09-11T15:03:30.000' AS DateTime), CAST(N'2021-09-18T15:03:30.000' AS DateTime), CAST(N'2021-09-15T20:41:04.507' AS DateTime), NULL, N'分店:20210911_Test/r/n銷售部門:/r/n倉儲單位:', 4)
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210913-001', N'2021-0003', N'S01', CAST(N'2021-09-13T22:04:47.000' AS DateTime), CAST(N'2021-09-20T22:04:47.000' AS DateTime), NULL, CAST(N'2021-09-13T22:04:56.817' AS DateTime), N'客戶:/r/n', 5)
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210913-002', N'2021-0003', N'S01', CAST(N'2021-09-13T22:05:05.000' AS DateTime), CAST(N'2021-09-20T22:05:05.000' AS DateTime), CAST(N'2021-09-13T22:07:33.013' AS DateTime), CAST(N'2021-09-13T22:11:33.373' AS DateTime), N'客戶:/r/n銷售部門:OK/r/n倉儲單位:', 1)
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210913-003', N'2021-0003', N'S01', CAST(N'2021-09-13T22:11:58.000' AS DateTime), CAST(N'2021-09-20T22:11:58.000' AS DateTime), NULL, NULL, N'客戶:Test_0913/r/n', 2)
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210915-001', N'2021-0001', N'N01', CAST(N'2021-09-15T15:38:15.000' AS DateTime), CAST(N'2021-09-22T15:38:15.000' AS DateTime), NULL, CAST(N'2021-09-15T15:38:30.210' AS DateTime), N'分店:/r/n', 5)
GO
INSERT [dbo].[CustomerOrders] ([OrderNo], [OrderEmployeeID], [OrderBranch], [OrderDate], [PreShipmentDate], [ShipmentDate], [ArriveDate], [Remark], [OrderStatus]) VALUES (N'20210915-002', N'2021-0001', N'N01', CAST(N'2021-09-15T18:10:58.000' AS DateTime), CAST(N'2021-09-22T18:10:58.000' AS DateTime), CAST(N'2021-09-15T18:12:48.180' AS DateTime), NULL, N'分店:/r/n銷售部門:/r/n倉儲單位:', 4)
GO
INSERT [dbo].[HeadquartersEmployees] ([EmployeeID], [EmployeeName], [EmployeeAccount], [EmployeePassword], [Department], [Section], [EmployeeLevel], [EmployeePhone]) VALUES (N'2021-0001', N'銷北主', N'sales01', N'sales01sales01', N'Sales', N'S01', N'2', N'22222222#001')
GO
INSERT [dbo].[HeadquartersEmployees] ([EmployeeID], [EmployeeName], [EmployeeAccount], [EmployeePassword], [Department], [Section], [EmployeeLevel], [EmployeePhone]) VALUES (N'2021-0008', N'銷北員', N'sales02', N'sales02sales02', N'Sales', N'S01', N'1', N'22222222#002')
GO
INSERT [dbo].[HeadquartersEmployees] ([EmployeeID], [EmployeeName], [EmployeeAccount], [EmployeePassword], [Department], [Section], [EmployeeLevel], [EmployeePhone]) VALUES (N'2021-0002', N'銷南主', N'sales03', N'sales03sales03', N'Sales', N'S02', N'2', N'7777777#001')
GO
INSERT [dbo].[HeadquartersEmployees] ([EmployeeID], [EmployeeName], [EmployeeAccount], [EmployeePassword], [Department], [Section], [EmployeeLevel], [EmployeePhone]) VALUES (N'2021-0009', N'銷南員', N'sales04', N'sales04sales04', N'Sales', N'S02', N'1', N'7777777#003')
GO
INSERT [dbo].[HeadquartersEmployees] ([EmployeeID], [EmployeeName], [EmployeeAccount], [EmployeePassword], [Department], [Section], [EmployeeLevel], [EmployeePhone]) VALUES (N'2021-0003', N'倉北主', N'ware01', N'ware01ware01', N'Warehouse', N'W01', N'2', N'22222222#003')
GO
INSERT [dbo].[HeadquartersEmployees] ([EmployeeID], [EmployeeName], [EmployeeAccount], [EmployeePassword], [Department], [Section], [EmployeeLevel], [EmployeePhone]) VALUES (N'2021-0012', N'倉北員', N'ware02', N'ware02ware02', N'Warehouse', N'W01', N'1', N'22222222#004')
GO
INSERT [dbo].[HeadquartersEmployees] ([EmployeeID], [EmployeeName], [EmployeeAccount], [EmployeePassword], [Department], [Section], [EmployeeLevel], [EmployeePhone]) VALUES (N'2021-0004', N'倉南主', N'ware03', N'ware03ware03', N'Warehouse', N'W02', N'2', N'7777777#003')
GO
INSERT [dbo].[HeadquartersEmployees] ([EmployeeID], [EmployeeName], [EmployeeAccount], [EmployeePassword], [Department], [Section], [EmployeeLevel], [EmployeePhone]) VALUES (N'2021-0011', N'倉南員', N'ware04', N'ware04ware04', N'Warehouse', N'W02', N'1', N'7777777#004')
GO
INSERT [dbo].[Items] ([ItemNo], [Category], [ItemName], [StockCount], [ItemPrice]) VALUES (N'F001', 2, N'小白菜', 1400, 80)
GO
INSERT [dbo].[Items] ([ItemNo], [Category], [ItemName], [StockCount], [ItemPrice]) VALUES (N'F002', 2, N'青江菜', 1900, 80)
GO
INSERT [dbo].[Items] ([ItemNo], [Category], [ItemName], [StockCount], [ItemPrice]) VALUES (N'F003', 2, N'萵苣', 2000, 80)
GO
INSERT [dbo].[Items] ([ItemNo], [Category], [ItemName], [StockCount], [ItemPrice]) VALUES (N'F004', 2, N'高麗菜', 1700, 80)
GO
INSERT [dbo].[Items] ([ItemNo], [Category], [ItemName], [StockCount], [ItemPrice]) VALUES (N'M001', 0, N'松阪豬', 800, 500)
GO
INSERT [dbo].[Items] ([ItemNo], [Category], [ItemName], [StockCount], [ItemPrice]) VALUES (N'M002', 0, N'雪花牛', 650, 800)
GO
INSERT [dbo].[Items] ([ItemNo], [Category], [ItemName], [StockCount], [ItemPrice]) VALUES (N'M003', 0, N'小羔羊', 800, 800)
GO
INSERT [dbo].[Items] ([ItemNo], [Category], [ItemName], [StockCount], [ItemPrice]) VALUES (N'M004', 0, N'放山雞', 800, 500)
GO
INSERT [dbo].[Items] ([ItemNo], [Category], [ItemName], [StockCount], [ItemPrice]) VALUES (N'O001', 3, N'魚餃', 800, 50)
GO
INSERT [dbo].[Items] ([ItemNo], [Category], [ItemName], [StockCount], [ItemPrice]) VALUES (N'O002', 3, N'燕餃', 800, 50)
GO
INSERT [dbo].[Items] ([ItemNo], [Category], [ItemName], [StockCount], [ItemPrice]) VALUES (N'O003', 3, N'蝦餃', 800, 50)
GO
INSERT [dbo].[Items] ([ItemNo], [Category], [ItemName], [StockCount], [ItemPrice]) VALUES (N'O004', 3, N'蛋餃', 800, 50)
GO
INSERT [dbo].[Items] ([ItemNo], [Category], [ItemName], [StockCount], [ItemPrice]) VALUES (N'O005', 3, N'香腸', 400, 35)
GO
INSERT [dbo].[Items] ([ItemNo], [Category], [ItemName], [StockCount], [ItemPrice]) VALUES (N'O006', 3, N'測試火鍋料', 800, 5)
GO
INSERT [dbo].[Items] ([ItemNo], [Category], [ItemName], [StockCount], [ItemPrice]) VALUES (N'S001', 1, N'鯛魚片', 200, 400)
GO
INSERT [dbo].[Items] ([ItemNo], [Category], [ItemName], [StockCount], [ItemPrice]) VALUES (N'S002', 1, N'草蝦', 200, 350)
GO
INSERT [dbo].[Items] ([ItemNo], [Category], [ItemName], [StockCount], [ItemPrice]) VALUES (N'S003', 1, N'鮮蚵', 400, 300)
GO
INSERT [dbo].[Items] ([ItemNo], [Category], [ItemName], [StockCount], [ItemPrice]) VALUES (N'S004', 1, N'蛤蠣', 300, 300)
GO
INSERT [dbo].[SalesOrders] ([SNo], [OrderNo], [SalesNo], [SalesProcessDate], [SalesCheck], [SalesManagerNo], [SalesManagerProcessDate], [SalesManagerCheck], [Remark]) VALUES (N'S20210830-001', N'20210830-001', N'2021-0008', CAST(N'2021-08-30T19:49:13.633' AS DateTime), N'Y', N'2021-0001', CAST(N'2021-08-30T19:49:38.760' AS DateTime), N'Y', N'2021-0008: OK /r/n2021-0001: OK /r/n')
GO
INSERT [dbo].[SalesOrders] ([SNo], [OrderNo], [SalesNo], [SalesProcessDate], [SalesCheck], [SalesManagerNo], [SalesManagerProcessDate], [SalesManagerCheck], [Remark]) VALUES (N'S20210830-002', N'20210830-002', N'2021-0008', CAST(N'2021-08-30T21:48:45.993' AS DateTime), N'Y', N'2021-0001', CAST(N'2021-08-30T21:49:10.673' AS DateTime), N'Y', N'2021-0008: OK /r/n2021-0001: OK /r/n')
GO
INSERT [dbo].[SalesOrders] ([SNo], [OrderNo], [SalesNo], [SalesProcessDate], [SalesCheck], [SalesManagerNo], [SalesManagerProcessDate], [SalesManagerCheck], [Remark]) VALUES (N'S20210901-001', N'20210901-001', N'2021-0009', CAST(N'2021-09-01T13:03:41.170' AS DateTime), N'Y', N'2021-0002', CAST(N'2021-09-01T13:03:56.970' AS DateTime), N'Y', N'2021-0009: OK /r/n2021-0002: OK /r/n')
GO
INSERT [dbo].[SalesOrders] ([SNo], [OrderNo], [SalesNo], [SalesProcessDate], [SalesCheck], [SalesManagerNo], [SalesManagerProcessDate], [SalesManagerCheck], [Remark]) VALUES (N'S20210901-002', N'20210901-002', N'2021-0009', CAST(N'2021-09-01T13:12:51.103' AS DateTime), N'Y', N'2021-0002', CAST(N'2021-09-01T13:13:14.403' AS DateTime), N'Y', N'2021-0009: OK /r/n2021-0002: OK /r/n')
GO
INSERT [dbo].[SalesOrders] ([SNo], [OrderNo], [SalesNo], [SalesProcessDate], [SalesCheck], [SalesManagerNo], [SalesManagerProcessDate], [SalesManagerCheck], [Remark]) VALUES (N'S20210901-003', N'20210901-004', N'2021-0008', CAST(N'2021-09-01T14:44:00.103' AS DateTime), N'N', N'2021-0001', CAST(N'2021-09-01T14:44:45.077' AS DateTime), N'Y', N'2021-0008: 金額過高，請協助退回 /r/n2021-0001: OK /r/n')
GO
INSERT [dbo].[SalesOrders] ([SNo], [OrderNo], [SalesNo], [SalesProcessDate], [SalesCheck], [SalesManagerNo], [SalesManagerProcessDate], [SalesManagerCheck], [Remark]) VALUES (N'S20210901-004', N'20210901-005', N'2021-0008', CAST(N'2021-09-01T15:06:58.137' AS DateTime), N'N', N'2021-0001', CAST(N'2021-09-01T15:08:55.877' AS DateTime), N'Y', N'2021-0008: OK /r/n2021-0001: 此次訂購品項跟數量不敷成本，請再次確認 /r/n2021-0008: 訂購品項跟數量不敷成本，請協助退回 /r/n2021-0001: OK /r/n')
GO
INSERT [dbo].[SalesOrders] ([SNo], [OrderNo], [SalesNo], [SalesProcessDate], [SalesCheck], [SalesManagerNo], [SalesManagerProcessDate], [SalesManagerCheck], [Remark]) VALUES (N'S20210901-005', N'20210901-006', N'2021-0008', CAST(N'2021-09-01T15:37:31.170' AS DateTime), N'Y', N'2021-0001', CAST(N'2021-09-01T15:40:16.933' AS DateTime), N'Y', N'2021-0008: OK /r/n2021-0001: OK /r/n')
GO
INSERT [dbo].[SalesOrders] ([SNo], [OrderNo], [SalesNo], [SalesProcessDate], [SalesCheck], [SalesManagerNo], [SalesManagerProcessDate], [SalesManagerCheck], [Remark]) VALUES (N'S20210901-006', N'20210901-007', N'2021-0008', CAST(N'2021-09-01T16:58:41.887' AS DateTime), N'Y', N'2021-0001', CAST(N'2021-09-01T16:58:56.690' AS DateTime), N'Y', N'2021-0008: OK /r/n2021-0001: OK /r/n')
GO
INSERT [dbo].[SalesOrders] ([SNo], [OrderNo], [SalesNo], [SalesProcessDate], [SalesCheck], [SalesManagerNo], [SalesManagerProcessDate], [SalesManagerCheck], [Remark]) VALUES (N'S20210903-001', N'20210903-001', N'2021-0008', CAST(N'2021-09-03T07:53:47.033' AS DateTime), N'Y', N'2021-0001', CAST(N'2021-09-03T08:39:16.323' AS DateTime), N'Y', N'2021-0008: OK /r/n2021-0001: OK /r/n')
GO
INSERT [dbo].[SalesOrders] ([SNo], [OrderNo], [SalesNo], [SalesProcessDate], [SalesCheck], [SalesManagerNo], [SalesManagerProcessDate], [SalesManagerCheck], [Remark]) VALUES (N'S20210907-001', N'20210907-002', N'2021-0008', CAST(N'2021-09-07T12:09:10.187' AS DateTime), N'N', N'2021-0001', CAST(N'2021-09-07T12:10:17.433' AS DateTime), N'Y', N'2021-0008: OK /r/n2021-0001: 下單品項過少，請重新檢視 /r/n2021-0008: 運輸成本過高，請協助退回 /r/n2021-0001: OK /r/n')
GO
INSERT [dbo].[SalesOrders] ([SNo], [OrderNo], [SalesNo], [SalesProcessDate], [SalesCheck], [SalesManagerNo], [SalesManagerProcessDate], [SalesManagerCheck], [Remark]) VALUES (N'S20210907-002', N'20210907-003', N'2021-0008', CAST(N'2021-09-07T12:13:35.703' AS DateTime), N'Y', N'2021-0001', CAST(N'2021-09-07T12:18:14.803' AS DateTime), N'Y', N'2021-0008: OK /r/n2021-0001: OK /r/n')
GO
INSERT [dbo].[SalesOrders] ([SNo], [OrderNo], [SalesNo], [SalesProcessDate], [SalesCheck], [SalesManagerNo], [SalesManagerProcessDate], [SalesManagerCheck], [Remark]) VALUES (N'S20210907-003', N'20210907-004', N'2021-0009', CAST(N'2021-09-07T13:17:03.893' AS DateTime), N'Y', N'2021-0002', CAST(N'2021-09-07T13:17:18.950' AS DateTime), N'Y', N'2021-0009: OK /r/n2021-0002: OK /r/n')
GO
INSERT [dbo].[SalesOrders] ([SNo], [OrderNo], [SalesNo], [SalesProcessDate], [SalesCheck], [SalesManagerNo], [SalesManagerProcessDate], [SalesManagerCheck], [Remark]) VALUES (N'S20210909-001', N'20210909-002', N'2021-0008', CAST(N'2021-09-09T14:53:57.773' AS DateTime), N'Y', N'2021-0001', CAST(N'2021-09-09T14:56:53.230' AS DateTime), N'Y', N'2021-0008: OK /r/n2021-0001: OK /r/n')
GO
INSERT [dbo].[SalesOrders] ([SNo], [OrderNo], [SalesNo], [SalesProcessDate], [SalesCheck], [SalesManagerNo], [SalesManagerProcessDate], [SalesManagerCheck], [Remark]) VALUES (N'S20210909-002', N'20210909-003', N'2021-0008', CAST(N'2021-09-09T18:01:46.210' AS DateTime), N'Y', N'2021-0001', CAST(N'2021-09-09T18:01:59.640' AS DateTime), N'Y', N'2021-0008: OK /r/n2021-0001: OK /r/n')
GO
INSERT [dbo].[SalesOrders] ([SNo], [OrderNo], [SalesNo], [SalesProcessDate], [SalesCheck], [SalesManagerNo], [SalesManagerProcessDate], [SalesManagerCheck], [Remark]) VALUES (N'S20210911-001', N'20210911-001', N'2021-0008', CAST(N'2021-09-15T20:22:51.347' AS DateTime), N'Y', N'2021-0001', CAST(N'2021-09-15T20:23:05.770' AS DateTime), N'Y', N'2021-0008: OK /r/n2021-0001: OK /r/n')
GO
INSERT [dbo].[SalesOrders] ([SNo], [OrderNo], [SalesNo], [SalesProcessDate], [SalesCheck], [SalesManagerNo], [SalesManagerProcessDate], [SalesManagerCheck], [Remark]) VALUES (N'S20210913-001', N'20210913-002', N'2021-0009', CAST(N'2021-09-13T22:05:41.947' AS DateTime), N'Y', N'2021-0002', CAST(N'2021-09-13T22:06:37.813' AS DateTime), N'Y', N'2021-0009: OK /r/n2021-0002: OK /r/n')
GO
INSERT [dbo].[SalesOrders] ([SNo], [OrderNo], [SalesNo], [SalesProcessDate], [SalesCheck], [SalesManagerNo], [SalesManagerProcessDate], [SalesManagerCheck], [Remark]) VALUES (N'S20210913-002', N'20210913-003', N'2021-0009', CAST(N'2021-09-13T22:11:58.647' AS DateTime), NULL, N'2021-0002', NULL, NULL, NULL)
GO
INSERT [dbo].[SalesOrders] ([SNo], [OrderNo], [SalesNo], [SalesProcessDate], [SalesCheck], [SalesManagerNo], [SalesManagerProcessDate], [SalesManagerCheck], [Remark]) VALUES (N'S20210915-001', N'20210915-002', N'2021-0008', CAST(N'2021-09-15T18:12:00.327' AS DateTime), N'Y', N'2021-0001', CAST(N'2021-09-15T18:12:13.353' AS DateTime), N'Y', N'2021-0008: OK /r/n2021-0001: OK /r/n')
GO
INSERT [dbo].[WarehouseOrders] ([WNo], [SNo], [OrderNo], [WarehouseNo], [WarehouseProcessDate], [WarehouseCheck], [WarehouseManagerNo], [WarehouseManagerProcessDate], [WarehouseManagerCheck], [Remark]) VALUES (N'W20210830-001', N'S20210830-001', N'20210830-001', N'2021-0012', CAST(N'2021-08-30T19:50:09.393' AS DateTime), N'Y', N'2021-0003', CAST(N'2021-08-30T21:35:11.420' AS DateTime), N'Y', N'2021-0008: OK /r/n2021-0001: OK /r/n2021-0012: OK/r/n2021-0003: OK/r/n')
GO
INSERT [dbo].[WarehouseOrders] ([WNo], [SNo], [OrderNo], [WarehouseNo], [WarehouseProcessDate], [WarehouseCheck], [WarehouseManagerNo], [WarehouseManagerProcessDate], [WarehouseManagerCheck], [Remark]) VALUES (N'W20210830-002', N'S20210830-002', N'20210830-002', N'2021-0012', CAST(N'2021-08-30T21:49:32.867' AS DateTime), N'Y', N'2021-0003', CAST(N'2021-08-30T21:50:06.897' AS DateTime), N'Y', N'2021-0008: OK /r/n2021-0001: OK /r/n2021-0012: OK/r/n2021-0003: OK/r/n')
GO
INSERT [dbo].[WarehouseOrders] ([WNo], [SNo], [OrderNo], [WarehouseNo], [WarehouseProcessDate], [WarehouseCheck], [WarehouseManagerNo], [WarehouseManagerProcessDate], [WarehouseManagerCheck], [Remark]) VALUES (N'W20210901-001', N'S20210901-001', N'20210901-001', N'2021-0011', CAST(N'2021-09-01T13:04:30.757' AS DateTime), N'Y', N'2021-0004', CAST(N'2021-09-01T13:05:13.790' AS DateTime), N'Y', N'2021-0009: OK /r/n2021-0002: OK /r/n2021-0011: OK/r/n2021-0004: OK/r/n')
GO
INSERT [dbo].[WarehouseOrders] ([WNo], [SNo], [OrderNo], [WarehouseNo], [WarehouseProcessDate], [WarehouseCheck], [WarehouseManagerNo], [WarehouseManagerProcessDate], [WarehouseManagerCheck], [Remark]) VALUES (N'W20210901-002', N'S20210901-002', N'20210901-002', N'2021-0011', CAST(N'2021-09-01T13:13:34.127' AS DateTime), N'Y', N'2021-0004', CAST(N'2021-09-01T13:14:02.730' AS DateTime), N'Y', N'2021-0009: OK /r/n2021-0002: OK /r/n2021-0011: OK/r/n2021-0004: OK/r/n')
GO
INSERT [dbo].[WarehouseOrders] ([WNo], [SNo], [OrderNo], [WarehouseNo], [WarehouseProcessDate], [WarehouseCheck], [WarehouseManagerNo], [WarehouseManagerProcessDate], [WarehouseManagerCheck], [Remark]) VALUES (N'W20210901-003', N'S20210901-005', N'20210901-006', N'2021-0012', CAST(N'2021-09-01T15:45:59.313' AS DateTime), N'Y', N'2021-0003', CAST(N'2021-09-01T15:46:17.800' AS DateTime), N'Y', N'2021-0008: OK /r/n2021-0001: OK /r/n2021-0012: OK/r/n2021-0003: OK/r/n')
GO
INSERT [dbo].[WarehouseOrders] ([WNo], [SNo], [OrderNo], [WarehouseNo], [WarehouseProcessDate], [WarehouseCheck], [WarehouseManagerNo], [WarehouseManagerProcessDate], [WarehouseManagerCheck], [Remark]) VALUES (N'W20210901-004', N'S20210901-006', N'20210901-007', N'2021-0012', CAST(N'2021-09-01T17:46:01.140' AS DateTime), N'Y', N'2021-0003', CAST(N'2021-09-01T17:47:25.843' AS DateTime), N'Y', N'2021-0008: OK /r/n2021-0001: OK /r/n2021-0012: OK/r/n2021-0003: M004 現有庫存不足，請再檢')
GO
INSERT [dbo].[WarehouseOrders] ([WNo], [SNo], [OrderNo], [WarehouseNo], [WarehouseProcessDate], [WarehouseCheck], [WarehouseManagerNo], [WarehouseManagerProcessDate], [WarehouseManagerCheck], [Remark]) VALUES (N'W20210903-001', N'S20210903-001', N'20210903-001', N'2021-0012', CAST(N'2021-09-07T11:24:16.023' AS DateTime), N'Y', N'2021-0003', CAST(N'2021-09-07T11:25:00.950' AS DateTime), N'Y', N'2021-0008: OK /r/n2021-0001: OK /r/n2021-0012: OK/r/n2021-0003: OK/r/n')
GO
INSERT [dbo].[WarehouseOrders] ([WNo], [SNo], [OrderNo], [WarehouseNo], [WarehouseProcessDate], [WarehouseCheck], [WarehouseManagerNo], [WarehouseManagerProcessDate], [WarehouseManagerCheck], [Remark]) VALUES (N'W20210907-001', N'S20210907-002', N'20210907-003', N'2021-0012', CAST(N'2021-09-07T12:19:37.750' AS DateTime), N'Y', N'2021-0003', CAST(N'2021-09-07T12:20:16.877' AS DateTime), N'Y', N'2021-0008: OK /r/n2021-0001: OK /r/n2021-0012: OK/r/n2021-0003: OK/r/n')
GO
INSERT [dbo].[WarehouseOrders] ([WNo], [SNo], [OrderNo], [WarehouseNo], [WarehouseProcessDate], [WarehouseCheck], [WarehouseManagerNo], [WarehouseManagerProcessDate], [WarehouseManagerCheck], [Remark]) VALUES (N'W20210907-002', N'S20210907-003', N'20210907-004', N'2021-0011', CAST(N'2021-09-07T13:18:12.043' AS DateTime), N'Y', N'2021-0004', CAST(N'2021-09-07T13:18:32.250' AS DateTime), N'Y', N'2021-0009: OK /r/n2021-0002: OK /r/n2021-0011: 庫存不足/r/n2021-0004: OK/r/n')
GO
INSERT [dbo].[WarehouseOrders] ([WNo], [SNo], [OrderNo], [WarehouseNo], [WarehouseProcessDate], [WarehouseCheck], [WarehouseManagerNo], [WarehouseManagerProcessDate], [WarehouseManagerCheck], [Remark]) VALUES (N'W20210909-001', N'S20210909-001', N'20210909-002', N'2021-0012', CAST(N'2021-09-09T15:02:45.870' AS DateTime), N'Y', N'2021-0003', CAST(N'2021-09-09T15:07:30.403' AS DateTime), N'Y', N'2021-0008: OK /r/n2021-0001: OK /r/n2021-0012: OK/r/n2021-0003: OK/r/n')
GO
INSERT [dbo].[WarehouseOrders] ([WNo], [SNo], [OrderNo], [WarehouseNo], [WarehouseProcessDate], [WarehouseCheck], [WarehouseManagerNo], [WarehouseManagerProcessDate], [WarehouseManagerCheck], [Remark]) VALUES (N'W20210909-002', N'S20210909-002', N'20210909-003', N'2021-0012', CAST(N'2021-09-09T18:02:23.917' AS DateTime), N'Y', N'2021-0003', CAST(N'2021-09-09T18:09:22.433' AS DateTime), N'Y', N'2021-0008: OK /r/n2021-0001: OK /r/n2021-0012: OK/r/n2021-0003: OK/r/n')
GO
INSERT [dbo].[WarehouseOrders] ([WNo], [SNo], [OrderNo], [WarehouseNo], [WarehouseProcessDate], [WarehouseCheck], [WarehouseManagerNo], [WarehouseManagerProcessDate], [WarehouseManagerCheck], [Remark]) VALUES (N'W20210913-001', N'S20210913-001', N'20210913-002', N'2021-0011', CAST(N'2021-09-13T22:06:55.623' AS DateTime), N'Y', N'2021-0004', CAST(N'2021-09-13T22:07:33.013' AS DateTime), N'Y', N'2021-0009: OK /r/n2021-0002: OK /r/n2021-0011: OK/r/n2021-0004: OK/r/n')
GO
INSERT [dbo].[WarehouseOrders] ([WNo], [SNo], [OrderNo], [WarehouseNo], [WarehouseProcessDate], [WarehouseCheck], [WarehouseManagerNo], [WarehouseManagerProcessDate], [WarehouseManagerCheck], [Remark]) VALUES (N'W20210915-001', N'S20210915-001', N'20210915-002', N'2021-0012', CAST(N'2021-09-15T18:12:27.420' AS DateTime), N'Y', N'2021-0003', CAST(N'2021-09-15T18:12:48.180' AS DateTime), N'Y', N'2021-0008: OK /r/n2021-0001: OK /r/n2021-0012: OK/r/n2021-0003: OK/r/n')
GO
INSERT [dbo].[WarehouseOrders] ([WNo], [SNo], [OrderNo], [WarehouseNo], [WarehouseProcessDate], [WarehouseCheck], [WarehouseManagerNo], [WarehouseManagerProcessDate], [WarehouseManagerCheck], [Remark]) VALUES (N'W20210915-002', N'S20210911-001', N'20210911-001', N'2021-0012', CAST(N'2021-09-15T20:33:39.747' AS DateTime), N'Y', N'2021-0003', CAST(N'2021-09-15T20:41:04.503' AS DateTime), N'Y', N'2021-0008: OK /r/n2021-0001: OK /r/n2021-0012: OK/r/n2021-0003: OK/r/n')
GO
ALTER TABLE [dbo].[ChainsEmployees] ADD  CONSTRAINT [DF_ChainsEmployees_EmployeeID]  DEFAULT ([dbo].[getChainsEmployeeID]()) FOR [EmployeeID]
GO
ALTER TABLE [dbo].[CustomerOrders] ADD  CONSTRAINT [DF_CustomerOrders_OrderNo]  DEFAULT ([dbo].[getCustomerOrderNo]()) FOR [OrderNo]
GO
ALTER TABLE [dbo].[HeadquartersEmployees] ADD  CONSTRAINT [DF_HeadquartersEmployees_EmployeeID]  DEFAULT ([dbo].[getHeadquartersEmployeeID]()) FOR [EmployeeID]
GO
ALTER TABLE [dbo].[SalesOrders] ADD  CONSTRAINT [DF_SalesOrders_SNo]  DEFAULT ([dbo].[getSalesOrderNo]()) FOR [SNo]
GO
ALTER TABLE [dbo].[WarehouseOrders] ADD  CONSTRAINT [DF_WarehouseOrders_WNo]  DEFAULT ([dbo].[getWarehouseOrderNo]()) FOR [WNo]
GO
ALTER TABLE [dbo].[CustomerOrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_CustomerOrderDetails_ItemNo] FOREIGN KEY([ItemNo])
REFERENCES [dbo].[Items] ([ItemNo])
GO
ALTER TABLE [dbo].[CustomerOrderDetails] CHECK CONSTRAINT [FK_CustomerOrderDetails_ItemNo]
GO
ALTER TABLE [dbo].[CustomerOrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_CustomerOrderDetails_OrderNo] FOREIGN KEY([OrderNo])
REFERENCES [dbo].[CustomerOrders] ([OrderNo])
GO
ALTER TABLE [dbo].[CustomerOrderDetails] CHECK CONSTRAINT [FK_CustomerOrderDetails_OrderNo]
GO
ALTER TABLE [dbo].[CustomerOrders]  WITH CHECK ADD  CONSTRAINT [FK_CustomerOrders_CustomerOrders] FOREIGN KEY([OrderNo])
REFERENCES [dbo].[CustomerOrders] ([OrderNo])
GO
ALTER TABLE [dbo].[CustomerOrders] CHECK CONSTRAINT [FK_CustomerOrders_CustomerOrders]
GO
ALTER TABLE [dbo].[SalesOrders]  WITH CHECK ADD  CONSTRAINT [FK_SalesOrders_OrderNo] FOREIGN KEY([OrderNo])
REFERENCES [dbo].[CustomerOrders] ([OrderNo])
GO
ALTER TABLE [dbo].[SalesOrders] CHECK CONSTRAINT [FK_SalesOrders_OrderNo]
GO
ALTER TABLE [dbo].[WarehouseOrders]  WITH CHECK ADD  CONSTRAINT [FK_WarehouseOrders_OrderNo] FOREIGN KEY([OrderNo])
REFERENCES [dbo].[CustomerOrders] ([OrderNo])
GO
ALTER TABLE [dbo].[WarehouseOrders] CHECK CONSTRAINT [FK_WarehouseOrders_OrderNo]
GO
ALTER TABLE [dbo].[WarehouseOrders]  WITH CHECK ADD  CONSTRAINT [FK_WarehouseOrders_Sno] FOREIGN KEY([SNo])
REFERENCES [dbo].[SalesOrders] ([SNo])
GO
ALTER TABLE [dbo].[WarehouseOrders] CHECK CONSTRAINT [FK_WarehouseOrders_Sno]
GO
USE [master]
GO
ALTER DATABASE [FinalProject] SET  READ_WRITE 
GO
