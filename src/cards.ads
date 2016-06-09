with Ada.Integer_Text_IO;
with Ada.Text_IO;
with Ada.IO_Exceptions;
with Ada.Numerics.Discrete_Random;
with Antibiotics; with Antibiotics.IO;
with Common_Defs_BCI; use Common_Defs_BCI;
with Common_IO; use Common_IO;
with Germes; with Germes.IO;

package Cards is

   -- maximum length of the different fields
   Max_Code : constant Positive := 15; -- allowed by host 8 or 15
   Max_Lot  : constant Positive := 99999999; -- max length of the card's lot number

   Max_Cards : constant Natural := 20; -- max number of cards in configuration
   Max_Antibiotics : constant Natural := 20; -- max number of Antibiotics on a card

   subtype Lot_Type is Positive range 1 .. Max_Lot;
   subtype Cards_Index is Positive range 1 .. Max_Cards;
   subtype Antibiotics_Index is Positive range 1 .. Max_Antibiotics;

   type Object is private;

   type Cards_Array is array (Cards_Index) of Object;
   type Antibiotics_Array is array (Antibiotics_Index) of Antibiotics.Object;

   type Configuration_Array is private;

   -- Setters
   procedure Set_Code_SIL (Item : in out Object; SIL : Code_Type);
   -- Pre: Item and Code_SIL are defined
   -- Post: sets the Code_SIL of the card

   procedure Set_Lot (Item : in out Object; Lot : Lot_Type);
   -- Pre: Item and Lot are defined
   -- Post: sets the Lot of the card

   -- Getters
   function Get_Code_SIL (Item : Object) return Code_Type;
   -- Pre: Item is defined
   -- Post: returns the corresponding value
   function Get_Lot (Item : Object) return Lot_Type;
   -- Pre: Item is defined
   -- Post: returns the corresponding value

   -- Constructors

   ----------
   -- Make --
   ----------
   function Make (Code_SIL           : Code_Type;
                  Nbre_Antibiotiques : Cards_Index;
                  Lot                : Lot_Type;
                  Germe              : Germes.Object;
                  Composition        : Antibiotics_Array) return Object;

   ----------------------
   -- Make_From_Config --
   ----------------------
   function Make_From_Config (Code_SIL : Code_Type;
                              Germe    : Germes.Object) return Object;
   -- Makes an card with the composition from the cards configuration file
   -- the values of the antibiotics are random

   -----------------
   -- Make_Random --
   -----------------
   function Make_Random return Object;

   ------------
   -- others --
   ------------
   ---------------------------
   -- Display_Configuration --
   ---------------------------
   procedure Display_Configuration (Name_ON     : Boolean;
                                    Code_SIL_ON : Boolean);

private

   type Object is record
      Code_SIL : Code_Type;
      Antibiotics : Antibiotics_Array;
      Anti_Counter  : Natural := 0;
      Lot           : Lot_Type := 12345678;
      Germe         : Germes.Object;
   end record;

   type Configuration_Array is record
      Cards_Config : Cards_Array;
      Cards_Counter : Natural := 0;
   end record;

end Cards;
