using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Chefsito2._0.Migrations
{
    public partial class MigracionInicial : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Receta",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NombreReceta = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    DescripcionReceta = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: false),
                    ImagenReceta = table.Column<byte[]>(type: "varbinary(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Receta", x => x.Id);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Receta");
        }
    }
}
