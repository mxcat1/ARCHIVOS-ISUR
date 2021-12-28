using Microsoft.EntityFrameworkCore.Migrations;

namespace Chefsito2._0.Migrations
{
    public partial class recetaagregodetalle : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "DetalleReceta",
                table: "Receta",
                type: "nvarchar(2000)",
                maxLength: 2000,
                nullable: false,
                defaultValue: "");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DetalleReceta",
                table: "Receta");
        }
    }
}
