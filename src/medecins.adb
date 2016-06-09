package body Medecins is

   -----------------
   -- Set_Medecin --
   -----------------
   procedure Set_Medecin (Item         : out Object;
                          Code_Medecin : in Medecin_Type) is
   begin
      Item.Code_Medecin := Code_Medecin;
   end Set_Medecin;

   -----------------
   -- Get_Medecin --
   -----------------
   function Get_Medecin (Item : in Object) return Medecin_Type is
   begin
      return Item.Code_Medecin;
   end Get_Medecin;

   ----------
   -- Make --
   ----------
   function Make (Code_Medecin : in Medecin_Type) return Object is

      Item : Object;

   begin

      Item.Code_Medecin := Code_Medecin;

      return Item;

   end Make;

end Medecins;
