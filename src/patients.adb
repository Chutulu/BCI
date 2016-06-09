package body Patients is

   -- Setters

   -------------------
   -- Set_Matricule --
   -------------------
   procedure Set_Matricule (Item : out Object;
                            ID   : in Matricules.Object) is
   begin

      Item.Patient_ID := ID;

   end Set_Matricule;

   -- Getters

   -------------------
   -- Get_Matricule --
   -------------------
   function Get_Matricule (Item : in Object) return Matricules.Object is
   begin

      return Item.Patient_ID;

   end Get_Matricule;

   -- Constructors

   ----------
   -- Make --
   ----------
   function Make (ID : in Matricules.Object) return Object is

      Item : Object;

   begin

      Item.Patient_ID := ID;

      return Item;

   end Make;

end Patients;
