package body Patients.IO is

   ---------
   -- Put --
   ---------
   procedure Put (File : in Ada.Text_IO.File_Type;
                  Item : in Object) is
   begin -- Put
      Matricules.IO.Put (File => File,
                         Item => Item.Patient_ID);
   end Put;

   ---------
   -- Put --
   ---------
   procedure Put (Item : in Object) is
   begin -- Put
      Matricules.IO.Put (Item.Patient_ID);
   end Put;

   ------------------
   -- Put_To_Gnoga --
   ------------------
   procedure Put_To_Gnoga (Item : in Object) is
   begin -- Put_To_Gnoga
      Matricules.IO.Put_To_Gnoga (Item.Patient_ID);
   end Put_To_Gnoga;

   ------------
   -- To_BCI --
   ------------
   procedure To_BCI (Item : in Object;
                     File : in out Ada.Text_IO.File_Type) is
   begin

      Matricules.IO.To_BCI (Item => Item.Patient_ID,
                            File => File);
   end To_BCI;

end Patients.IO;
