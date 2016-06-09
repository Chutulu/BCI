package body Samples is

   ----------------
   -- Set_Sample --
   ----------------
   procedure Set_Sample (Item             : out Object;
                         Sample_Code      : in Code_Type) is
   begin

      Item.Sample_Code := Sample_Code;

   end Set_Sample;

   ----------------
   -- Get_Sample --
   ----------------
   function Get_Sample (Item : in Object) return Code_Type is

   begin

      return Item.Sample_Code;

   end Get_Sample;

   ----------
   -- Make --
   ----------
   function Make (Sample_Code : in Code_Type) return Object is

      Item : Object;

   begin

      Item.Sample_Code := Sample_Code;

      return Item;

   end Make;

end Samples;
