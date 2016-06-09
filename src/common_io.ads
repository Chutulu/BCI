with Ada.Text_IO;
with Common_Defs_BCI; use Common_Defs_BCI;

with Gnoga.Application.Singleton;
with Gnoga.Gui.View.Console;
with Gnoga.Gui.Window;
with Gnoga.Gui.Base;
with Gnoga.Gui.Element.Common;

package Common_IO is

   Name_Too_Short : exception;
   Name_Too_Long  : exception;
   Array_Full     : exception;

   subtype Name_Type is Ub_S;
   subtype Code_Type is Ub_S;

   Main_Window : Gnoga.Gui.Window.Window_Type;
   Main_View   : Gnoga.Gui.View.Console.Console_View_Type;

   procedure Get (File      : in Ada.Text_IO.File_Type;
                  Item      : out Ub_S;
                  Item_Type : in String;
                  Max       : in Positive);

   procedure Get (Item      : out Ub_S;
                  Item_Type : in String;
                  Max       : in Positive);

end Common_IO;
