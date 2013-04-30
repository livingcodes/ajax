<%@ Page Language="C#" AutoEventWireup="true" 
   CodeBehind="user.aspx.cs" 
   Inherits="ajax.user_page" %>
<!DOCTYPE html>
<html>
<body>
   <a href="javascript:void(0)" id="void-noparam">void, no param</a>
   <br>
   <a href="javascript:void(0)" id="void-param">void, param</a>

   <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
   <script>
   $('#void-noparam').click(function() {
      $.ajax({
         url:'/user.aspx/void_noparam',
         type:'POST',
         success:function(msg) { alert('succeeded') },
         error:function(a,b,c) { alert(c) }
      })
   })
   
   $('#void-param').click(function () {
      $.ajax({
         url: '/user.aspx/void_param',
         type: 'POST',
         contentType: 'application/json; charset=utf-8',
         dataType: 'json',
         /* data: "{'user':'me'}", */ // json name must match parameter name
         /* data: "{'user':'{name:\"casey\"}'}", */ // still has escapes in it
         /* data: JSON.stringify({user:'you'}), */
         data: JSON.stringify({ user: JSON.stringify({ name: 'you' }) }),
         /* data: JSON.stringify({ user: { name: 'you' } }), */ //internal server error
         /* data: JSON.stringify({"user":{"name":"you"}}), */ // internal server error
         /* data: JSON.stringify({"user":{name:"you"}}), */ // internal server error
         success: function (msg) { alert('succeeded') },
         error: function (a, b, c) { alert(c) }
      })
   })

   </script>
</body>
</html>