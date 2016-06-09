package body Cards is

   Name_Code_Array : Configuration_Array;

   package ATB_IO renames Antibiotics.IO;

   -- Setters

   procedure Set_Code_SIL (Item : in out Object; SIL : Code_Type) is
   begin
      Item.Code_SIL := SIL;
   end Set_Code_SIL;

   procedure Set_Lot (Item : in out Object; Lot : Lot_Type) is
   begin
      Item.Lot := Lot;
   end Set_Lot;

   -- Getters

   function Get_Code_SIL (Item : Object) return Code_Type is
   begin
      return Item.Code_SIL;
   end Get_Code_SIL;

   function Get_Lot (Item : Object) return Lot_Type is
   begin
      return Item.Lot;
   end Get_Lot;

   -- Constructors

   ----------
   -- Make --
   ----------
   function Make (Code_SIL           : Code_Type;
                        Nbre_Antibiotiques : Cards_Index;
                        Lot                : Lot_Type;
                        Germe              : Germes.Object;
                        Composition        : Antibiotics_Array) return Object is

      Item : Object;

   begin -- Card

      Item.Code_SIL := Code_SIL;
      Item.Anti_Counter := Nbre_Antibiotiques;
      Item.Germe := Germe;
      Item.Antibiotics := Composition;

      return Item;

   end Make;

   ----------------------
   -- Make_From_Config --
   ----------------------
   function Make_From_Config (Code_SIL : Code_Type;
                                    Germe    : Germes.Object) return Object is
      Item : Object;

   begin -- Make_From_config

      for Counter in 1 .. Name_Code_Array.Cards_Counter loop
         if U_B."=" (Code_SIL, Name_Code_Array.Cards_Config (Counter).Code_SIL) then
            Item := Name_Code_Array.Cards_Config (Counter);
         end if;
      end loop;

      for ATB_Counter in 1 .. Item.Anti_Counter loop

         Antibiotics.Set_CMI (Item => Item.Antibiotics (ATB_Counter),
                              CMI  => Antibiotics.Random_CMI);

         Antibiotics.Set_SIR (Item => Item.Antibiotics (ATB_Counter),
                                SIR  => Antibiotics.Random_SIR);
      end loop;

      Item.Germe := Germe;

      return Item;

   end Make_From_Config;

   -----------------
   -- Make_Random --
   -----------------
   function Make_Random return Object is

      subtype Cards_Nbr is Positive range 1 .. Name_Code_Array.Cards_Counter;

      package Random_Cards
      is new Ada.Numerics.Discrete_Random (Cards_Nbr);
      use Random_Cards;

      G : Generator;

   begin -- Make_Random

      Reset (G); -- Start the generator in a unique state in each run

      return R_Cards : Object do

         R_Cards := Name_Code_Array.Cards_Config (Random (G));

         R_Cards.Germe := Germes.Make_Random;

         for Counter in 1 .. R_Cards.Anti_Counter loop

            Antibiotics.Set_CMI (Item => R_Cards.Antibiotics (Counter),
                                   CMI  => Antibiotics.Random_CMI);

            Antibiotics.Set_SIR (Item => R_Cards.Antibiotics (Counter),
                                   SIR  => Antibiotics.Random_SIR);

         end loop;

      end return;

   end Make_Random;

   ---------------------------
   -- Display_Configuration --
   ---------------------------
   procedure Display_Configuration (Name_ON     : Boolean;
                                    Code_SIL_ON : Boolean) is

   begin -- Display_Configuration

      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put_Line ("Displaying configuration of Cards");

      for Counter in 1 .. Name_Code_Array.Cards_Counter loop

         if Code_SIL_ON then
            Ada.Text_IO.Put_Line
              (+Get_Code_SIL (Name_Code_Array.Cards_Config (Counter)));
         end if;

         for ATB_Counter in 1 .. Name_Code_Array.Cards_Config (Counter).Anti_Counter loop

            if Name_ON then
               ATB_IO.Put
                 (Item        => Name_Code_Array.Cards_Config (Counter).Antibiotics (ATB_Counter),
                  Name_ON     => Name_ON,
                  Code_SIL_ON => False,
                  CMI_ON      => False,
                  SIR_ON      => False);
            end if;

            if Code_SIL_ON then
               ATB_IO.Put
                 (Item        => Name_Code_Array.Cards_Config (Counter).Antibiotics (ATB_Counter),
                  Name_ON     => False,
                  Code_SIL_ON => Code_SIL_ON,
                  CMI_ON      => False,
                  SIR_ON      => False);
            end if;

         end loop;

         Ada.Text_IO.New_Line;

      end loop;

   end Display_Configuration;

   -- procedures for internal use; save and read cards configuration

   -----------------------------
   -- Read_Cards_Config_File --
   -----------------------------
   procedure Read_Cards_Config_File (Target_Array : in out Configuration_Array) is

      Config_File : Ada.Text_IO.File_Type;
      Item : Object;

   begin -- Read_Cards_Config_File

      -- open the configuration file and associate it with the variable name
      Ada.Text_IO.Open (File => Config_File,
                        Mode => Ada.Text_IO.In_File,
                        Name => "cartes.txt");

      -- read each data item
