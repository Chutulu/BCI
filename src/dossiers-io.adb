package body Dossiers.IO is

   ---------
   -- Put --
   ---------
   procedure Put (File : Ada.Text_IO.File_Type;
                  Item : Object) is

   begin -- Put

      Ada.Text_IO.Put (File => File,
                       Item => "Matricule du patient: ");

      Patients.IO.Put (File => File,
                       Item => Item.Patient);

      Ada.Text_IO.New_Line (File);

      Ada.Text_IO.Put (File => File,
                       Item => "Code SIL du Service: ");

      Services.IO.Put (File => File,
                       Item => Item.Service);

      Ada.Text_IO.New_Line (File);

      Ada.Text_IO.Put (File => File,
                       Item => "Code medecin prescripteur: ");

      Medecins.IO.Put (File => File,
                       Item => Item.Prescripteur);

      Ada.Text_IO.New_Line (File);

      Ada.Text_IO.Put (File => File,
                       Item => "Code SIL prelevement: ");

      Samples.IO.Put (File => File,
                      Item => Item.Sample);

      Ada.Text_IO.New_Line (File);

      Ada.Text_IO.Put (File => File,
                       Item => "Numero dossier: ");

      Ada.Integer_Text_IO.Put (File => File,
                               Item  => Item.Index,
                               Width => 0);

      Ada.Text_IO.Put (File  => File,
                       Item  => Item.Numero_Dossier);

      Ada.Text_IO.New_Line (File);

      Antibiogrammes.IO.Put (File => File, Item => Item.Resultat);

   end Put;

   ---------
   -- Put --
   ---------
   procedure Put (Item : Object) is

   begin -- Put

      Put (File => Ada.Text_IO.Standard_Output,
           Item => Item);

   end Put;

   ------------------
   -- Put_To_Gnoga --
   ------------------
   procedure Put_To_Gnoga (Item : Object) is

   begin -- Put_To_Gnoga

      Main_View.Put ("Matricule du patient: ");
      Patients.IO.Put_To_Gnoga (Item.Patient);

      Main_View.New_Line;

      Main_View.Put ("Code SIL du Service: ");
      Services.IO.Put_To_Gnoga (Item.Service);

      Main_View.New_Line;

      Main_View.Put ("Code medecin prescripteur: ");
      Medecins.IO.Put_To_Gnoga (Item.Prescripteur);

      Main_View.New_Line;

      Main_View.Put ("Code SIL prelevement: ");
      Samples.IO.Put_To_Gnoga (Item.Sample);

      Main_View.New_Line;

      Main_View.Put ("Numero dossier: ");
      Main_View.Put (Item.Index'Img);
      Main_View.Put (Item.Numero_Dossier);

      Main_View.New_Line;

      Antibiogrammes.IO.Put_To_Gnoga (Item => Item.Resultat);

   end Put_To_Gnoga;

   ------------
   -- To_BCI --
   ------------
   procedure To_BCI (Item : Object;
                     File : in out Ada.Text_IO.File_Type) is
   begin

      Ada.Text_IO.Put (File => File, Item => "|pi");

      Patients.IO.To_BCI (File => File, Item => Item.Patient);

      Services.IO.To_BCI (File => File, Item => Item.Service);

      Medecins.IO.To_BCI (File => File, Item => Item.Prescripteur);

      Samples.IO.To_BCI (File => File, Item => Item.Sample);

      Ada.Text_IO.Put (File => File, Item => "|ci");

      Ada.Integer_Text_IO.Put (File => File, Item => Item.Index, Width => 1);

      Ada.Text_IO.Put (File => File,
                       Item => Item.Numero_Dossier);

      Antibiogrammes.IO.To_BCI (File => File, Item => Item.Resultat);

   end To_BCI;

end Dossiers.IO;
