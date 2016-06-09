package body BCI_Messages.IO is

   ---------
   -- Put --
   ---------
   procedure Put (File : Ada.Text_IO.File_Type;
                  File_Name : String;
                  Item : Object) is
   begin -- Put
      Ada.Text_IO.Put_Line (File => File,
                            Item => File_Name);

      Dossiers.IO.Put (File => File,
                       Item => Item.Dossier);
   end Put;

   ---------
   -- Put --
   ---------
   procedure Put (File_Name : String;
                  Item : Object) is
   begin -- Put
      Put (File      => Ada.Text_IO.Standard_Output,
           File_Name => File_Name,
           Item      => Item);
   end Put;

      ------------------
   -- Put_To_Gnoga --
   ------------------
   procedure Put_To_Gnoga (File_Name : String;
                           Item      : Object) is
   begin -- Put_To_Gnoga
      Main_View.Put_Line (File_Name);

      Dossiers.IO.Put_To_Gnoga (Item.Dossier);
   end Put_To_Gnoga;

   ------------
   -- To_BCI --
   ------------
   procedure To_BCI (Item : Object;
                     File : in out Ada.Text_IO.File_Type) is
   begin
      Ada.Text_IO.Put (File => File, Item => "mtrsl");
      Dossiers.IO.To_BCI (File => File, Item => Item.Dossier);
      Ada.Text_IO.Put (File => File, Item => "|zz|");
   end To_BCI;

end BCI_Messages.IO;
