using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Chefsito2._0.Models
{
    public class EditarRecetaModelo:RecetaModelo
    {
        public int Id { get; set; }

        public string RutaFotoExistente { get; set; }
    }
}
