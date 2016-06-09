with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Antibiogrammes; with Antibiogrammes.IO;
with Common_Defs_BCI; use Common_Defs_BCI;
with Common_IO; use Common_IO;
with Dates; with Dates.IO;
with Medecins; with Medecins.IO;
with Patients; with Patients.IO;
with Samples; with Samples.IO;
with Services; with Services.IO;

package Dossiers is

   Max_Numero : constant Positive := 10;

   subtype Dossier_Type is String (1 .. Max_Numero);
   subtype Index_Type is Positive range 50 .. 70;

   type Object is private;

   -- Setters

   ---------------
   -- Set_Index --
   ---------------
   procedure Set_Index (Item : out Object; Index : Positive);
   -- Pre: Item and Index are defined
   -- Post: Sets the corresponding field of Item

   ----------------
   -- Set_Numero --
   ----------------
   procedure Set_Numero (Item : out Object; Numero : Dossier_Type);
   -- Pre: Item and Numero are defined
   -- Post: Sets the corresponding field of Item

   -- Getters

   ---------------
   -- Get_Index --
   ---------------
   function Get_Index (Item : Object) return Index_Type;
   -- Pre: Item is defined
   -- Post: returns the corresponding value

   ----------------
   -- Get_Numero --
   ----------------
   function Get_Numero (Item : Object) return Dossier_Type;
   -- Pre: Item is defined
   -- Post: returns the corresponding value

   -- Constructors

   ----------
   -- Make --
   ----------
   function Make (Num_Dossier  : Dossier_Type;
                  Prescripteur : Medecins.Object;
                  Service      : Services.Object;
                  Patient      : Patients.Object;
                  Sample       : Samples.Object;
                  Resultat     : Antibiogrammes.Object) return Object;

private

   type Object is record

      Index          : Index_Type := 50;
      Numero_Dossier : Dossier_Type := "1501011234";
      Prescripteur   : Medecins.Object;
      Service        : Services.Object;
      Patient        : Patients.Object;
      Sample         : Samples.Object;
      Resultat       : Antibiogrammes.Object;

   end record;

end Dossiers;
