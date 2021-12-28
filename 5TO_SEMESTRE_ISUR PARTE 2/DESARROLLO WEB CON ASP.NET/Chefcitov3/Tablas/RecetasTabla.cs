using Postgrest.Attributes;
using Postgrest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Chefcitov3.Tablas
{
    [Table("recetas")]
    public class RecetasTabla:BaseModel
    {
        [PrimaryKey("id")]
        public int Id { get; set; }

        [Column("nombreReceta")]
        public string NombreReceta { get; set; }

        [Column("descripcionReceta")]
        public string DescripcionReceta { get; set; }
        [Column("imagenReceta")]
        public string ImagenReceta { get; set; }
    }
}
