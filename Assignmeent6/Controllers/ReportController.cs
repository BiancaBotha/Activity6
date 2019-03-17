using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Dynamic; // add
using System.Net;
using System.Net.Http;
using System.Data.Entity;
using System.Web.Http;
// school 
using System.Web.Http.Cors;
using System.IO;
using CrystalDecisions.CrystalReports.Engine;
using System.Web.Hosting;
using System.Net.Http.Headers;
// grade report
using System.Data;
using Assignmeent6.Models;
using HttpGetAttribute = System.Web.Http.HttpGetAttribute;
using HttpPostAttribute = System.Web.Http.HttpPostAttribute;

namespace Assignmeent6.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class ReportController : ApiController
    {
        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [System.Web.Mvc.Route("api/Reports/getReportData")]
        [HttpGet]
        public dynamic getReportData(int courseSelection)
        {
            NewSales2Entities db = new NewSales2Entities();
            db.Configuration.ProxyCreationEnabled = false;
            List<Order> orders;

            if (courseSelection == 1) // total bought per customer per store 
            {
                orders = db.Orders.Include(x => x.Customer).Include(x => x.Store).Where(x => x.StoreId == 1).ToList();
            }
            else if (courseSelection == 2)
            {
                orders = db.Orders.Include(x => x.Customer).Include(x => x.Store).Where(x => x.StoreId == 2).ToList();// online 
            }
            else// both ??? 
            {
                orders = orders = db.Orders.Include(x => x.Customer).Include(x => x.Store).Where(x => x.StoreId == 1).Include(x => x.Customer).Include(x => x.Store).Where(x => x.StoreId == 2).ToList();
            }

            return getExpandoReport(orders);
            
        }

        // for the chart display
        private dynamic getExpandoReport(List<Order> orders)
        {
            dynamic outObject = new ExpandoObject();
            var storeList = orders.GroupBy(o => o.Store);
            var deps = new List<dynamic>();
            foreach (var group in storeList)
            {
                dynamic store = new ExpandoObject();
                store.Name = group.Key; 
                store.Average = group.Average(x => x.TotalAmount);
                deps.Add(store);
            }

            outObject.Stores = deps;
            // for the list display
            var customerList = orders.GroupBy(o => o.Customer);
            var cust = new List<dynamic>();
            foreach( var group in customerList)
            {
                dynamic customer = new ExpandoObject();
                customer.Name = group.Key;
                customer.Total = group.Sum(x => x.TotalAmount);
                cust.Add(customer);
            }


            outObject.Customers = cust;
            return outObject;
        }
        
    }

    //[System.Web.Mvc.Route("api/Reports/DownloadReport")]
    //[HttpPost]
    //public HttpResponseMessage DownloadReport(int storeselection, int type)
    //{
    //    HttpResponseMessage httpResponseMessage = new HttpResponseMessage();
    //    NewSales2Entities db = new NewSales2Entities();
    //    db.Configuration.ProxyCreationEnabled = false;
    //    List<Order> orders;

    //    if (storeselection == 1) // centurion 
    //    {
    //        orders = db.Orders.Include(x => x.Customer).Include(x => x.Store).Where(x => x.StoreId == 1).ToList();
    //    }
    //    else
    //    {
    //        orders = db.Orders.Include(x => x.Customer).Include(x => x.Store).Where(x => x.StoreId == 2).ToList();// online 
    //    }

    //    //return getordersFile(orders, type)


    //}

}