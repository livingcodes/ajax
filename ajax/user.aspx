<%@ Page Language="C#" AutoEventWireup="true" 
   CodeBehind="user.aspx.cs" 
   Inherits="ajax.user_page" %>
<!DOCTYPE html>
<html>
<body>
   <p><mark>contentType</mark> required for VS debugger to work</p>
   <p><mark>contentType</mark> required to prevent "success:" function's "data" parameter from having all html which is increases request size too much</p>
   <a href="javascript:void(0)" id="void-noparam">void, no param</a>
   <br>
   <a href="javascript:void(0)" id="void-param">void, param</a>
   <br>
   <a href="javascript:void(0)" id="void-param-list">void, param list</a>

   <script src="jquery-1.8.2.js"></script>
   <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
   <script>
   String.prototype.plug = function () {
      var args = arguments;
      return this.replace(/{(\d+)}/g, function (match, number) {
         return typeof args[number] != 'undefined'
               ? args[number]
               : match;
      });
   };

   $('#void-noparam').click(function() {
      $.ajax({
         url:'/user.aspx/void_noparam',
         type:'POST',
         success: function (data, status, request) { console.log(data); console.log(status); },
         contentType: 'application/json; charset=utf-8', 
         error:function(a,b,c) { alert(c) }
      })
   })

   $('#void-param').click(function() {
      var user = { name: "you" }
      var user2 = '{user:{0}}'.plug( JSON.stringify(user) )
      $.ajax({
         url: '/user.aspx/void_param_as_user',
         type: 'POST',
         contentType: 'application/json; charset=utf-8',
         dataType: 'json',
         //data: JSON.stringify({ user: JSON.stringify(user) }), // works
         data: JSON.stringify({ user: '{name:"you"}' }), // works
         //data: JSON.stringify(user2), // fails
         success: function(data, status) { console.log(status); },
         error: function(a, b, c) { console.log(a); console.log(b); console.log(c); }
      })
   })
   
   $('#void-param-list').click(function() {
      var users = []
      var user1 = { name: 'you' }
      var user2 = { name: 'me' }
      users.push(user1)
      users.push(user2)

      $.ajax({
         url: '/user.aspx/void_param_as_list_of_users',
         type: 'POST',
         contentType: 'application/json; charset=utf-8',
         dataType: 'json',
         /* data: "{'user':'me'}", */ // json name must match parameter name
         /* data: "{'user':'{name:\"casey\"}'}", */ // still has escapes in it
         /* data: JSON.stringify({user:'you'}), */
         /* data: JSON.stringify({ user: JSON.stringify({ name: 'you' }) }), */
         data: JSON.stringify({ users: JSON.stringify(users) }), // pass an array of json
         /* data: JSON.stringify({ user: { name: 'you' } }), */ //internal server error
         /* data: JSON.stringify({"user":{"name":"you"}}), */ // internal server error
         /* data: JSON.stringify({"user":{name:"you"}}), */ // internal server error
         /* data: JSON.stringify({ user: JSON.stringify(users) }),*/ // won't deserialize. don't need param name in front of every json object, only needed in front of array
         success: function (data, status) { console.log(data); console.log(status); },
         error: function (a, b, c) { alert(c) }
      })
   })

   </script>
</body>
</html>