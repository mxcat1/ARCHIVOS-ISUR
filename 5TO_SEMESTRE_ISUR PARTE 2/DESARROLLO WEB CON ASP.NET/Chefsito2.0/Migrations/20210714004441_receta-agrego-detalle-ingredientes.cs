using Microsoft.EntityFrameworkCore.Migrations;

namespace Chefsito2._0.Migrations
{
    public partial class recetaagregodetalleingredientes : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "IngredientesReceta",
                table: "Receta",
                type: "nvarchar(2000)",
                maxLength: 2000,
                nullable: false,
                defaultValue: "");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IngredientesReceta",
                table: "Receta");
        }
    }
}
