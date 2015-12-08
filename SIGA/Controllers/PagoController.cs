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
    public class PagoController : Controller
    {
        private SIGAEntities db = new SIGAEntities();

        // GET: Pago
        public ActionResult Index()
        {
            var pago = db.Pago.Include(p => p.Recibo);
            return View(pago.ToList());
        }

        // GET: Pago/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Pago pago = db.Pago.Find(id);
            if (pago == null)
            {
                return HttpNotFound();
            }

            return View(pago);
        }

        // GET: Pago/Create
        public ActionResult Create()
        {
            ViewBag.RecId = new SelectList(db.Recibo, "RecId", "Descripcion");
            return View();
        }

        // POST: Pago/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "PagoId,RecId,PagoFecha,PagoDescuento,PagoMonto,Descripcion")] Pago pago)
        {
            if (ModelState.IsValid)
            {
                db.Pago.Add(pago);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.RecId = new SelectList(db.Recibo, "RecId", "Nota", pago.RecId);
            return View(pago);
        }

        // GET: Pago/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Pago pago = db.Pago.Find(id);
            if (pago == null)
            {
                return HttpNotFound();
            }
            ViewBag.RecId = new SelectList(db.Recibo, "RecId", "RecId", pago.RecId);
            return View(pago);
        }

        // POST: Pago/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "PagoId,RecId,PagoFecha,PagoDescuento,PagoMonto,Descripcion")] Pago pago)
        {
            if (ModelState.IsValid)
            {
                db.Entry(pago).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.RecId = new SelectList(db.Recibo, "RecId", "Nota", pago.RecId);
            return View(pago);
        }

        // GET: Pago/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Pago pago = db.Pago.Find(id);
            if (pago == null)
            {
                return HttpNotFound();
            }
            return View(pago);
        }

        // POST: Pago/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Pago pago = db.Pago.Find(id);
            db.Pago.Remove(pago);
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

}
