with Ada.Integer_Text_IO;
with Ada.Text_IO;
with Common_IO; use Common_IO;
with Dates; use Dates;
with Strings_Edit; use Strings_Edit;
with PragmARC.Date_Handler;

package Matricules is

   Min_Length : constant Positive := 11; -- Minimum length of a matricule
   Max_Length : constant Positive := 13; -- Maximum length of a matricule

   subtype Control_Digit_Type is Natural range 0 .. 9;
   subtype Rnd_Nbr_Type is Positive range 001 .. 999;

   subtype Date_of_Birth is Dates.Object;
   type Object is private;

   -- Setters

   procedure Set_Rnd_Nbr (Item    : in out Object;
                          Rnd_Nbr : in Rnd_Nbr_Type);
   -- Pre: Item and Rnd_Nbr are defined
   -- Post: Sets the different values for Item

   procedure Set_C1 (Item : in out Object;
                     C1   : in Control_Digit_Type);
   -- Pre: Item and C1 are defined
   -- Post: Sets the first Check_Digit for Item

   procedure Set_C2 (Item : in out Object;
                     C2   : in Control_Digit_Type);
   -- Pre: Item and C2 are defined
   -- Post: Sets the second Check_Digit for Item

   -- Getters

   function Get_Rnd_Nbr (Item : in Object) return Rnd_Nbr_Type;
   -- Pre: Item is defined
   -- Post: returns the corresponding value

   function Get_C1 (Item : in Object) return Control_Digit_Type;
   -- Pre: Item is defined
   -- Post: returns the corresponding value

   function Get_C2 (Item : in Object) return Control_Digit_Type;
   -- Pre: Item is defined
   -- Post: returns the corresponding value

   -- Constructor
   function Make (Year    : in Year_Number;
                  Month   : in Month_Number;
                  Day     : in Day_Number;
                  Rnd_Nbr : in Rnd_Nbr_Type;
                  C1, C2  : in Control_Digit_Type) return Object;

   function Make (Matricule : in String) return Object;

   -- Others
--     function Is_Valid (Item : in Matricule) return Boolean;
   -- Pre: Item is defined
   -- Post: returns True if the Matricule has a valid checksum

private

   type Object is record
      DOB : Date_Of_Birth;
      XXX : Rnd_Nbr_Type := Rnd_Nbr_Type'First;
      C1, C2  : Control_Digit_Type := Control_Digit_Type'First;
   end record;

end Matricules;
