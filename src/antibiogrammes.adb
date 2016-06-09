package body Antibiogrammes is

   -- Setters
   procedure Set_Culture (Item : in out Object; Culture : Culture_Type) is
   begin
      Item.Culture := Culture;
   end Set_Culture;

   -- Getters
   function Get_Culture (Item : Object) return Culture_Type is
   begin
      return Item.Culture;
   end Get_Culture;

   -- Constructors

   ----------
   -- Make --
   ----------
   function Make (Culture : Culture_Type;
                  Card    : Cards.Object) return Object is
      Item : Object;

   begin

      Item.Culture := Culture;
      Item.Card := Card;

      return Item;

   end Make;

   ------------------------------------
   -- Make_From_Config --
   ------------------------------------
   function Make_From_Config (Card    : Code_Type;
                              Culture : Culture_Type;
                              Germe   : Germes.Object) return Object is
      Item : Object;

   begin

      Item.Card := Cards.Make_From_Config (Code_SIL => Card, Germe => Germe);
      Item.Culture := Culture;

      return Item;

   end Make_From_Config;

end Antibiogrammes;
