using CrudNetCore5.Datos;
using CrudNetCore5.Models;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CrudNetCore5.Controllers
{
    public class LibrosController : Controller
    {
        private readonly ApplicationDbContext _context;

        public LibrosController(ApplicationDbContext context)
        {
            _context = context;
        }

        // HTTP Get Index
        public IActionResult Index()
        {
            IEnumerable<Libro> listLibros = _context.Libro;
            return View(listLibros);
        }
        // HTTP Get Create
        public IActionResult Create()
        {
            return View();
        }

        // HTTP Post Create
        [HttpPost]
        public IActionResult Create(Libro libro)
        {
            if (ModelState.IsValid)
            {
                _context.Libro.Add(libro);
                _context.SaveChanges();
                TempData["mensaje"] = "El libro se ha creado correctamente";
                return RedirectToAction("Index");
            }
            return View();
        }
    }
}
