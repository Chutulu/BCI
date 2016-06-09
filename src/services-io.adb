package body Services.IO is

   ---------
   -- Put --
   ---------
   procedure Put (File : in Ada.Text_IO.File_Type;
                  Item : in Object) is
   begin -- Put
      Ada.Integer_Text_IO.Put (File => File,
                               Item  => Item.Code_Service,
                               Width => 0);
   end Put;

   ---------
   -- Put --
   ---------
   procedure Put (Item : in Object) is
   begin -- Put
      Put (File => Ada.Text_IO.Standard_Output,
           Item => Item);
   end Put;

   ------------------
   -- Put_To_Gnoga --
   ------------------
   procedure Put_To_Gnoga (Item : in Object) is
   begin -- Put_To_Gnoga
      Main_View.Put (Item.Code_Service'Img);
   end Put_To_Gnoga;

   ------------
   -- To_BCI --
   ------------
   procedure To_BCI (Item : in Object;
                     File : in out Ada.Text_IO.File_Type) is
   begin
      Ada.Text_IO.Put (File => File, Item => "|p2");
      Ada.Integer_Text_IO.Put (File => File, Item => Item.Code_Service, Width => 0);
   end To_BCI;

end Services.IO;
