IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [Users] (
    [Id] int NOT NULL IDENTITY,
    [Name] nvarchar(50) NOT NULL,
    [LastName] nvarchar(100) NOT NULL,
    [Email] nvarchar(max) NOT NULL,
    [Password] nvarchar(max) NOT NULL,
    [CreatedBy] nvarchar(max) NOT NULL,
    [CreatedAt] datetime2 NOT NULL,
    [UpdatedBy] nvarchar(max) NOT NULL,
    [UpdatedAt] datetime2 NULL,
    [DeletedAt] datetime2 NULL,
    [DeletedBy] nvarchar(max) NOT NULL,
    [isDeleted] bit NOT NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY ([Id])
);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220930203621_Create Users table', N'6.0.9');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [Cursos] (
    [Id] int NOT NULL IDENTITY,
    [Nombre] nvarchar(50) NOT NULL,
    [DescripcionCorta] nvarchar(280) NOT NULL,
    [DescripcionLarga] nvarchar(max) NOT NULL,
    [PublicoObjetivo] nvarchar(max) NOT NULL,
    [Objetivos] nvarchar(max) NOT NULL,
    [Requisitos] nvarchar(max) NOT NULL,
    [CreatedBy] nvarchar(max) NOT NULL,
    [CreatedAt] datetime2 NOT NULL,
    [UpdatedBy] nvarchar(max) NOT NULL,
    [UpdatedAt] datetime2 NULL,
    [DeletedAt] datetime2 NULL,
    [DeletedBy] nvarchar(max) NOT NULL,
    [isDeleted] bit NOT NULL,
    CONSTRAINT [PK_Cursos] PRIMARY KEY ([Id])
);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20221004164621_create cursos table', N'6.0.9');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Cursos] ADD [Nivel] int NOT NULL DEFAULT 0;
GO

CREATE TABLE [Categories] (
    [Id] int NOT NULL IDENTITY,
    [Name] nvarchar(max) NOT NULL,
    [CreatedBy] nvarchar(max) NOT NULL,
    [CreatedAt] datetime2 NOT NULL,
    [UpdatedBy] nvarchar(max) NOT NULL,
    [UpdatedAt] datetime2 NULL,
    [DeletedAt] datetime2 NULL,
    [DeletedBy] nvarchar(max) NOT NULL,
    [isDeleted] bit NOT NULL,
    CONSTRAINT [PK_Categories] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Chapters] (
    [Id] int NOT NULL IDENTITY,
    [CursoID] int NOT NULL,
    [CreatedBy] nvarchar(max) NOT NULL,
    [CreatedAt] datetime2 NOT NULL,
    [UpdatedBy] nvarchar(max) NOT NULL,
    [UpdatedAt] datetime2 NULL,
    [DeletedAt] datetime2 NULL,
    [DeletedBy] nvarchar(max) NOT NULL,
    [isDeleted] bit NOT NULL,
    CONSTRAINT [PK_Chapters] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Chapters_Cursos_CursoID] FOREIGN KEY ([CursoID]) REFERENCES [Cursos] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [Students] (
    [Id] int NOT NULL IDENTITY,
    [FirstName] nvarchar(max) NOT NULL,
    [LastName] nvarchar(max) NOT NULL,
    [Dob] datetime2 NOT NULL,
    [CreatedBy] nvarchar(max) NOT NULL,
    [CreatedAt] datetime2 NOT NULL,
    [UpdatedBy] nvarchar(max) NOT NULL,
    [UpdatedAt] datetime2 NULL,
    [DeletedAt] datetime2 NULL,
    [DeletedBy] nvarchar(max) NOT NULL,
    [isDeleted] bit NOT NULL,
    CONSTRAINT [PK_Students] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [CategoryCurso] (
    [CategoriesId] int NOT NULL,
    [CursosId] int NOT NULL,
    CONSTRAINT [PK_CategoryCurso] PRIMARY KEY ([CategoriesId], [CursosId]),
    CONSTRAINT [FK_CategoryCurso_Categories_CategoriesId] FOREIGN KEY ([CategoriesId]) REFERENCES [Categories] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_CategoryCurso_Cursos_CursosId] FOREIGN KEY ([CursosId]) REFERENCES [Cursos] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [CursoStudent] (
    [CursosId] int NOT NULL,
    [StudentsId] int NOT NULL,
    CONSTRAINT [PK_CursoStudent] PRIMARY KEY ([CursosId], [StudentsId]),
    CONSTRAINT [FK_CursoStudent_Cursos_CursosId] FOREIGN KEY ([CursosId]) REFERENCES [Cursos] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_CursoStudent_Students_StudentsId] FOREIGN KEY ([StudentsId]) REFERENCES [Students] ([Id]) ON DELETE CASCADE
);
GO

CREATE INDEX [IX_CategoryCurso_CursosId] ON [CategoryCurso] ([CursosId]);
GO

CREATE UNIQUE INDEX [IX_Chapters_CursoID] ON [Chapters] ([CursoID]);
GO

CREATE INDEX [IX_CursoStudent_StudentsId] ON [CursoStudent] ([StudentsId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20221004215210_Migracion Clase 3', N'6.0.9');
GO

COMMIT;
GO

