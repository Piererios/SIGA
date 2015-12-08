using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using SIGA_Model;

namespace SIGA_WebApplication.Controllers
{
    public class ReciboController : Controller
    {
        private SIGAEntities db = new SIGAEntities();

        // GET: Recibo
        public ActionResult Index()
        {
            var recibo = db.Recibo.Include(r => r.Alumno).Include(r => r.Curso).Include(r => r.Modulo);
            return View(recibo.ToList());
        }

        // GET: Recibo/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Recibo recibo = db.Recibo.Find(id);
            if (recibo == null)
            {
                return HttpNotFound();
            }

            recibo.Alu_Id = db.Alumno.Where(a => a.Alu_Id == recibo.Alu_Id).Select(c => c.User_Id).SingleOrDefault();

            var alumno = (from u in db.Usuario
                          join p in db.Persona
                          on u.Per_Id equals p.Per_Id
                          where u.TipoUser_Id == 1 && u.User_Id == recibo.Alu_Id
                          select new AlumnoMatriForDDL { AluNombre = p.Per_Nombre + " " + p.Per_ApePaterno + " " + p.Per_ApeMaterno }).SingleOrDefault();

            ViewBag.AlumnoNombre = alumno.AluNombre;

            return View(recibo);
        }

        // GET: Recibo/Create
        public ActionResult Create()
        {

            var alumnos = (from u in db.Usuario
                           join p in db.Persona
                           on u.Per_Id equals p.Per_Id
                           where u.TipoUser_Id == 1
                           select new AlumnoReciForDDL { Alu_Id = u.User_Id, AluNombre = p.Per_Nombre + " " + p.Per_ApePaterno + " " + p.Per_ApeMaterno }).ToList();

            ViewBag.Alu_Id = new SelectList(alumnos, "Alu_Id", "AluNombre");
            ViewBag.CurId = new SelectList(db.Curso, "CurId", "CurName");
            ViewBag.ModId = new SelectList(db.Modulo, "ModId", "ModNombre");
            return View();
        }

        // POST: Recibo/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "RecId,Alu_Id,ModId,CurId,FechaRegistro,Descripcion")] Recibo recibo)
        {
            if (ModelState.IsValid)
            {

                recibo.Alu_Id = db.Alumno.Where(a => a.User_Id == recibo.Alu_Id).Select(c => c.Alu_Id).SingleOrDefault();

                db.Recibo.Add(recibo);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            var alumnos = (from u in db.Usuario
                           join p in db.Persona
                           on u.Per_Id equals p.Per_Id
                           where u.TipoUser_Id == 1
                           select new AlumnoReciForDDL { Alu_Id = u.User_Id, AluNombre = p.Per_Nombre + " " + p.Per_ApePaterno + " " + p.Per_ApeMaterno }).ToList();

            ViewBag.Alu_Id = new SelectList(alumnos, "Alu_Id", "AluNombre", recibo.Alu_Id);
            ViewBag.CurId = new SelectList(db.Curso, "CurId", "CurName", recibo.CurId);
            ViewBag.ModId = new SelectList(db.Modulo, "ModId", "ModNombre", recibo.ModId);
            return View(recibo);
        }

        // GET: Recibo/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Recibo recibo = db.Recibo.Find(id);
            if (recibo == null)
            {
                return HttpNotFound();
            }

            recibo.Alu_Id = db.Alumno.Where(a => a.Alu_Id == recibo.Alu_Id).Select(c => c.User_Id).SingleOrDefault();

            var alumnos = (from u in db.Usuario
                           join p in db.Persona
                           on u.Per_Id equals p.Per_Id
                           where u.TipoUser_Id == 1
                           select new AlumnoReciForDDL { Alu_Id = u.User_Id, AluNombre = p.Per_Nombre + " " + p.Per_ApePaterno + " " + p.Per_ApeMaterno }).ToList();

            ViewBag.Alu_Id = new SelectList(alumnos, "Alu_Id", "AluNombre", recibo.Alu_Id);
            ViewBag.CurId = new SelectList(db.Curso, "CurId", "CurName", recibo.CurId);
            ViewBag.ModId = new SelectList(db.Modulo, "ModId", "ModNombre", recibo.ModId);
            return View(recibo);
        }

        // POST: Recibo/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "RecId,Alu_Id,ModId,CurId,FechaRegistro,Descripcion")] Recibo recibo)
        {

            recibo.Alu_Id = db.Alumno.Where(a => a.User_Id == recibo.Alu_Id).Select(c => c.Alu_Id).SingleOrDefault();
            
            if (ModelState.IsValid)
            {
                db.Entry(recibo).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            var alumnos = (from u in db.Usuario
                           join p in db.Persona
                           on u.Per_Id equals p.Per_Id
                           where u.TipoUser_Id == 1
                           select new AlumnoReciForDDL { Alu_Id = u.User_Id, AluNombre = p.Per_Nombre + " " + p.Per_ApePaterno + " " + p.Per_ApeMaterno }).ToList();

            ViewBag.Alu_Id = new SelectList(alumnos, "Alu_Id", "AluNombre", recibo.Alu_Id);
            ViewBag.CurId = new SelectList(db.Curso, "CurId", "CurName", recibo.CurId);
            ViewBag.ModId = new SelectList(db.Modulo, "ModId", "ModNombre", recibo.ModId);
            return View(recibo);
        }

        // GET: Recibo/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Recibo recibo = db.Recibo.Find(id);
            if (recibo == null)
            {
                return HttpNotFound();
            }

            recibo.Alu_Id = db.Alumno.Where(a => a.Alu_Id == recibo.Alu_Id).Select(c => c.User_Id).SingleOrDefault();

            var alumno = (from u in db.Usuario
                          join p in db.Persona
                          on u.Per_Id equals p.Per_Id
                          where u.TipoUser_Id == 1 && u.User_Id == recibo.Alu_Id
                          select new AlumnoReciForDDL { AluNombre = p.Per_Nombre + " " + p.Per_ApePaterno + " " + p.Per_ApeMaterno }).SingleOrDefault();

            ViewBag.AlumnoNombre = alumno.AluNombre;

            return View(recibo);
        }

        // POST: Recibo/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Recibo recibo = db.Recibo.Find(id);
            db.Recibo.Remove(recibo);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }

    public class AlumnoReciForDDL
    {
        public int Alu_Id { get; set; }
        public string AluNombre { get; set; }
    }

}
