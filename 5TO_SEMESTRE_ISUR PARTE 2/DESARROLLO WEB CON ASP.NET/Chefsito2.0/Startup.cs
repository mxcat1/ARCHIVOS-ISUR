using Chefsito2._0.Data;
using Chefsito2._0.Models;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Chefsito2._0
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            //Configuracion para la conexion ala abse de datos sqlserver
            services.AddDbContext<ApplicationDbContext>(options => options.UseSqlServer(Configuration.GetConnectionString("DefaultConnection")));

            //Agregado el metodo identitity para el login
            //Parallel usar un clase de descripcion de errores diferente
            services.AddIdentity<IdentityUser, IdentityRole>().AddErrorDescriber<ErroresCastellano>().AddEntityFrameworkStores<ApplicationDbContext>();

            
            //Personalizacion de la validacion dele login
            services.Configure<IdentityOptions>(opciones => 
            { 
                opciones.Password.RequiredLength = 8;
                opciones.Password.RequiredUniqueChars = 3;
                opciones.Password.RequireNonAlphanumeric = false;
            });
            //Autorizacion para crear y hacer otras cosas
            services.ConfigureApplicationCookie(options => options.LoginPath = "/Cuentas/LoginUsuario");


            services.AddControllersWithViews();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }
            app.UseHttpsRedirection();
            app.UseStaticFiles();

            //Espesificar que se use autenticacion
            app.UseAuthentication();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Recetas}/{action=Index}/{id?}");
            });
        }
    }
}
