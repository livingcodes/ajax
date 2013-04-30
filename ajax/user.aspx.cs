using System;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;

namespace ajax
{
public partial class user_page : Page
{
   [WebMethod] public static void void_noparam() {
      var a = "";
   }
   [WebMethod] public static void void_param(string user) {
      var usr = new JavaScriptSerializer().Deserialize<user>(user);
      var name = usr.name;
   }

   public class user
   {
      public string name { get; set; }
   }
}
}