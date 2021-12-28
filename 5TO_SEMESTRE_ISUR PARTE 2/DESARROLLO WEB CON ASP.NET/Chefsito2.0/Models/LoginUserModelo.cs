using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Chefsito2._0.Models
{
    public class LoginUserModelo
    {
        [Required(ErrorMessage = "El campo de correo electrónico es obligatorio.")]
        [EmailAddress]
        public string Email { get; set; }
        [Required(ErrorMessage = "El campo Contraseña es obligatorio.")]
        [DataType(DataType.Password)]
        public string Password { get; set; }
        [Display(Name = "Recuerdame")]
        public bool Recuerdame { get; set; }
    }
}
