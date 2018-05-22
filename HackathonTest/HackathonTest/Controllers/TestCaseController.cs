using HackathonTest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace HackathonTest.Controllers
{
    public class TestCaseController : Controller
    {
        // GET: TestCase
        public ActionResult CreateTestCase()
        {
            return View();
        }

        public ActionResult ExecuteTestCase()
        {
            return View();
        }

        public ActionResult RunTestCase()
        {
            TestCaseExecution.ExecuteTestCase(2);
            return View();
        }
    }
}