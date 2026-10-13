-- ============================================================================
-- Canteen Complaint System - SQL Server Database Setup Script
-- Database Name: CanteenDB
-- Tables Created: Users, Complaints
-- ============================================================================

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'CanteenDB')
BEGIN
    CREATE DATABASE [CanteenDB];
END
GO

USE [CanteenDB];
GO

-- ----------------------------------------------------------------------------
-- Table: Users
-- ----------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Users] (
        [UserId] INT IDENTITY(1,1) NOT NULL,
        [Username] NVARCHAR(50) NOT NULL UNIQUE,
        [StudentName] NVARCHAR(100) NOT NULL,
        [StudentEmail] NVARCHAR(150) NOT NULL,
        [PasswordHash] NVARCHAR(256) NOT NULL,
        [Role] NVARCHAR(20) NOT NULL DEFAULT 'Student', -- Student, Admin
        [CreatedDate] DATETIME NOT NULL DEFAULT GETDATE(),
        CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([UserId] ASC)
    );
END
GO

-- ----------------------------------------------------------------------------
-- Table: Complaints
-- ----------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Complaints]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Complaints] (
        [ComplaintId] INT IDENTITY(1,1) NOT NULL,
        [StudentName] NVARCHAR(100) NOT NULL,
        [StudentEmail] NVARCHAR(150) NOT NULL,
        [Category] NVARCHAR(50) NOT NULL,
        [IncidentDate] DATETIME NOT NULL,
        [Description] NVARCHAR(MAX) NOT NULL,
        [Status] NVARCHAR(50) NOT NULL DEFAULT 'Pending', -- Pending, In Progress, Resolved, Rejected
        [SubmittedDate] DATETIME NOT NULL DEFAULT GETDATE(),
        [UserId] INT NULL,
        CONSTRAINT [PK_Complaints] PRIMARY KEY CLUSTERED ([ComplaintId] ASC),
        CONSTRAINT [FK_Complaints_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE SET NULL
    );
END
GO

-- ----------------------------------------------------------------------------
-- Seed Initial Data for Testing
-- ----------------------------------------------------------------------------

-- Insert Admin & Student User
IF NOT EXISTS (SELECT * FROM [dbo].[Users] WHERE [Username] = 'admin')
BEGIN
    INSERT INTO [dbo].[Users] ([Username], [StudentName], [StudentEmail], [PasswordHash], [Role], [CreatedDate])
    VALUES ('admin', 'System Administrator', 'admin@canteen.edu', 'AQAAAAEAACcQAAAAE...', 'Admin', GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[Users] WHERE [Username] = 'johndoe')
BEGIN
    INSERT INTO [dbo].[Users] ([Username], [StudentName], [StudentEmail], [PasswordHash], [Role], [CreatedDate])
    VALUES ('johndoe', 'John Doe', 'john.doe@student.edu', 'AQAAAAEAACcQAAAAE...', 'Student', GETDATE());
END
GO

-- Insert Sample Complaints
IF NOT EXISTS (SELECT * FROM [dbo].[Complaints])
BEGIN
    INSERT INTO [dbo].[Complaints] ([StudentName], [StudentEmail], [Category], [IncidentDate], [Description], [Status], [SubmittedDate])
    VALUES 
    (N'Alice Smith', N'alice.smith@student.edu', N'Food Quality', GETDATE() - 2, N'The lunch soup served on Tuesday was cold and lacked proper seasoning.', N'Pending', GETDATE() - 2),
    (N'Bob Johnson', N'bob.johnson@student.edu', N'Hygiene', GETDATE() - 4, N'Found unwashed utensils near the drink dispenser on the 2nd floor canteen counter.', N'In Progress', GETDATE() - 4),
    (N'Charlie Brown', N'charlie.brown@student.edu', N'Service Speed', GETDATE() - 6, N'Waited over 35 minutes for a simple sandwich during peak lunch hours.', N'Resolved', GETDATE() - 5),
    (N'Diana Prince', N'diana.prince@student.edu', N'Billing', GETDATE() - 1, N'Charged twice on student ID card for the salad meal deal.', N'Pending', GETDATE() - 1),
    (N'Evan Wright', N'evan.wright@student.edu', N'Staff Behavior', GETDATE() - 3, N'Staff member at Counter 3 was unresponsive to dietary allergen inquiries.', N'Resolved', GETDATE() - 2),
    (N'Fiona Gallagher', N'fiona.gallagher@student.edu', N'Food Quality', GETDATE() - 5, N'Vegetable wrap was stale and contained wrong filling.', N'Resolved', GETDATE() - 3);
END
GO
