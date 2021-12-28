using Microsoft.EntityFrameworkCore.Migrations;

namespace Chefsito2._0.Migrations
{
    public partial class recetasfk : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "CategoriaFK",
                table: "Receta",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Receta_CategoriaFK",
                table: "Receta",
                column: "CategoriaFK");

            migrationBuilder.AddForeignKey(
                name: "FK_Receta_Categoria_CategoriaFK",
                table: "Receta",
                column: "CategoriaFK",
                principalTable: "Categoria",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Receta_Categoria_CategoriaFK",
                table: "Receta");

            migrationBuilder.DropIndex(
                name: "IX_Receta_CategoriaFK",
                table: "Receta");

            migrationBuilder.DropColumn(
                name: "CategoriaFK",
                table: "Receta");
        }
    }
}
