with Ada.Calendar;
with Ada.Exceptions;
with Ada.IO_Exceptions;
with Ada.Integer_Text_IO;
with Ada.Text_IO;
with Gnat.Traceback.Symbolic; use Gnat;

with Antibiotics;
with Antibiogrammes;
with BCI_Messages; with BCI_Messages.IO;
with Cards;
with Common_Defs_BCI; use Common_Defs_BCI;
with Common_IO; use Common_IO;
with Dates; use Dates;
with Dates.IO;
with Dossiers;
with Germes;

with Gnoga.Application.Singleton;
with Gnoga.Gui.Base;
with Gnoga.Gui.Element.Common;
with Gnoga.Gui.Element.Form;
with Gnoga.Gui.Element.Table;
with Gnoga.Gui.Window;
with Gnoga.Gui.View;
with Gnoga.Types;

with Matricules;
with Medecins;
with Patients;
with PragmARC.Date_Handler;
with PragmARC.Images.Image;
with Samples;
with Services;

procedure Generateur_Trame_VT2_GUI is

   Generate_Button               : Gnoga.Gui.Element.Common.Button_Type;
   Quit_Button                   : Gnoga.Gui.Element.Common.Button_Type;

   How_Many_Form                 : Gnoga.Gui.Element.Form.Form_Type;
   How_Many                      : Gnoga.Gui.Element.Form.Text_Type;
   How_Many_Label                : Gnoga.Gui.Element.Form.Label_Type;

   Matricule_Form                : Gnoga.Gui.Element.Form.Form_Type;
   Input_Matricule               : Gnoga.Gui.Element.Form.Text_Type;
   Matricule_Label               : Gnoga.Gui.Element.Form.Label_Type;

   Dossier_Form                  : Gnoga.Gui.Element.Form.Form_Type;
   Input_Dossier                 : Gnoga.Gui.Element.Form.Text_Type;
   Dossier_Label                 : Gnoga.Gui.Element.Form.Label_Type;

   Culture_Form                  : Gnoga.Gui.Element.Form.Form_Type;
   Input_Culture                 : Gnoga.Gui.Element.Form.Text_Type;
   Culture_Label                 : Gnoga.Gui.Element.Form.Label_Type;

   procedure On_Quit (Object : in out Gnoga.Gui.Base.Base_Type'Class) is
      pragma Unreferenced (Object);
   begin
      Gnoga.Application.Singleton.End_Application;
   end On_Quit;

   ---------------
   -- File_Name --
   ---------------
   -- generates a file name with the following format:
   -- VITEK2-BCI_yymmdd_hhmmss_x.txt
   -- were yymmdd is the current date and
   -- hhmmss is the current time
   -- x is the number of the file to prevent overwriting if there is more than
   -- one file
   function File_Name (How_Many : in Positive) return String is

      Right_Now : Ada.Calendar.Time := Ada.Calendar.Clock;
      Year      : Ada.Calendar.Year_Number;
      Month     : Ada.Calendar.Month_Number;
      Day       : Ada.Calendar.Day_Number;
      Hour      : PragmARC.Date_Handler.Hour_Number;
      Minute    : PragmARC.Date_Handler.Minute_Number;
      Seconds   : PragmARC.Date_Handler.Minute_Duration;

   begin -- File_Name

      PragmARC.Date_Handler.Split (Date    => Right_Now,
                                   Year    => Year,
                                   Month   => Month,
                                   Day     => Day,
                                   Hour    => Hour,
                                   Minute  => Minute,
                                   Seconds => Seconds);

      return "VITEK2-BCI_" &
        PragmARC.Date_Handler.Year_Image_Short (Year) &
        PragmARC.Date_Handler.Month_Image_Numeric (Month) &
        PragmARC.Date_Handler.Day_Image (Day) &
        '_' &
        PragmARC.Date_Handler.Hour_Image_24 (Hour) &
        PragmARC.Date_Handler.Minute_Image (Minute) &
        PragmARC.Date_Handler.Seconds_Image (Seconds) &
        '_' &
        PragmARC.Images.Image (How_Many) &
        ".txt";

   end File_Name;

   --------------
   -- Generate --
   --------------
   procedure On_Generate (Object : in out Gnoga.Gui.Base.Base_Type'Class) is

      File     : Ada.Text_IO.File_Type;
      Log      : Ada.Text_IO.File_Type;

      Numero_Dossier : String (1 .. Dossiers.Max_Numero);

      Test_Matricule : Matricules.Object;
      Culture        : Antibiogrammes.Culture_Type;

   begin -- On_Generate

      Ada.Text_IO.Create (File => Log,
                          Mode => Ada.Text_IO.Out_File,
                          Name => "logfile.txt");

      Valid_Matricule : loop

         Handle_Matricule_Error : declare

         begin -- Handle_Matricule_Error
            Test_Matricule := Matricules.Make (Input_Matricule.Value);

            exit Valid_Matricule;

         exception -- Handle_Matricule_Error
            when Constraint_Error =>
               Matricule_Label.Text ("Format de matricule invalide, veuillez reessayer svp!");

         end Handle_Matricule_Error;
      end loop Valid_Matricule;

      Valid_Dossier   : loop

         Handle_Dossier_Error : declare

         begin -- Handle_Dossier_Error
            Numero_Dossier := Input_Dossier.Value;

            exit Valid_Dossier;

         exception -- Handle_Dossier_Error
            when Constraint_Error =>
               Dossier_Label.Text ("Format de dossier invalide, veuillez reessayer svp!");
         end Handle_Dossier_Error;
      end loop Valid_Dossier;

      Valid_Culture   : loop

         Handle_Culture_Error : declare

         begin -- Handle_Culture_Error
            Culture := Antibiogrammes.Culture_Type'Value (Input_Culture.Value);

            exit Valid_Culture;

         exception -- Handle_Culture_Error
            when Constraint_Error =>
               Culture_Label.Text ("Type de culture  invalide, veuillez reessayer svp!");
         end Handle_Culture_Error;
      end loop Valid_Culture;

      for Counter in 1 .. Positive'Value(How_Many.Value) loop
         declare

            Random_Card : Cards.Object := Cards.Make_Random;

            Random_Germe : Germes.Object := Germes.Make_Random;

            Card_From_Config : Cards.Object := Cards.Make_From_Config
              (Cards.Get_Code_SIL (Random_Card),

               Germe => Germes.Make
                 (Name     => Germes.Get_Name (Random_Germe),
                  Code_SIL => Germes.Get_Code_SIL (Random_Germe),
                  Isolat   => Counter));

            Test_Antibiogramme : Antibiogrammes.Object := Antibiogrammes.Make
              (Culture => Culture,
               Card    => Card_From_Config);

            Test_Patient     : Patients.Object := Patients.Make
              (ID => Test_Matricule);

            Test_Service     : Services.Object := Services.Make
              (Code_Service => 190);

            Test_Medecin     : Medecins.Object := Medecins.Make
              (Code_Medecin => 908256);

            Test_Sample : Samples.Object := Samples.Make
              (Sample_Code => (+"PP"));

            Test_Dossier     : Dossiers.Object := Dossiers.Make
              (Num_Dossier  => Numero_Dossier,
               Prescripteur => Test_Medecin,
               Service      => Test_Service,
               Patient      => Test_Patient,
               Sample       => Test_Sample,
               Resultat     => Test_Antibiogramme);

            Test_Message     : BCI_Messages.Object := BCI_Messages.Make
              (Dossier => Test_Dossier);

         begin -- declare

            Ada.Text_IO.Create (File => File,
                                Mode => Ada.Text_IO.Out_File,
                                Name => File_Name (Counter));

            BCI_Messages.IO.Put_To_Gnoga (File_Name => File_Name (Counter),
                                          Item      => Test_Message);

            BCI_Messages.IO.To_BCI (File => File,
                                    Item => Test_Message);

            BCI_Messages.IO.Put (File      => Log,
                                 File_Name => File_Name (Counter),
                                 Item      => Test_Message);

            Ada.Text_IO.Close (File);

         end; -- declare
      end loop;

      Ada.Text_IO.Close (Log);

   end On_Generate;

begin -- Generateur_Trame_VT2_GUI

   Gnoga.Application.Title ("Generateur Tram Vitek 2");

   Gnoga.Application.HTML_On_Close
     ("<b>Connection to Application has been terminated</b>");

   Gnoga.Application.Open_URL ("http://127.0.0.1:8080");
   Gnoga.Application.Singleton.Initialize (Main_Window, Port => 8080);

   Main_View.Create (Main_Window);
   Quit_Button.Create (Main_View, "Quitter");
   Quit_Button.On_Click_Handler (On_Quit'Unrestricted_Access);

   Main_View.New_Line;
   How_Many_Form.Create (Main_View);
   How_Many.Create (How_Many_Form, 40);
   How_Many_Label.Create (How_Many_Form, How_Many,
                          "Veuillez introduire le nombre de documents a generer: ");

   Matricule_Form.Create (Main_View);
   Input_Matricule.Create (Matricule_Form, 13);
   Matricule_Label.Create (Matricule_Form, Input_Matricule,
                           "Veuillez introduire la matricule: ");

   Dossier_Form.Create (Main_View);
   Input_Dossier.Create (Dossier_Form, 10);
   Dossier_Label.Create (Dossier_Form, Input_Dossier,
                         "Veuillez introduire le numero dossier: ");

   Culture_Form.Create (Main_View);
   Input_Culture.Create (Culture_Form, 10);
   Culture_Label.Create (Culture_Form, Input_Culture,
                         "Veuillez introduire le type de culture: ");

   Generate_Button.Create (Main_View, "Generer messages BCI");
   Generate_Button.On_Click_Handler (On_Generate'Unrestricted_Access);

   Gnoga.Application.Singleton.Message_Loop;

exception

   when Err : others =>
      Ada.Text_IO.Put_Line ("Oops: " &
                              Ada.Exceptions.Exception_Information (Err));

      Ada.Text_IO.Put_Line (Traceback.Symbolic.Symbolic_Traceback (Err));

end Generateur_Trame_VT2_GUI;
