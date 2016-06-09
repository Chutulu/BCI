with Ada.Integer_Text_IO;
with Ada.Text_IO;
with Common_IO; use Common_IO;

package Medecins is

   Max_Code_Medecin : constant Positive := 999999;

   subtype Medecin_Type is Positive range 900000 .. Max_Code_Medecin;

   type Object is private;

   -- Setters

   -----------------
   -- Set_Medecin --
   -----------------
   procedure Set_Medecin (Item : out Object; Code_Medecin : in Medecin_Type);
   -- Pre: Item and Code_Medecin are defined
   -- Post: Sets the corresponding value of Item

   -- Getters

   -----------------
   -- Get_Medecin --
   -----------------
   function Get_Medecin (Item : in Object) return Medecin_Type;
   -- Pre: Item is defined
   -- Post: returns the corresponding value of Item

   -- Constructors

   ----------
   -- Make --
   ----------
   function Make (Code_Medecin : in Medecin_Type) return Object;
   -- Pre: Code_Medecin is defined
   -- Post: returns an Item of type Medecin

private

   type Object is record
      Code_Medecin : Medecin_Type := 900000;
   end record;

end Medecins;
