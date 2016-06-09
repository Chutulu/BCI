with Ada.Text_IO;
with Common_Defs_BCI; use Common_Defs_BCI;
with Common_IO; use Common_IO;

package Samples is

   type Object is private;

   -- Setters

   ----------------
   -- Set_Sample --
   ----------------
   procedure Set_Sample (Item             : out Object;
                         Sample_Code      : in Code_Type);
   -- Pre: Item and Sample_Code are defined
   -- Post: Sets the corresponding value of Item

   -- Getters

   ----------------
   -- Get_Sample --
   ----------------
   function Get_Sample (Item : in Object) return Code_Type;
   -- Pre: Item is defined
   -- Post: returns the corresponding value of Item

   -- Constructors

   ----------
   -- Make --
   ----------
   function Make (Sample_Code : in Code_Type) return Object;
   -- Pre: Sample_Code is defined
   -- Post: returns an Item of Sample_Type

private

   type Object is record

      Sample_Code : Code_Type := (+"PGF");

   end record;

end Samples;
