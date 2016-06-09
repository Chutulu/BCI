with Ada.Text_IO;
with Antibiotics; with Antibiotics.IO;
with Cards; with Cards.IO;
with Common_Defs_BCI; use Common_Defs_BCI;
with Common_IO; use Common_IO;
with Germes; with Germes.IO;

package Antibiogrammes is

   type Culture_Type is  (Aero, Ana, Cumy);
   package Culture_IO is new Ada.Text_IO.Enumeration_IO (Enum => Culture_Type);

   type Object is private;

   -- Setters

   -----------------
   -- Set_Culture --
   -----------------
   procedure Set_Culture (Item : in out Object; Culture : Culture_Type);
   -- Pre: Item and Card are defined
   -- Post: sets the card of the antibiogramm

   -- Getters

   -----------------
   -- Get_Culture --
   -----------------
   function Get_Culture (Item : Object) return Culture_Type;
   -- Pre: Item is defined
   -- Post: returns the corresponding value

   -- Constructors

   ----------
   -- Make --
   ----------
   function Make (Culture : Culture_Type;
                  Card    : Cards.Object) return Object;

   ----------------------
   -- Make_From_Config --
   ----------------------
   function Make_From_Config (Card    : Code_Type;
                              Culture : Culture_Type;
                              Germe   : Germes.Object) return Object;

private

   type Object is record
      Culture : Culture_Type := Aero;
      Card    : Cards.Object;
   end record;

end Antibiogrammes;
