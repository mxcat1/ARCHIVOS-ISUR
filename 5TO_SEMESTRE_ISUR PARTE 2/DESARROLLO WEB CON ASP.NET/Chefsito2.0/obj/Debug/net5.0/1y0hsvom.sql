BEGIN TRANSACTION;
GO

ALTER TABLE [Receta] ADD [DetalleReceta] nvarchar(2000) NOT NULL DEFAULT N'';
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20210714001640_receta-agrego-detalle', N'5.0.6');
GO

COMMIT;
GO

