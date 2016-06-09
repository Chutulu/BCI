with Ada.Text_IO;
with Common_IO; use Common_IO;
with Common_Defs_BCI; use Common_Defs_BCI;
with Matricules; with Matricules.IO;

package Patients is

   type Object is private;

   -- Setters

   -------------------
   -- Set_Matricule --
   -------------------
   procedure Set_Matricule (Item : out Object; ID : in Matricules.Object);
   -- Pre: Item and ID are defined
   -- Post: Sets the corresponding value of Item

   -- Getters

   -------------------
   -- Get_Matricule --
   -------------------
   function Get_Matricule (Item : in Object) return Matricules.Object;
   -- Pre: Item is defined
   -- Post: returns the corresponding value of Item

   -- Constructors

   ----------
   -- Make --
   ----------
   function Make (ID : in Matricules.Object) return Object;
   -- Pre: ID is defined
   -- Post: returns an Item of type Patient

private

   type Object is record

      Patient_ID : Matricules.Object;

   end record;

end Patients;
