-- Schema creations must be the only statement in a batch. One way to get around it is with the Exec
IF (NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'dbo'))
BEGIN
	EXEC ('CREATE SCHEMA [dbo] AUTHORIZATION [dbo]')
END
GO

-- create tables
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rp_role]
(
	  [oid] BINARY(16) NOT NULL
	, [created_on] DATETIME NOT NULL
	, [modified_on] DATETIME NOT NULL
	, [created_by_user_oid] BINARY(16) NOT NULL
	, [modified_by_user_oid] BINARY(16) NOT NULL
	, [user_role_oid] BINARY(16) NULL
	, [name] NVARCHAR(200) NOT NULL
	, [description] NVARCHAR(MAX) NULL
	, [external_role_alias] NVARCHAR(200) NULL
	, [external_role_name] NVARCHAR(200) NULL
	, [permissions_read] NVARCHAR(MAX) NULL
	, [permissions_write] NVARCHAR(MAX) NULL
	, [notifications] NVARCHAR(MAX) NULL
	, [comments] NVARCHAR(MAX) NULL
	, [status] TINYINT NOT NULL DEFAULT('10')
	, [custom_attributes] NVARCHAR(MAX) NULL
	, [external_role_mapped_flag] BIT NULL
	, [external_role_sync_flag] BIT NULL
	, [app_oid] BINARY(16) NULL
	, [type] NVARCHAR(100) NOT NULL
	, PRIMARY KEY CLUSTERED 
(
	[oid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rp_role_attribute]
(
	  [oid] BINARY(16) NOT NULL
	, [created_on] DATETIME NOT NULL
	, [modified_on] DATETIME NOT NULL
	, [created_by_user_oid] BINARY(16) NOT NULL
	, [modified_by_user_oid] BINARY(16) NOT NULL
	, [name] NVARCHAR(50) NOT NULL
	, [hint] NVARCHAR(200) NULL
	, [type] NVARCHAR(50) NOT NULL
	, [json_property] NVARCHAR(50) NOT NULL
	, [app_oid] BINARY(16) NULL
	, [required] TINYINT NOT NULL DEFAULT('0')
	, [display_order] TINYINT NOT NULL
	, PRIMARY KEY CLUSTERED 
(
	[oid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- foreign keys
ALTER TABLE [dbo].[rp_role] WITH CHECK ADD CONSTRAINT [FK_dbo_rp_role_exf_app] FOREIGN KEY([app_oid])
REFERENCES [dbo].[exf_app] ([oid])
GO
ALTER TABLE [dbo].[rp_role] WITH CHECK ADD CONSTRAINT [FK_dbo_rp_role_exf_user_role] FOREIGN KEY([user_role_oid])
REFERENCES [dbo].[exf_user_role] ([oid])
GO
ALTER TABLE [dbo].[rp_role_attribute] WITH CHECK ADD CONSTRAINT [FK_dbo_rp_role_attribute_exf_app] FOREIGN KEY([app_oid])
REFERENCES [dbo].[exf_app] ([oid])
GO

-- unique indexes
CREATE UNIQUE NONCLUSTERED INDEX [UIX_dbo_rp_role_name] ON [dbo].[rp_role]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED INDEX [UIX_dbo_rp_role_attribute_name] ON [dbo].[rp_role_attribute]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED INDEX [UIX_dbo_rp_role_attribute_display_order] ON [dbo].[rp_role_attribute]
(
	[display_order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO