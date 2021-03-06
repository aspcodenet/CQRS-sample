USE [dinner]
GO
/****** Object:  Table [dbo].[useraccount]    Script Date: 07/21/2010 15:55:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[useraccount](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[forname] [varchar](100) NOT NULL,
	[surname] [varchar](100) NOT NULL,
	[joined] [datetime] NOT NULL,
 CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[useraccount] ON
INSERT [dbo].[useraccount] ([id], [forname], [surname], [joined]) VALUES (1, N'Stefan', N'Holmberg2', CAST(0x00009DAD00FDDA54 AS DateTime))
INSERT [dbo].[useraccount] ([id], [forname], [surname], [joined]) VALUES (2, N'Peter', N'Pan', CAST(0x00009DAD00FDE3B4 AS DateTime))
INSERT [dbo].[useraccount] ([id], [forname], [surname], [joined]) VALUES (3, N'Donald', N'Duck', CAST(0x00009DAD00FDEED3 AS DateTime))
SET IDENTITY_INSERT [dbo].[useraccount] OFF
/****** Object:  Table [dbo].[report_user]    Script Date: 07/21/2010 15:55:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[report_user](
	[user_id] [int] NOT NULL,
	[forname] [varchar](100) NOT NULL,
	[surname] [varchar](100) NOT NULL,
 CONSTRAINT [PK_report_user] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[report_user] ([user_id], [forname], [surname]) VALUES (1, N'Stefan', N'Holmberg2')
INSERT [dbo].[report_user] ([user_id], [forname], [surname]) VALUES (2, N'Peter', N'Pan')
INSERT [dbo].[report_user] ([user_id], [forname], [surname]) VALUES (3, N'Donald', N'Duck')
/****** Object:  Table [dbo].[report_dinner]    Script Date: 07/21/2010 15:55:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[report_dinner](
	[dinner_id] [int] NOT NULL,
	[date] [datetime] NOT NULL,
	[location] [varchar](512) NOT NULL,
	[description] [varchar](512) NOT NULL,
	[organizer_user_id] [int] NOT NULL,
	[organizer_fullname] [varchar](255) NOT NULL,
 CONSTRAINT [PK_report_dinner_1] PRIMARY KEY CLUSTERED 
(
	[dinner_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[report_dinner] ([dinner_id], [date], [location], [description], [organizer_user_id], [organizer_fullname]) VALUES (1, CAST(0x00009DAE00DC4A34 AS DateTime), N'Home', N'Come as you are', 1, N'Stefan Holmberg2')
/****** Object:  Table [dbo].[dinneruser]    Script Date: 07/21/2010 15:55:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dinneruser](
	[user_id] [int] NOT NULL,
	[dinner_id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dinner]    Script Date: 07/21/2010 15:55:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dinner](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[date] [datetime] NOT NULL,
	[location] [varchar](255) NOT NULL,
	[description] [varchar](255) NOT NULL,
	[organiser_user_id] [int] NOT NULL,
 CONSTRAINT [PK_dinner] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[dinner] ON
INSERT [dbo].[dinner] ([id], [date], [location], [description], [organiser_user_id]) VALUES (1, CAST(0x00009DAE00DC4A34 AS DateTime), N'Home', N'Come as you are', 1)
SET IDENTITY_INSERT [dbo].[dinner] OFF
/****** Object:  Table [dbo].[report_dinnerusers]    Script Date: 07/21/2010 15:55:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[report_dinnerusers](
	[user_id] [int] NOT NULL,
	[dinner_id] [int] NOT NULL,
 CONSTRAINT [PK_report_dinnerusers] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[dinner_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[report_updateuser]    Script Date: 07/21/2010 15:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[report_updateuser](@user_id int)
as
if ((select count(*) from useraccount where id=@user_id ) = 0 )
	BEGIN
		delete from report_dinnerusers where [user_id]=@user_id
		delete from report_user where [user_id]=@user_id
	END	
ELSE
	BEGIN
		if ((select count(*) from report_user where user_id=@user_id ) = 0 )
			insert report_user(user_id,forname,surname) select id,forname,surname from useraccount where id=@user_id
		ELSE			
			update report_user set forname=a.forname,surname=a.surname from report_user,useraccount a where report_user.user_id=a.id and a.id=@user_id
	END
GO
/****** Object:  StoredProcedure [dbo].[report_updatedinnerusers]    Script Date: 07/21/2010 15:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[report_updatedinnerusers](@dinner_id int)
as
delete from report_dinnerusers where dinner_id = @dinner_id
insert into report_dinnerusers(dinner_id,[user_id]) select 
dinneruser.dinner_id,dinneruser.[user_id]
from dinneruser where dinner_id=@dinner_id
GO
/****** Object:  StoredProcedure [dbo].[report_updatedinner]    Script Date: 07/21/2010 15:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[report_updatedinner](@dinner_id int)
as
if ((select count(*) from dinner where id=@dinner_id ) = 0 )
	BEGIN
		delete 
			from
				report_dinnerusers 
			where 
				[dinner_id]=@dinner_id
		
		delete 
			from 
				report_dinner 
			where 
				[dinner_id]=@dinner_id
	END	
ELSE
	BEGIN
		if ((select count(*) from report_dinner where dinner_id=@dinner_id ) = 0 )
			insert 
				report_dinner(dinner_id,[date],location,[description],organizer_user_id,organizer_fullname) 
				select 
					dinner.id,dinner.[date],dinner.location,
						dinner.[description],dinner.organiser_user_id,
							useraccount.forname + ' '+ useraccount.surname 
				from
					dinner, useraccount 
				where  
						dinner.id=@dinner_id
						and dinner.location =  useraccount.id
		ELSE			
			update 
				report_dinner 
			set 
				report_dinner.[date]=dinner.[date],
				report_dinner.[description] = dinner.[description],
				report_dinner.location = dinner.location,
				report_dinner.organizer_fullname = useraccount.forname + ' '+ useraccount.surname ,
				report_dinner.organizer_user_id = dinner.organiser_user_id
			from report_dinner, dinner, useraccount
			where 
				report_dinner.dinner_id=dinner.id and
				dinner.organiser_user_id = useraccount.id
				
				
			
	END
GO
/****** Object:  ForeignKey [FK_report_dinnerusers_report_dinner]    Script Date: 07/21/2010 15:55:10 ******/
ALTER TABLE [dbo].[report_dinnerusers]  WITH CHECK ADD  CONSTRAINT [FK_report_dinnerusers_report_dinner] FOREIGN KEY([dinner_id])
REFERENCES [dbo].[report_dinner] ([dinner_id])
GO
ALTER TABLE [dbo].[report_dinnerusers] CHECK CONSTRAINT [FK_report_dinnerusers_report_dinner]
GO
/****** Object:  ForeignKey [FK_report_dinnerusers_report_user]    Script Date: 07/21/2010 15:55:10 ******/
ALTER TABLE [dbo].[report_dinnerusers]  WITH CHECK ADD  CONSTRAINT [FK_report_dinnerusers_report_user] FOREIGN KEY([user_id])
REFERENCES [dbo].[report_user] ([user_id])
GO
ALTER TABLE [dbo].[report_dinnerusers] CHECK CONSTRAINT [FK_report_dinnerusers_report_user]
GO
