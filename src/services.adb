package body Services is

   -----------------
   -- Set_Service --
   -----------------
   procedure Set_Service (Item         : out Object;
                          Code_Service : in Service_Type) is
   begin
      Item.Code_Service := Code_Service;
   end Set_Service;

   -----------------
   -- Get_Service --
   -----------------
   function Get_Service (Item : in Object) return Service_Type is
   begin
      return Item.Code_Service;
   end Get_Service;

   ----------
   -- Make --
   ----------
   function Make (Code_Service : in Service_Type) return Object is
      Item : Object;
   begin
      Item.Code_Service := Code_Service;
      return Item;
   end Make;

end Services;
