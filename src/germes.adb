package body Germes is

   Name_Code_Array : Configuration_Array;

   -- Setters
   procedure Set_Name (Item : in out Object; Name : in Name_Type) is
   begin
      Item.Name := Name;
   end Set_Name;

   procedure Set_Code_SIL (Item : in out Object; SIL : in Code_Type) is
   begin
      Item.Code_SIL := SIL;
   end Set_Code_SIL;

   procedure Set_Isolat (Item : in out Object; Isolat : in Positive) is
   begin
      Item.Isolat := Isolat;
   end Set_Isolat;

   -- Getters
   function Get_Name (Item : Object) return Name_Type is
   begin
      return Item.Name;
   end Get_Name;

   function Get_Code_SIL (Item : Object) return Code_Type is
   begin
      return Item.Code_SIL;
   end Get_Code_SIL;

   function Get_Isolat (Item : Object) return Positive is
   begin
      return Item.Isolat;
   end Get_Isolat;

   -- Constructor

   ----------
   -- Make --
   ----------
   function Make (Name     : Name_Type;
                  Code_SIL : Code_Type;
                  Isolat   : Positive) return Object is
      Item : Object;

   begin -- Make

      Item.Name := Name;
      Item.Code_SIL := Code_SIL;
      Item.Isolat := Isolat;

      return Item;

   end Make;

   ----------------------
   -- Make_From_Config --
   ----------------------
   function Make_From_Config (Name : Name_Type) return Object is

      Item : Object;

   begin -- Make_From_Config

      for Counter in 1 .. Name_Code_Array.Germes_Counter loop

         if U_B."=" (Name, Name_Code_Array.Germes_Config (Counter).Name) then
            Item := Name_Code_Array.Germes_Config (Counter);
         end if;

      end loop;

      return Item;

   end Make_From_Config;

   -----------------
   -- Make_Random --
   -----------------
   function Make_Random return Object is

      subtype Germes_Nbr is Positive range 1 .. Name_Code_Array.Germes_Counter;
      package Random_Germes
      is new Ada.Numerics.Discrete_Random (Germes_Nbr);
      use Random_Germes;

      G : Generator;

   begin -- Make_Random

      Reset (G); -- Start the generator in a unique state in each run

      return R_Germe : Object do
         R_Germe := Name_Code_Array.Germes_Config (Random (G));
      end return;

   end Make_Random;

   -- procedures for internal use; save and read germes configuration

   -----------------------------
   -- Read_Germes_Config_File --
   -----------------------------
   procedure Read_Germes_Config_File
     (Target_Array : in out Configuration_Array) is

      Config_File : Ada.Text_IO.File_Type;
      Item        : Object;

   begin -- Read_Germes_Config_File

      -- open the configuration file and associate it with the variable name
      Ada.Text_IO.Open (File => Config_File,
                        Mode => Ada.Text_IO.In_File,
                        Name => "germes.txt");

      -- read each data item
      --        Ada.Text_IO.New_Line;
      Ada.Text_IO.Put_Line ("reading Germes configuration");
      loop
         exit when Ada.Text_IO.End_Of_File (Config_File);

         Get (File      => Config_File,
              Item      => Item.Name,
              Item_Type => "Name",
              Max       => Max_Name);
         --           Ada.Text_IO.Put_Line ("read name: " & (+Item.Name));

         Get (File      => Config_File,
              Item      => Item.Code_SIL,
              Item_Type => "Code SIL",
              Max       => Max_Code);
         --           Ada.Text_IO.Put_Line ("read code: " & (+Item.Code_SIL));

         if Name_Code_Array.Germes_Counter = Max_Germes then
            Ada.Text_IO.Put_Line ("Germes Name_Code_Array");
            raise Array_Full;
         end if;

         Name_Code_Array.Germes_Counter := Name_Code_Array.Germes_Counter + 1;
         Name_Code_Array.Germes_Config (Name_Code_Array.Germes_Counter) := Item;

      end loop;

      -- Ada.Text_IO.New_Line;

      -- close the configuration file
      Ada.Text_IO.Close (File => Config_File);

   end Read_Germes_Config_File;

   ------------------------------------
   -- Write_Germes_Config_File --
   ------------------------------------
   procedure Write_Germes_Config_File (Source : in Configuration_Array) is

      Config_File : Ada.Text_IO.File_Type;

   begin -- Write_Germes_Config_File

      -- open the configuration file and associate it with the variable name
      Ada.Text_IO.Open (File => Config_File,
                        Mode => Ada.Text_IO.In_File,
                        Name => "germes.txt");

      for Counter in 1 .. Name_Code_Array.Germes_Counter loop

         Ada.Text_IO.Put_Line
           (File => Config_File,
            Item => (+Get_Name (Name_Code_Array.Germes_Config (Counter))));

         Ada.Text_IO.Put_Line
           (File => Config_File,
            Item => (+Get_Code_SIL (Name_Code_Array.Germes_Config (Counter))));

      end loop;

      -- close the configuration file
      Ada.Text_IO.Close (File => Config_File);

   end Write_Germes_Config_File;

   ---------------------------
   -- Display_Configuration --
   ---------------------------
   procedure Display_Configuration is

   begin -- Display_Configuration

      Ada.Text_IO.Put_Line ("Displaying configuration of germes");

      for Counter in 1 .. Name_Code_Array.Germes_Counter loop

         Ada.Text_IO.Put_Line
           (Item => (+Get_Name (Name_Code_Array.Germes_Config (Counter))));
         Ada.Text_IO.Put_Line
           (+Get_Code_SIL (Name_Code_Array.Germes_Config (Counter)));
         Ada.Text_IO.New_Line;

      end loop;
   end Display_Configuration;

   -----------------
   -- Search_Germe --
   -----------------
   function Search_Code (Name   : in Name_Type) return Code_Type is
      Code_SIL : Code_Type := (+"not defined in Germes configuration");
   begin
      for Counter in 1 .. Name_Code_Array.Germes_Counter loop
         if U_B."=" (Name, Get_Name (Name_Code_Array.Germes_Config (Counter))) then
            Code_SIL := Get_Code_SIL (Name_Code_Array.Germes_Config (Counter));
         end if;
      end loop;
      return Code_SIL;
   end Search_Code;

begin -- main

   Read_Germes_Config_File (Target_Array => Name_Code_Array);

end Germes;
