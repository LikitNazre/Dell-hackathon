using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using HackathonTest.Data;

namespace HackathonTest.Controllers
{
    public class TestCasesController : Controller
    {
        private HackathonEntities db = new HackathonEntities();

        // GET: TestCases
        public ActionResult Index()
        {
            return View(db.TestCases.ToList());
        }

        // GET: TestCases/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TestCase testCase = db.TestCases.Find(id);
            if (testCase == null)
            {
                return HttpNotFound();
            }
            return View(testCase);
        }

        // GET: TestCases/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: TestCases/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "TestCaseName,LastRunStatus,IsExecuted")] TestCase testCase)
        {
            if (ModelState.IsValid)
            {
                var TestCaseName = new SqlParameter("@TestCaseName", testCase.TestCaseName);
                var IsExecuted = new SqlParameter("@IsExecuted", testCase.IsExecuted);
                var LastRunStatus = new SqlParameter("@LastRunStatus", testCase.LastRunStatus);

                using (var db = new HackathonEntities())
                {
                    db.Database.ExecuteSqlCommand("exec dbo.InsertTestCases @TestCaseName,@IsExecuted,@LastRunStatus",TestCaseName,IsExecuted,LastRunStatus);
                }
                    //db.TestCases.Add(testCase);
                    //db.SaveChanges();
                    return CreateTestCase(1);
                //return RedirectToAction("Index");
            }

            return View(testCase);
        }

        public ActionResult CreateTestCase(int testCaseId=0)
        {
            var testCases = new DataTable();
            testCases.Columns.Add("TestCaseId",typeof(int));
            testCases.Columns.Add("WebEleId", typeof(int));
            testCases.Columns.Add("TestCaseStepSequence",typeof(int));
            testCases.Columns.Add("StepDescription",typeof(string));

            testCases.Rows.Add(testCaseId, 1, 1, "AddToCart");
            testCases.Rows.Add(testCaseId, 2, 2, "Checkout");

            var parameter = new SqlParameter("@Values", SqlDbType.Structured);
            parameter.Value = testCases;
            parameter.TypeName = "dbo.TestCaseSteps";

            using (var db = new HackathonEntities())
            {
                db.Database.ExecuteSqlCommand("exec dbo.InsertTestCaseExecution @Values", testCases);
            }

                return View();
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
