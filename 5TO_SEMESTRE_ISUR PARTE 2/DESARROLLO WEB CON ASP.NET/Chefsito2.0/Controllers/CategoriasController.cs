using Chefsito2._0.Data;
using Chefsito2._0.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Chefsito2._0.Controllers
{
    [Authorize]
    public class CategoriasController : Controller
    {
        private readonly ApplicationDbContext _context;

        public CategoriasController(ApplicationDbContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            IEnumerable<Categoria> listaCategorias = _context.Categoria;
            return View(listaCategorias);
        }
        //Http get Create
        public IActionResult Create()
        {
            return View();
        }
        //Http post Create
        [HttpPost]
        public IActionResult Create(Categoria categoria)
        {

            if (ModelState.IsValid)
            {

                _context.Categoria.Add(categoria);
                _context.SaveChanges();
                return RedirectToAction("Index");
            }
            return View();
        }
        //Http Get Edit
        [HttpGet]
        [Authorize]
        public ViewResult Edit(int? id)
        {
            Categoria categoria = _context.Categoria.Find(id);
            return View(categoria);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize]
        public IActionResult Edit(Categoria categoriaeditar)
        {
            if (ModelState.IsValid)
            {
                _context.Categoria.Update(categoriaeditar);
                _context.SaveChanges();
                return RedirectToAction("Index");

            }
            return View(categoriaeditar);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize]
        public IActionResult Delete(int id)
        {
            _context.Categoria.Remove(_context.Categoria.Find(id));
            _context.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}
