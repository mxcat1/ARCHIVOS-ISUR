using Chefsito2._0.Data;
using Chefsito2._0.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace Chefsito2._0.Controllers
{
    public class RecetasController : Controller
    {
        private readonly ApplicationDbContext _context;
        private readonly IWebHostEnvironment _webHostEnvironment;

        public RecetasController(ApplicationDbContext context,IWebHostEnvironment webHostEnvironment)
        {
            _context = context;
            _webHostEnvironment = webHostEnvironment;
        }
        //Http get Index
        public IActionResult Index()
        {
            IEnumerable<Receta> listaRecetas = _context.Receta.Include(p=>p.Categoria).ToList();
            return View(listaRecetas);
        }
        //Http get Index
        public IActionResult RecetasBlog()
        {
            IEnumerable<Receta> listaRecetas = _context.Receta.Include(p => p.Categoria).ToList();
            return View(listaRecetas);
        }
        [HttpGet]
        public IActionResult RecetasBlogShow(int? id)
        {
            Receta receta = _context.Receta.Find(id);
            ViewData["Categoria"] = _context.Categoria.Find(receta.CategoriaFK);
            return View(receta);
        }
        [HttpGet]
        public IActionResult RecetasBusquedad()
        {
            IEnumerable<Receta> listaRecetas = _context.Receta.Include(p => p.Categoria).ToList();
            ViewData["Categoria"] = new SelectList(_context.Categoria, "Id", "NombreCategoria");
            return View(listaRecetas);
        }

        [HttpPost]
        public async Task<IActionResult> RecetasBusquedad(string buscarReceta=null, int categoriaBusquedad=0)
        {
            var recetas = from r in _context.Receta.Include(p => p.Categoria) select r;
            ViewData["Categoria"] = new SelectList(_context.Categoria, "Id", "NombreCategoria");
            if (!String.IsNullOrEmpty(buscarReceta))
            {
                recetas = recetas.Where(s=>s.NombreReceta.Contains(buscarReceta));
            }
            else
            {
                if (categoriaBusquedad!=0)
                {
                    recetas = recetas.Where(s => s.Categoria.Id==categoriaBusquedad);
                }
            }

            return View(await recetas.ToListAsync());
        }

        //Http get Create
        [Authorize]
        public IActionResult Create()
        {
            ViewData["Categoria"] = new SelectList(_context.Categoria,"Id","NombreCategoria") ;
            return View();
        }
        //Http post Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize]
        public IActionResult Create(RecetaModelo receta)
        {

            if (ModelState.IsValid)
            {
                string gImagen = null;
                if (receta.ImagenReceta != null)
                {
                    string ficheroimagen = Path.Combine(_webHostEnvironment.WebRootPath, "imagenes");
                    gImagen = Guid.NewGuid().ToString() + receta.ImagenReceta.FileName;
                    string Ruta = Path.Combine(ficheroimagen, gImagen);
                    receta.ImagenReceta.CopyTo(new FileStream(Ruta, FileMode.Create));
                }

                Receta nuevaReceta = new()
                {
                    NombreReceta = receta.NombreReceta,
                    DescripcionReceta = receta.DescripcionReceta,
                    IngredientesReceta = receta.IngredientesReceta,
                    DetalleReceta = receta.DetalleReceta,
                    CategoriaFK = receta.CategoriaFK,
                    ImagenReceta = gImagen
                };

                _context.Receta.Add(nuevaReceta);
                _context.SaveChanges();
                return Redirect("/");
            }
            return View();
        }

        //Http Get Edit
        [HttpGet]
        [Authorize]
        public ViewResult Edit(int? id)
        {
            ViewData["Categoria"] = new SelectList(_context.Categoria, "Id", "NombreCategoria");
            Receta receta = _context.Receta.Find(id);
            EditarRecetaModelo recetaEditar = new()
            {
                Id = receta.Id,
                NombreReceta = receta.NombreReceta,
                DescripcionReceta=receta.DescripcionReceta,
                IngredientesReceta = receta.IngredientesReceta,
                DetalleReceta=receta.DetalleReceta,
                CategoriaFK=receta.CategoriaFK,
                RutaFotoExistente=receta.ImagenReceta
            };
            return View(recetaEditar);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize]
        public IActionResult Edit(EditarRecetaModelo recetaeditar)
        {
            if (ModelState.IsValid)
            {
                Receta receta = _context.Receta.Find(recetaeditar.Id);

                receta.NombreReceta = recetaeditar.NombreReceta;
                receta.DescripcionReceta = recetaeditar.DescripcionReceta;
                receta.IngredientesReceta = recetaeditar.IngredientesReceta;
                receta.DetalleReceta = recetaeditar.DetalleReceta;
                receta.CategoriaFK = recetaeditar.CategoriaFK;

                if(recetaeditar.ImagenReceta != null)
                {
                    if (recetaeditar.RutaFotoExistente != null)
                    {
                        string ruta = Path.Combine(_webHostEnvironment.WebRootPath, "imagenes", recetaeditar.RutaFotoExistente);
                        System.IO.File.Delete(ruta);
                    }
                    receta.ImagenReceta = SubirImagen(recetaeditar);
                }
                _context.Receta.Update(receta);
                _context.SaveChanges();

                return Redirect("/");

            }
            return View(recetaeditar);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize]
        public IActionResult Delete(int id)
        {
            string ficheroimagen = Path.Combine(_webHostEnvironment.WebRootPath, "imagenes");
            string Ruta = Path.Combine(ficheroimagen, _context.Receta.Find(id).ImagenReceta.ToString());

            if (System.IO.File.Exists(Ruta) == true)
            {
                System.IO.File.Delete(Ruta);
            }

            _context.Receta.Remove(_context.Receta.Find(id));
            _context.SaveChanges();
            return RedirectToAction("Index");
        }


        public IActionResult MisRecetas()
        {
            IEnumerable<Receta> listaRecetas = _context.Receta;
            return View(listaRecetas);
        }


        //Funcion para subir Imganes
        private string SubirImagen(EditarRecetaModelo modelo)
        {
            string gImagen = null;
            if (modelo.ImagenReceta != null)
            {
                string ficheroimagen = Path.Combine(_webHostEnvironment.WebRootPath, "imagenes");
                gImagen = Guid.NewGuid().ToString() + modelo.ImagenReceta.FileName;
                string Ruta = Path.Combine(ficheroimagen, gImagen);
                modelo.ImagenReceta.CopyTo(new FileStream(Ruta, FileMode.Create));
            }
            return gImagen;
        }
    }
}
