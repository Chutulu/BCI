
package body Dossiers is

   ---------------
   -- Set_Index --
   ---------------
   procedure Set_Index (Item : out Object; Index : Positive) is
   begin
      Item.Index := Index;
   end Set_Index;

   ----------------
   -- Set_Numero --
   ----------------
   procedure Set_Numero (Item : out Object; Numero : Dossier_Type) is
   begin
      Item.Numero_Dossier := Numero;
   end Set_Numero;

   ---------------
   -- Get_Index --
   ---------------
   function Get_Index (Item : Object) return Index_Type is
   begin
      return Item.Index;
   end Get_Index;

   ----------------
   -- Get_Numero --
   ----------------
   function Get_Numero (Item : Object) return Dossier_Type is
   begin
      return Item.Numero_Dossier;
   end Get_Numero;

   ----------
   -- Make --
   ----------
   function Make (Num_Dossier  : Dossier_Type;
                  Prescripteur : Medecins.Object;
                  Service      : Services.Object;
                  Patient      : Patients.Object;
                  Sample       : Samples.Object;
                  Resultat     : Antibiogrammes.Object) return Object is

      use Antibiogrammes;
      Item : Object;
      Index : Index_Type;

   begin -- Make

      if Antibiogrammes.Get_Culture (Resultat) = Antibiogrammes.aero then
         Index := 50;
      elsif Antibiogrammes.Get_Culture (Resultat) = Antibiogrammes.ana then
         Index := 60;
      elsif Antibiogrammes.Get_Culture (Resultat) = Antibiogrammes.cumy then
         Index := 70;
      end if;

      Item := (Index, Num_Dossier, Prescripteur, Service,
               Patient, Sample, Resultat);

      return Item;

   end Make;

end Dossiers;
