with Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
with Common_Defs_BCI; use Common_Defs_BCI;
with Common_IO; use Common_IO;

package Antibiotics is

   -- maximum length of the different fields
   Max_Name : constant Positive := 40; -- name of the antibiotique, internal use
   Max_Code : constant Positive := 4; -- allowed by host 8 or 15
   Max_CMI  : constant Positive := 8;
   Max_SIR  : constant Positive := 1;

   subtype CMI_Type is Ub_S;
   subtype SIR_Type is Ub_S;

   Max_Nbr_CMI : constant Positive := 10; -- max number of different CMI

   CMI_1       : constant CMI_Type := (+"0,001"); -- '+' = Common_Defs.To_Bound_String
   CMI_2       : constant CMI_Type := (+"<=2");
   CMI_3       : constant CMI_Type := (+"4");
   CMI_4       : constant CMI_Type := (+"16");
   CMI_5       : constant CMI_Type := (+">=32");
   CMI_6       : constant CMI_Type := (+"320");
   CMI_7       : constant CMI_Type := (+"SYN-S");
   CMI_8       : constant CMI_Type := (+"SYN-R");
   CMI_9       : constant CMI_Type := (+"Neg");
   CMI_10      : constant CMI_Type := (+"Pos");

   Max_Nbr_SIR : constant Positive := 5; -- max number of different SIR

   SIR_1       : constant SIR_Type := (+"S");
   SIR_2       : constant SIR_Type := (+"I");
   SIR_3       : constant SIR_Type := (+"R");
   SIR_4       : constant SIR_Type := (+"-");
   SIR_5       : constant SIR_Type := (+"+");

   Max_Antibiotics : constant Natural := 100; -- max number of antibiotics in configuration

   subtype Antibiotics_Index is Positive range 1 .. Max_Antibiotics;
   subtype CMI_Index is Positive range 1 .. Max_Nbr_CMI;
   subtype SIR_Index is Positive range 1 .. Max_Nbr_SIR;

   type Object is private;

   type Antibiotics_Array is array (Antibiotics_Index) of Object;
   type CMI_Array is array (CMI_Index) of CMI_Type;
   type SIR_Array is array (SIR_Index) of SIR_Type;

   type Configuration_Array is private;

   -- Setters
   procedure Set_Name (Item : in out Object; Name : Name_Type);
   -- Pre: Item and Name are defined
   -- Post: sets the name of the antibiotique
   procedure Set_Code_SIL (Item : in out Object; SIL : Code_Type);
   -- Pre: Item and Code_SIL are defined
   -- Post: sets the Code_SIL of the antibiotique
   procedure Set_CMI (Item : in out Object; CMI : CMI_Type);
   -- Pre: Item and CMI are defined
   -- Post: sets the CMI of the antibiotique
   procedure Set_SIR (Item : in out Object; SIR : SIR_Type);
   -- Pre: SIR is defined
   -- Post: sets the SIR of the antibiotique

   -- Getters
   function Get_Name (Item : Object) return Name_Type;
   -- Pre: Item is defined
   -- Post: returns the corresponding value
   function Get_Code_SIL (Item : Object) return Code_Type;
   -- Pre: Item is defined
   -- Post: returns the corresponding value
   function Get_CMI (Item : Object) return CMI_Type;
   -- Pre: Item is defined
   -- Post: returns the corresponding value
   function Get_SIR (Item : Object) return SIR_Type;
   -- Pre: Item is defined
   -- Post: returns the corresponding value
   function Get_Antibiotique (Source : Configuration_Array;
                              Index  : Antibiotics_Index) return Object;
   -- Pre: Source and Index are defined
   -- Post: returns an Antibiotique record

   -- Constructors

   function Make (Name     : Name_Type;
                  Code_SIL : Code_Type;
                  CMI      : CMI_Type;
                  SIR      : SIR_Type) return Object;

   function Random_CMI return CMI_Type;
   function Random_SIR return SIR_Type;

   -- others

   procedure Display_Configuration (Name_ON     : Boolean;
                                    Code_SIL_ON : Boolean;
                                    CMI_ON      : Boolean;
                                    SIR_ON      : Boolean);

   function Search_Code (Name   : Name_Type) return Code_Type;
   -- Pre: Name is defined
   -- Post: returns the Code_SIL of Name

private

   type Object is record
      Name     : Name_Type := (+"null");
      Code_SIL : Code_Type := (+"null");
      CMI      : CMI_Type := (+"null");
      SIR      : SIR_Type := (+"null");
   end record;

   type Configuration_Array is record
      Anti_Config : Antibiotics_Array;
      CMI_Config  : CMI_Array := (CMI_1, CMI_2, CMI_3, CMI_4, CMI_5,
                                  CMI_6, CMI_7, CMI_8, CMI_9, CMI_10);

      SIR_Config   : SIR_Array := (SIR_1, SIR_2, SIR_3, SIR_4, SIR_5);
      Anti_Counter : Natural := 0;
   end record;

end Antibiotics;