--        Ada.Text_IO.New_Line;
      Ada.Text_IO.Put_Line ("reading Cards configuration");

      while Name_Code_Array.Cards_Counter in 0 .. Max_Cards loop

         exit when Ada.Text_IO.End_Of_File (Config_File);
--           Ada.Text_IO.New_Line;
--           Ada.Text_IO.Put_Line ("Begin of reading loop");

         Get (File      => Config_File,
              Item      => Item.Code_SIL,
              Item_Type => "Code SIL",
              Max       => Max_Code);

--           Ada.Text_IO.Put_Line ("read card code: " & (+Item.Code_SIL));

         Ada.Integer_Text_IO.Get (File => Config_File,
                                  Item => Item.Anti_Counter);

         Ada.Text_IO.Skip_Line (File => Config_File);

--           Ada.Text_IO.Put_Line ("read ATB counter" & Item.Anti_Counter'Img);

         for ATB_Counter in 1 .. Item.Anti_Counter loop

--              Ada.Text_IO.Put_Line ("read card ATB");

            ATB_IO.Get
              (File        => Config_File,
               Item        => Item.Antibiotics (ATB_Counter),
               Name_ON     => True,
               Code_SIL_ON => False,
               CMI_ON      => False,
               SIR_ON      => False);

            -- get the antibiotics SIL code from the antibiotics configuration file
            Antibiotics.Set_Code_SIL
              (Item => Item.Antibiotics (ATB_Counter),
               SIL  => Antibiotics.Search_Code (Name => Antibiotics.Get_Name
                                                  (Item.Antibiotics (ATB_Counter))));

            -- for debugging
--              ATB_IO.Display_Antibiotique (Item        => Item.Antibiotiques (ATB_Counter),
--                                           Name_ON     => True,
--                                           Code_SIL_ON => True,
--                                           CMI_ON      => False,
--                                           SIR_ON      => False);
         end loop;

         if Name_Code_Array.Cards_Counter = Max_Cards then
            Ada.Text_IO.Put_Line ("Cards Name_Code_Array");
            raise Array_Full;
         end if;

         Name_Code_Array.Cards_Counter := Name_Code_Array.Cards_Counter + 1;
         Name_Code_Array.Cards_Config (Name_Code_Array.Cards_Counter) := Item;

      end loop;

      Ada.Text_IO.New_Line;

      -- close the configuration file
      Ada.Text_IO.Close (File => Config_File);

   end Read_Cards_Config_File;

   ------------------------------
   -- Write_Cards_Config_File --
   ------------------------------
   procedure Write_Cards_Config_File (Source : Configuration_Array) is

      Config_File : Ada.Text_IO.File_Type;
      Item : Object;

   begin -- Write_Cards_Config_File

      -- open the configuration file and associate it with the variable name
      Ada.Text_IO.Create (File => Config_File,
                          Mode => Ada.Text_IO.Out_File,
                          Name => "cartes.txt");

      for Cards_Counter in 1 .. Source.Cards_Counter loop

         Item := Source.Cards_Config (Cards_Counter);

         Ada.Text_IO.Put_Line (File     => Config_File,
                               Item     => (+Item.Code_SIL));

         Ada.Integer_Text_IO.Put (File => Config_File,
                                  Item  => Item.Anti_Counter,
                                  Width => 0);
         Ada.Text_IO.New_Line (Config_File);

         for ATB_Counter in 1 .. Source.Cards_Config (Cards_Counter).Anti_Counter loop

            ATB_IO.Put
              (File           => Config_File,
               Item           => Item.Antibiotics (ATB_Counter),
               Name_On        => True,
               Code_SIL_ON    => False,
               CMI_ON         => False,
               SIR_ON         => False);
         end loop;

      end loop;

      -- close the configuration file
      Ada.Text_IO.Close (File => Config_File);

   end Write_Cards_Config_File;

begin -- main

   Read_Cards_Config_File (Target_Array => Name_Code_Array);
--     Write_Cards_Config_File (Source => Name_Code_Array);

end Cards;
