package body Medecins.IO is

   ---------
   -- Put --
   ---------
   procedure Put (File : in Ada.Text_IO.File_Type;
                  Item : in Object) is
   begin
      Ada.Integer_Text_IO.Put (File => File,
                               Item  => Item.Code_Medecin,
                               Width => 0);
   end Put;

   ---------
   -- Put --
   ---------
   procedure Put (Item : in Object) is
   begin
      Put (File => Ada.Text_IO.Standard_Output,
           Item => Item);
   end Put;

   ------------------
   -- Put_To_Gnoga --
   ------------------
   procedure Put_To_Gnoga (Item : in Object) is
   begin
      Main_View.Put (Item.Code_Medecin'Img);
   end Put_To_Gnoga;

   ------------
   -- To_BCI --
   ------------
   procedure To_BCI (Item : in Object;
                     File : in out Ada.Text_IO.File_Type) is
   begin
      Ada.Text_IO.Put (File => File, Item => "|pp");
      Ada.Integer_Text_IO.Put (File => File, Item => Item.Code_Medecin, Width => 0);
      Ada.Text_IO.Put (File => File, Item => "|p5");
      Ada.Integer_Text_IO.Put (File => File, Item => Item.Code_Medecin, Width => 0);
   end To_BCI;

end Medecins.IO;
