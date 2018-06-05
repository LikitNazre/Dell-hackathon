using HackathonTest.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace HackathonTest.Controllers
{
    public class WebElementController : Controller
    {
        // GET: WebElement
        [HttpGet]
        public ActionResult CreateWebElement()
        {
            return View();
        }

        [HttpGet]
        public ActionResult CreateWebElements()
        {
            return View();
        }
    }
}