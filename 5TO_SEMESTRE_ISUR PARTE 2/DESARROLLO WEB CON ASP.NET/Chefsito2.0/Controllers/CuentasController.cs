using Chefsito2._0.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Chefsito2._0.Controllers
{
    public class CuentasController : Controller
    {
        private readonly UserManager<IdentityUser> gestionarUsuario;
        private readonly SignInManager<IdentityUser> gestionarLogin;

        public CuentasController(UserManager<IdentityUser> gestionarUsuario, SignInManager<IdentityUser> gestionarLogin) 
        {
            this.gestionarUsuario = gestionarUsuario;
            this.gestionarLogin = gestionarLogin;
        }
        [HttpGet]
        [Route("Cuentas/RegistroUsuario")]
        public IActionResult RegistroUsuario()
        {
            if (gestionarLogin.IsSignedIn(User))
            {
                return Redirect("/"); ;
            }
            else
            {
                return View();
            }
        }
        [HttpPost]
        [Route("Cuentas/RegistroUsuario")]
        public async Task<IActionResult> RegistroUsuario(RegistroUserModel model)
        {
            if (ModelState.IsValid)
            {
                var usuario = new IdentityUser
                {
                    UserName = model.Email,
                    Email = model.Email
                };
                var resultado = await gestionarUsuario.CreateAsync(usuario, model.Password);

                if (resultado.Succeeded)
                {
                    await gestionarLogin.SignInAsync(usuario, isPersistent: false);
                    return RedirectToAction("index","recetas");
                }
                foreach (var error in resultado.Errors)
                {
                    ModelState.AddModelError(string.Empty, error.Description);
                }
            }
            return View(model);
        }

        [HttpGet]
        [Route("Cuentas/CerrarSesion")]
        public async Task<IActionResult> CerrarSession()
        {
            await gestionarLogin.SignOutAsync();
            return RedirectToAction("LoginUsuario", "Cuentas");
        }

        [HttpGet]
        [Route("Cuentas/LoginUsuario")]
        public IActionResult LoginUsuario()
        {
            if (gestionarLogin.IsSignedIn(User))
            {
                return Redirect("/"); ;
            }
            else
            {
                return View();
            }
                
        }

        [HttpPost]
        [Route("Cuentas/LoginUsuario")]
        public async Task<IActionResult> LoginUsuario(LoginUserModelo usuario)
        {
            if (ModelState.IsValid)
            {
                var resultado = await gestionarLogin.PasswordSignInAsync(usuario.Email, usuario.Password, usuario.Recuerdame, false);
                if (resultado.Succeeded)
                {
                    return RedirectToAction("index","Recetas");
                }
                ModelState.AddModelError(string.Empty, "Inicio de session no Valido");
            }
            return View(usuario);
        }
    }
}
