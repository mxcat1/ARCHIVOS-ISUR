BEGIN TRANSACTION;
GO

ALTER TABLE [Receta] ADD [IngredientesReceta] nvarchar(2000) NOT NULL DEFAULT N'';
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20210714004441_receta-agrego-detalle-ingredientes', N'5.0.6');
GO

COMMIT;
GO

