
package body Antibiotics is

   Name_Code_Array : Configuration_Array;

   -- Setters

   procedure Set_Name (Item : in out Object; Name : Name_Type) is
   begin
      Item.Name := Name;
   end Set_Name;

   procedure Set_Code_SIL (Item : in out Object; SIL : Code_Type) is
   begin
      Item.Code_SIL := SIL;
   end Set_Code_SIL;

   procedure Set_CMI (Item : in out Object; CMI : CMI_Type) is
   begin
      Item.CMI := CMI;
   end Set_CMI;

   procedure Set_SIR (Item : in out Object; SIR : SIR_Type) is
   begin
      Item.SIR := SIR;
   end Set_SIR;

   -- Getters

   function Get_Name (Item : Object) return Name_Type is
   begin
      return Item.Name;
   end Get_Name;

   function Get_Code_SIL (Item : Object) return Code_Type is
   begin
      return Item.Code_SIL;
   end Get_Code_SIL;

   function Get_CMI (Item : Object) return CMI_Type is
   begin
      return Item.CMI;
   end Get_CMI;

   function Get_SIR (Item : Object) return SIR_Type is
   begin
      return Item.SIR;
   end Get_SIR;

   function Get_Antibiotique (Source : Configuration_Array;
                              Index  : Antibiotics_Index) return Object is
   begin
      return Source.Anti_Config (Index);
   end Get_Antibiotique;

   -- Constructor

   function Make (Name     : Name_Type;
                  Code_SIL : Code_Type;
                  CMI      : CMI_Type;
                  SIR      : SIR_Type) return Object is

      Item : Object;

   begin -- Make

      Item := (Name     => Name,
               Code_SIL => Code_SIL,
               CMI      => CMI,
               SIR      => SIR);

      return Item;

   end Make;

   ----------------
   -- Random_CMI --
   ----------------
   function Random_CMI return CMI_Type is

      package Random_CMIs
      is new Ada.Numerics.Discrete_Random (CMI_Index);
      use Random_CMIs;

      G : Generator;

   begin -- Random_CMI

      Reset (G); -- Start the generator in a unique state in each run

      return Name_Code_Array.CMI_Config (Random (G));

   end Random_CMI;

   ----------------
   -- Random_SIR --
   ----------------
   function Random_SIR return SIR_Type is

      package Random_SIRs
      is new Ada.Numerics.Discrete_Random (SIR_Index);
      use Random_SIRs;

      G : Generator;

   begin -- Random_SIR

      Reset (G); -- Start the generator in a unique state in each run

      return Name_Code_Array.SIR_Config (Random (G));

   end Random_SIR;

   -- procedures for internal use; save and read antibiotiques configuration

   ------------------------------------
   -- Read_Antibiotics_Config_File --
   ------------------------------------
   procedure Read_Antibiotics_Config_File (Target_Array : in out Configuration_Array;
                                           Name_ON      : Boolean;
                                           Code_SIL_ON  : Boolean;
                                           CMI_ON       : Boolean;
                                           SIR_ON       : Boolean) is
      Config_File : Ada.Text_IO.File_Type;
      Item        : Object;

   begin -- Read_Antibiotiques_Config_File

      -- open the configuration file and associate it with the variable name
      Ada.Text_IO.Open (File => Config_File,
                        Mode => Ada.Text_IO.In_File,
                        Name => "antibiotiques.txt");

      -- read each data item
      Ada.Text_IO.Put_Line ("reading Antibiotiques configuration");

      loop
         exit when Ada.Text_IO.End_Of_File (Config_File);

         if Name_ON then
            Get (File      => Config_File,
                 Item      => Item.Name,
                 Item_Type => "Name",
                 Max       => Max_Name);
            -- Ada.Text_IO.Put_Line ("read name: " & (+Item.Name));
         end if;
         if Code_SIL_ON then
            Get (File      => Config_File,
                 Item      => Item.Code_SIL,
                 Item_Type => "Code SIL",
                 Max       => Max_Code);
            -- Ada.Text_IO.Put_Line ("read code: " & (+Item.Code_SIL));
         end if;
         if CMI_ON then
            Get (File      => Config_File,
                 Item      => Item.CMI,
                 Item_Type => "CMI",
                 Max       => Max_CMI);
            -- Ada.Text_IO.Put_Line ("read cmi: " & (+Item.CMI));
         end if;
         if SIR_ON then
            Get (File      => Config_File,
                 Item      => Item.SIR,
                 Item_Type => "SIR",
                 Max       => Max_SIR);
            -- Ada.Text_IO.Put_Line ("read SIR: " & (+Item.SIR));
         end if;

         if Name_Code_Array.Anti_Counter = Max_Antibiotics then
            Ada.Text_IO.Put_Line ("Antibiotiques Name_Code_Array full");
            raise Array_Full;
         end if;

         Name_Code_Array.Anti_Counter := Name_Code_Array.Anti_Counter + 1;
         Name_Code_Array.Anti_Config (Name_Code_Array.Anti_Counter) := Item;

      end loop;

      -- close the configuration file
      Ada.Text_IO.Close (File => Config_File);

   end Read_Antibiotics_Config_File;

   ------------------------------------
   -- Write_Antibiotiques_Config_File --
   ------------------------------------
   procedure Write_Antibiotiques_Config_File (Source      : Configuration_Array;
                                              Name_ON     : Boolean;
                                              Code_SIL_ON : Boolean;
                                              CMI_ON      : Boolean;
                                              SIR_ON      : Boolean) is
      Config_File : Ada.Text_IO.File_Type;

   begin -- Write_Antibiotiques_Config_File

      -- open the configuration file and associate it with the variable name
      Ada.Text_IO.Create (File => Config_File,
                          Mode => Ada.Text_IO.In_File,
                          Name => "antibiotiques.txt");

      for Counter in 1 .. Name_Code_Array.Anti_Counter loop

         if Name_ON then
            Ada.Text_IO.Put_Line
              (File => Config_File,
               Item => (+Get_Name (Name_Code_Array.Anti_Config (Counter))));
         end if;

         if Code_SIL_ON then
            Ada.Text_IO.Put_Line
              (File => Config_File,
               Item => (+Get_Code_SIL (Name_Code_Array.Anti_Config (Counter))));
         end if;

         if CMI_ON then
            Ada.Text_IO.Put_Line
              (File => Config_File,
               Item => (+Get_CMI (Name_Code_Array.Anti_Config (Counter))));
         end if;
         if SIR_ON then
            Ada.Text_IO.Put_Line
              (File => Config_File,
               Item => (+Get_SIR (Name_Code_Array.Anti_Config (Counter))));
         end if;
      end loop;

      -- close the configuration file
      Ada.Text_IO.Close (File => Config_File);

   end Write_Antibiotiques_Config_File;

   ---------------------------
   -- Display_Configuration --
   ---------------------------
   procedure Display_Configuration (Name_ON     : Boolean;
                                    Code_SIL_ON : Boolean;
                                    CMI_ON      : Boolean;
                                    SIR_ON      : Boolean) is
   begin -- Display_Configuration

      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put_Line ("Displaying configuration of antibiotiques");

      for Counter in 1 .. Name_Code_Array.Anti_Counter loop

         if Name_ON then
            Ada.Text_IO.Put_Line
              (+Get_Name (Name_Code_Array.Anti_Config (Counter)));
         end if;
         if Code_SIL_ON then
            Ada.Text_IO.Put_Line
              (+Get_Code_SIL (Name_Code_Array.Anti_Config (Counter)));
         end if;
         if CMI_ON then
            Ada.Text_IO.Put_Line
              (+Get_CMI (Name_Code_Array.Anti_Config (Counter)));
         end if;
         if SIR_ON then
            Ada.Text_IO.Put_Line
              (+Get_SIR (Name_Code_Array.Anti_Config (Counter)));
         end if;
      end loop;
   end Display_Configuration;

   -----------------
   -- Search_Code --
   -----------------
   function Search_Code (Name   : Name_Type) return Code_Type is
      Code_SIL : Code_Type := (+"not defined in antibiotiques configuration");
   begin
      for ATB_Counter in 1 .. Name_Code_Array.Anti_Counter loop
         if U_B."=" (Name, Get_Name (Name_Code_Array.Anti_Config (ATB_Counter))) then
            Code_SIL := Get_Code_SIL (Name_Code_Array.Anti_Config (ATB_Counter));
         end if;
      end loop;
      return Code_SIL;
   end Search_Code;

begin -- main

   Read_Antibiotics_Config_File (Target_Array => Name_Code_Array,
                                 Name_ON     => True,
                                 Code_SIL_ON => True,
                                 CMI_ON      => False,
                                 SIR_ON      => False);

end Antibiotics;
