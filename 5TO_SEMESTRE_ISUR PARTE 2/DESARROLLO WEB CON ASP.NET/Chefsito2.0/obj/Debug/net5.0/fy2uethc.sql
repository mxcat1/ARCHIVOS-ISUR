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

CREATE TABLE [Receta] (
    [Id] int NOT NULL IDENTITY,
    [NombreReceta] nvarchar(50) NOT NULL,
    [DescripcionReceta] nvarchar(250) NOT NULL,
    [ImagenReceta] varbinary(max) NOT NULL,
    CONSTRAINT [PK_Receta] PRIMARY KEY ([Id])
);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20210512025754_MigracionInicial', N'5.0.6');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DECLARE @var0 sysname;
SELECT @var0 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Receta]') AND [c].[name] = N'ImagenReceta');
IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [Receta] DROP CONSTRAINT [' + @var0 + '];');
ALTER TABLE [Receta] ALTER COLUMN [ImagenReceta] nvarchar(max) NOT NULL;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20210512042917_rutafoto', N'5.0.6');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20210514234845_add-migration migracioncategorias', N'5.0.6');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20210514234952_add-migration categoria', N'5.0.6');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20210514235040_categoria', N'5.0.6');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [Categoria] (
    [Id] int NOT NULL IDENTITY,
    [NombreCategoria] nvarchar(50) NOT NULL,
    CONSTRAINT [PK_Categoria] PRIMARY KEY ([Id])
);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20210514235117_categoria2', N'5.0.6');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Receta] ADD [CategoriaFK] int NOT NULL DEFAULT 1;
GO

CREATE INDEX [IX_Receta_CategoriaFK] ON [Receta] ([CategoriaFK]);
GO

ALTER TABLE [Receta] ADD CONSTRAINT [FK_Receta_Categoria_CategoriaFK] FOREIGN KEY ([CategoriaFK]) REFERENCES [Categoria] ([Id]) ON DELETE CASCADE;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20210622203714_recetasfk', N'5.0.6');
GO

COMMIT;
GO

