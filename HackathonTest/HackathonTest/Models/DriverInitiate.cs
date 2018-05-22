using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Firefox;
using OpenQA.Selenium.IE;
using OpenQA.Selenium.Remote;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Web;

namespace HackathonTest.Models
{
    public class DriverInitiate
    {
        IWebDriver _driver;

        public DriverInitiate()
        {
            _driver = GetWebDriver();
        }

        private string GetDriverPath()
        {
            var path = Path.GetDirectoryName(Assembly.GetExecutingAssembly().CodeBase.Replace("file:///", ""));
            path += @"\Drivers";
            return path;
        }

        private IWebDriver GetWebDriver()
        {
            IWebDriver driver;
            var driverPath = GetDriverPath();
            var browser = ConfigurationManager.AppSettings["Browser"];
            switch (browser)
            {
                case "Chrome":
                    driver = new ChromeDriver(driverPath);
                    break;
                default:
                    driver = new ChromeDriver(driverPath);
                    break;
            }
            return driver;
        }
    }
}