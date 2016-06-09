with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.IO_Exceptions;
with Ada.Numerics.Discrete_Random;
with Common_Defs_BCI; use Common_Defs_BCI;
with Common_IO; use Common_IO;

package Germes is

   -- maximum length of the different fields
   Max_Name : constant Positive := 30; -- name of the bacteria, internal use
   Max_Code : constant Positive := 6; -- allowed by host 8 or 15

   Max_Germes : constant Positive := 100; -- maximum number of bacteria in config

   subtype Germes_Index is Positive range 1 .. Max_Germes;

   type Object is private;

   type Germes_Array is array (Germes_Index) of Object;

   -- Setters

   procedure Set_Name (Item : in out Object; Name : in Name_Type);
   -- Pre: Item and Name are defined
   -- Post: sets the name of germe

   procedure Set_Code_SIL (Item : in out Object; SIL : in Code_Type);
   -- Pre: Item and Code_SIL are defined
   -- Post: sets the Code_SIL of germe

   procedure Set_Isolat (Item : in out Object; Isolat : in Positive);
   -- Pre: Item and Code_SIL are defined
   -- Post: sets the Isolat of the card

   -- Getters

   function Get_Name (Item : Object) return Name_Type;
   -- Pre: Item is defined
   -- Post: returns the corresponding value
   function Get_Code_SIL (Item : Object) return Code_Type;
   -- Pre: Item is defined
   -- Post: returns the corresponding value
   function Get_Isolat (Item : Object) return Positive;
   -- Pre: Item is defined
   -- Post: returns the corresponding value

   -- Constructor

   ----------
   -- Make --
   ----------
   function Make (Name     : Name_Type;
                        Code_SIL : Code_Type;
                        Isolat   : Positive) return Object;

   ----------------------
   -- Make_From_Config --
   ----------------------
   function Make_From_Config (Name : Name_Type) return Object;

   -----------------
   -- Make_Random --
   -----------------
   function Make_Random return Object;

   -----------
   -- other --
   -----------

   ---------------------------
   -- Display_Configuration --
   ---------------------------
   procedure Display_Configuration;
   -- Pre: None
   -- Post: Displays the configuration

   -----------------
   -- Search_Code --
   -----------------
   function Search_Code (Name   : in Name_Type) return Code_Type;
   -- Pre: Name is defined
   -- Post: returns the Code_SIL of Name

private

   type Object is record
      Name          : Name_Type;
      Code_SIL      : Code_Type;
      Isolat        : Positive := 1;
   end record;

   type Configuration_Array is record
      Germes_Config : Germes_Array;
      Germes_Counter : Natural := 0;
   end record;

end Germes;
