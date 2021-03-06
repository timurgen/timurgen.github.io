with AWS.Config.Set;
with AWS.Services.Dispatchers.URI;
with AWS.Server;

with Main.Dispatchers;

procedure Main.Main is
   use AWS;

   Web_Server     : Server.HTTP;
   Web_Config     : Config.Object;
   Web_Dispatcher : Services.Dispatchers.URI.Handler;

   Default_Dispatcher : Dispatchers.Default;
   CSS_Dispatcher     : Dispatchers.CSS;
   Image_Dispatcher   : Dispatchers.Image;
   Js_Dispatcher      : Dispatchers.Js;

begin
   Config.Set.Server_Host (Web_Config, Host);
   Config.Set.Server_Port (Web_Config, Port);
   Config.Set.Max_Connection (Web_Config, 512);

   Dispatchers.Initialize (Web_Config);

   Services.Dispatchers.URI.Register
     (Web_Dispatcher, URI => "/assets/css", Action => CSS_Dispatcher,
      Prefix              => True);

   Services.Dispatchers.URI.Register
     (Web_Dispatcher, URI => "/assets/twitter-bootstrap/css/",
      Action              => CSS_Dispatcher, Prefix => True);

   Services.Dispatchers.URI.Register
     (Web_Dispatcher, URI => "/assets/font-awesome/css",
      Action              => CSS_Dispatcher, Prefix => True);

   Services.Dispatchers.URI.Register
     (Web_Dispatcher, URI => "/assets/img", Action => Image_Dispatcher,
      Prefix              => True);

   Services.Dispatchers.URI.Register
     (Web_Dispatcher, URI => "/assets/font-awesome/fonts", Action => Image_Dispatcher,
      Prefix              => True);

   Services.Dispatchers.URI.Register
     (Web_Dispatcher, URI => "/assets/js", Action => Js_Dispatcher,
      Prefix              => True);

   Services.Dispatchers.URI.Register
     (Web_Dispatcher, URI => "/assets/scrollReveal.js",
      Action              => Js_Dispatcher, Prefix => True);

   Services.Dispatchers.URI.Register_Default_Callback
     (Web_Dispatcher, Action => Default_Dispatcher);

   Server.Start (Web_Server, Web_Dispatcher, Web_Config);
   Server.Wait (Server.No_Server);
   Server.Shutdown (Web_Server);

end Main.Main;
