using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Chefsito2._0.Models
{
    public class Receta
    {
        [Key]
        public int Id { get; set; }

        [Required(ErrorMessage ="El Nombre de la Receta es obligatorio")]
        [StringLength(50,ErrorMessage ="El {0} debe ser al menos {2} y maximo {1} caracteres",MinimumLength =3)]
        [Display(Name ="Titulo de la Receta")]
        public string NombreReceta { get; set; }

        [Required(ErrorMessage = "La Decripcion de la Receta es obligatorio")]
        [StringLength(250, ErrorMessage = "El {0} debe ser al menos {2} y maximo {1} caracteres", MinimumLength = 10)]
        [Display(Name = "Descripcion de la Receta")]
        public string DescripcionReceta { get; set; }

        [Required(ErrorMessage = "La Preparacion de la Receta es obligatorio")]
        [StringLength(2000, ErrorMessage = "El {0} debe ser al menos {2} y maximo {1} caracteres", MinimumLength = 10)]
        [Display(Name = "Preparacion de la Receta")]
        public string DetalleReceta { get; set; }

        [Required(ErrorMessage = "Los Ingredientes de la Receta son obligatorios")]
        [StringLength(2000, ErrorMessage = "El {0} debe ser al menos {2} y maximo {1} caracteres", MinimumLength = 10)]
        [Display(Name = "Ingredientes de la Receta")]
        public string IngredientesReceta { get; set; }

        [ForeignKey("Categoria")]
        public int CategoriaFK { get; set; }
        public Categoria Categoria { get; set; }

        [Required(ErrorMessage = "La Imagen de la Receta es obligatorio")]
        [Display(Name = "Imagen de la Receta")]
        public string ImagenReceta { get; set; }
    }
}
