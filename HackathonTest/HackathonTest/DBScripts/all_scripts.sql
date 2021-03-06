USE [Hackathon]
GO
/****** Object:  UserDefinedTableType [dbo].[TestCaseSteps]    Script Date: 6/5/2018 5:15:18 PM ******/
CREATE TYPE [dbo].[TestCaseSteps] AS TABLE(
	[TestCaseId] [int] NULL,
	[WebEleId] [int] NULL,
	[TestCaseStepSequence] [int] NULL,
	[StepDescription] [varchar](200) NULL
)
GO
/****** Object:  Table [dbo].[TestCase]    Script Date: 6/5/2018 5:15:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TestCase](
	[Id] [int] NOT NULL,
	[TestCaseName] [varchar](50) NULL,
	[LastRunStatus] [bit] NULL,
	[IsExecuted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TestCaseExecution]    Script Date: 6/5/2018 5:15:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TestCaseExecution](
	[TestCaseId] [int] NULL,
	[WebElementId] [int] NULL,
	[TestCaseStepSequence] [int] NULL,
	[StepDescription] [varchar](200) NULL,
	[id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WebElements]    Script Date: 6/5/2018 5:15:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WebElements](
	[Id] [int] NOT NULL,
	[IsMultipleElemets] [bit] NULL,
	[ElementName] [varchar](30) NULL,
	[Locator] [varchar](30) NULL,
	[FindElementMachanism] [varchar](50) NULL,
	[InputType] [varchar](30) NULL,
	[InputData] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[TestCaseExecution]  WITH CHECK ADD FOREIGN KEY([TestCaseId])
REFERENCES [dbo].[TestCase] ([Id])
GO
ALTER TABLE [dbo].[TestCaseExecution]  WITH CHECK ADD FOREIGN KEY([WebElementId])
REFERENCES [dbo].[WebElements] ([Id])
GO
/****** Object:  StoredProcedure [dbo].[GetTestCases]    Script Date: 6/5/2018 5:15:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTestCases] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT a.ElementName,a.FindElementMachanism,a.InputData,a.InputType,a.IsMultipleElemets,a.Locator,b.TestCaseStepSequence,c.TestCaseName,c.LastRunStatus,c.IsExecuted
	 from WebElements as a Join TestCaseExecution as b on a.Id=b.WebElementId 
	 Join TestCase as c on c.Id=b.TestCaseId
END

GO
/****** Object:  StoredProcedure [dbo].[GetWebElements]    Script Date: 6/5/2018 5:15:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetWebElements]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from WebElements
END

GO
/****** Object:  StoredProcedure [dbo].[InsertTestCaseExecution]    Script Date: 6/5/2018 5:15:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertTestCaseExecution]
	-- Add the parameters for the stored procedure here
	@Values TestCaseSteps readonly

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Declare @Temp int

   INSERT INTO dbo.TestCaseExecution
          (                    
            TestCaseId,WebElementId,TestCaseStepSequence,StepDescription
          ) 
     select * from @Values
END

GO
/****** Object:  StoredProcedure [dbo].[InsertTestCases]    Script Date: 6/5/2018 5:15:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertTestCases]
	-- Add the parameters for the stored procedure here
	@TestCaseName varchar,
	@LastRunStatus bit,
	@IsExecuted bit

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Declare @Temp int

   INSERT INTO dbo.TestCase
          (                    
            TestCaseName,LastRunStatus,IsExecuted
          ) 
     VALUES 
          ( 
            @TestCaseName,@LastRunStatus,@IsExecuted
		  )
		  SELECT @Temp=Id from TestCase where TestCaseName=@TestCaseName

		  return @Temp
END

GO
/****** Object:  StoredProcedure [dbo].[InsertWebElements]    Script Date: 6/5/2018 5:15:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertWebElements]
	-- Add the parameters for the stored procedure here
	@ElementName varchar,
	@Locator varchar,
	@FindElementMechanism varchar,
	@IsMultipleElements bit,
	@InputType varchar,
	@InputData varchar=Null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   INSERT INTO dbo.WebElements
          (                    
            ElementName,Locator,FindElementMachanism,IsMultipleElemets,InputType,InputData
          ) 
     VALUES 
          ( 
            @ElementName,@Locator,@FindElementMechanism,@IsMultipleElements,@InputType,@InputData
		  )
END

GO
