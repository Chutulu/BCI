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
with Dates; use Dates;
with Dates.IO;
with Dossiers;
with Germes;
with Matricules;
with Medecins;
with Patients;
with PragmARC.Date_Handler;
with PragmARC.Images.Image;
with Samples;
with Services;

procedure Generateur_Trame_VT2 is

   ---------------
   -- File_Name --
   ---------------
   -- generates a file name with the following format:
   -- VITEK2-BCI_yymmdd_hhmmss_x.txt
   -- were yymmdd is the current date and
   -- hhmmss is the current time
   -- x is the number of the file to prevent overwriting if there is more than
   -- one file
   function File_Name (How_Many : Positive) return String is

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
   procedure Generate is

      File     : Ada.Text_IO.File_Type;
      Log      : Ada.Text_IO.File_Type;

      How_Many : Positive := 1;
      Numero_Dossier : String (1 .. Dossiers.Max_Numero);

      Test_Matricule : Matricules.Object;
      Culture        : Antibiogrammes.Culture_Type;

   begin -- Generate

      Ada.Text_IO.Create (File => Log,
                          Mode => Ada.Text_IO.Out_File,
                          Name => "logfile.txt");

      Ada.Text_IO.Put ("Veuillez introduire le nombre de documents a generer: ");
      Ada.Integer_Text_IO.Get (How_Many);
      Ada.Text_IO.Skip_Line;

      Valid_Matricule : loop
         Ada.Text_IO.Put ("Veuillez introduire la matricule: ");

         Handle_Matricule_Error : declare

         begin -- Handle_Matricule_Error
            Test_Matricule := Matricules.Make (Ada.Text_IO.Get_Line);

            exit Valid_Matricule;

         exception -- Handle_Matricule_Error
            when Constraint_Error =>
                 Ada.Text_IO.Put_Line ("Format de matricule invalide, veuillez reessayer svp!");
         end Handle_Matricule_Error;
      end loop Valid_Matricule;

      Valid_Dossier   : loop
         Ada.Text_IO.Put ("Veuillez introduire le numero de dossier: ");

         Handle_Dossier_Error : declare

         begin -- Handle_Dossier_Error
            Numero_Dossier := Ada.Text_IO.Get_Line;

            exit Valid_Dossier;

         exception -- Handle_Dossier_Error
            when Constraint_Error =>
               Ada.Text_IO.Put_Line ("Format de dossier invalide, veuillez reessayer svp!");
         end Handle_Dossier_Error;
      end loop Valid_Dossier;

      Valid_Culture   : loop
         Ada.Text_IO.Put ("Veuillez introduire le type de culture: ");

         Handle_Culture_Error : declare

         begin -- Handle_Culture_Error
            Antibiogrammes.Culture_IO.Get (Item => Culture);

            exit Valid_Culture;

         exception -- Handle_Culture_Error
            when Ada.IO_Exceptions.Data_Error =>
               Ada.Text_IO.Put_Line ("Type de culture  invalide, veuillez reessayer svp!");
         end Handle_Culture_Error;
      end loop Valid_Culture;

      for Counter in 1 .. How_Many loop

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
              (Code_Service => 123);

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

            BCI_Messages.IO.To_BCI (File => File,
                                    Item => Test_Message);

            BCI_Messages.IO.Put (File => Log,
                                 File_Name => File_Name (Counter),
                                 Item => Test_Message);

            Ada.Text_IO.Close (File);

         end; -- declare

      end loop;

      Ada.Text_IO.Close (Log);

   end Generate;

begin -- Generateur_Trame_VT2

   Generate;

exception

   when Err : others =>
      Ada.Text_IO.Put_Line ("Houston we have a problem: " &
                              Ada.Exceptions.Exception_Information (Err));

      Ada.Text_IO.Put_Line (Traceback.Symbolic.Symbolic_Traceback (Err));

end Generateur_Trame_VT2;
