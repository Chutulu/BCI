package body Samples.IO is

   ---------
   -- Put --
   ---------
   procedure Put (File : in Ada.Text_IO.File_Type;
                  Item : in Object) is
   begin -- Put
      Ada.Text_IO.Put (File => File,
                       Item => +Item.Sample_Code);
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
      Main_View.Put (+Item.Sample_Code);
   end Put_To_Gnoga;

   ------------
   -- To_BCI --
   ------------
   procedure To_BCI (Item : in Object;
                     File : in out Ada.Text_IO.File_Type) is

   begin

      Ada.Text_IO.Put (File => File, Item => "|ss");
      Ada.Text_IO.Put (File => File, Item => +Item.Sample_Code);
      Ada.Text_IO.Put (File => File, Item => "|s5");
      Ada.Text_IO.Put (File => File, Item => +Item.Sample_Code);

   end To_BCI;

end Samples.IO;
