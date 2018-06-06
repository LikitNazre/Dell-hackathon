using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using HackathonTest.Data;

namespace HackathonTest.Controllers
{
    public class WebElementsController : Controller
    {
        private DellHackEntities db = new DellHackEntities();

        // GET: WebElements
        public ActionResult Index()
        {
            return View(db.WebElements.ToList());
        }

        // GET: WebElements/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: WebElements/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "IsMultipleElemets,ElementName,Locator,FindElementMachanism,InputType,InputData")] WebElement webElement)
        {
            if (ModelState.IsValid)
            {
                db.WebElements.Add(webElement);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(webElement);
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
