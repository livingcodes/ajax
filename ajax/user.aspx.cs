using System;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Collections.Generic;

namespace ajax
{
public partial class user_page : Page
{
   [WebMethod] public static void void_noparam() {
      var a = "";
   }
   [WebMethod] public static void void_param(string user) {
      var usrs = new JavaScriptSerializer().Deserialize<List<user>>(user);
      var name = usrs.Count > 0;
   }

   public class user
   {
      public string name { get; set; }
   }
}
}