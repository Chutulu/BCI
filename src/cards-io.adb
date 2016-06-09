
package body Cards.IO is

   package ATB_IO renames Antibiotics.IO;

   ---------
   -- Put --
   ---------
   procedure Put (File                   : in Ada.Text_IO.File_Type;
                  Item                   : in Object;
                  Name_ON                : in Boolean;
                  Antibiotique_SIL_ON    : in Boolean;
                  Carte_SIL_ON           : in Boolean;
                  CMI_ON                 : in Boolean;
                  SIR_ON                 : in Boolean) is

   begin -- Put

      if Carte_SIL_ON then

         Germes.IO.Put (File        => File,
                        Item        => Item.Germe,
                        Name_ON     => Name_ON,
                        Code_SIL_ON => Carte_SIL_ON);

         Ada.Text_IO.Put (File => File,
                          Item => "Isolat numero: ");

         Ada.Integer_Text_IO.Put (File  => File,
                                  Item  => Germes.Get_Isolat (Item.Germe),
                                  Width => 0);

         Ada.Text_IO.New_Line (File    => File,
                               Spacing => 2);

         Ada.Text_IO.Put_Line (File => File,
                               Item => "Code SIL de la carte: " & (+Item.Code_SIL));

      end if;

      for ATB_Counter in 1 .. Item.Anti_Counter loop

         ATB_IO.Put (File        => File,
                     Item        => Item.Antibiotics (ATB_Counter),
                     Name_ON     => Name_ON,
                     Code_SIL_ON => Antibiotique_SIL_ON,
                     CMI_ON      => CMI_ON,
                     SIR_ON      => SIR_ON);
      end loop;

      Ada.Text_IO.New_Line (File);

   end Put;

   ---------
   -- Put --
   ---------
   procedure Put (Item                   : in Object;
                  Name_ON                : in Boolean;
                  Antibiotique_SIL_ON    : in Boolean;
                  Carte_SIL_ON           : in Boolean;
                  CMI_ON                 : in Boolean;
                  SIR_ON                 : in Boolean) is

   begin -- Put

      Put (File                => Ada.Text_IO.Standard_Output,
           Item                => Item,
           Name_ON             => Name_ON,
           Antibiotique_SIL_ON => Antibiotique_SIL_ON,
           Carte_SIL_ON        => Carte_SIL_ON,
           CMI_ON              => CMI_ON,
           SIR_ON              => SIR_ON);

   end Put;

   ------------------
   -- Put_To_Gnoga --
   ------------------
   procedure Put_To_Gnoga (Item                   : in Object;
                  Name_ON                : in Boolean;
                  Antibiotique_SIL_ON    : in Boolean;
                  Carte_SIL_ON           : in Boolean;
                  CMI_ON                 : in Boolean;
                  SIR_ON                 : in Boolean) is

   begin -- Put_To_Gnoga

      if Carte_SIL_ON then

         Germes.IO.Put_To_Gnoga (Item        => Item.Germe,
                                 Name_ON     => Name_ON,
                                 Code_SIL_ON => Carte_SIL_ON);

         Main_View.Put ("Isolat numero: ");

         Main_View.Put (Germes.Get_Isolat (Item.Germe)'Img);

         Main_View.New_Line;
         Main_View.New_Line;

         Main_View.Put_Line ("Code SIL de la carte: " & (+Item.Code_SIL));

      end if;

      for ATB_Counter in 1 .. Item.Anti_Counter loop

         ATB_IO.Put_To_Gnoga (Item        => Item.Antibiotics (ATB_Counter),
                              Name_ON     => Name_ON,
                              Code_SIL_ON => Antibiotique_SIL_ON,
                              CMI_ON      => CMI_ON,
                              SIR_ON      => SIR_ON);
      end loop;

      Main_View.New_Line;

   end Put_To_Gnoga;

   --------------------------
   -- Read_Card_From_File --
   --------------------------
   procedure Read_Card_From_File (File        : in Ada.Text_IO.File_Type;
                                   Item        : out Object;
                                   Name_ON     : in Boolean;
                                   Code_SIL_ON : in Boolean;
                                   CMI_ON      : in Boolean;
                                   SIR_ON      : in Boolean) is

   begin -- Read_Card_From_File

      if Code_SIL_ON then

         Get (File      => File,
              Item      => Item.Code_SIL,
              Item_Type => "Code SIL",
              Max       => Max_Code);
      end if;

      Ada.Integer_Text_IO.Get (File => File,
                               Item => Item.Anti_Counter);

      Ada.Text_IO.Skip_Line (File => File);

      for ATB_Counter in 1 .. Item.Anti_Counter loop

         Ada.Text_IO.Put_Line ("read card ATB");

         ATB_IO.Get (File        => File,
                     Item        => Item.Antibiotics (ATB_Counter),
                     Name_ON     => True,
                     Code_SIL_ON => False,
                     CMI_ON      => False,
                     SIR_ON      => False);

         -- get the antibiotics SIL code from the antibiotics configuration file
         Antibiotics.Set_Code_SIL (Item => Item.Antibiotics (ATB_Counter),
                                   SIL  => Antibiotics.Search_Code
                                             (Name => Antibiotics.Get_Name
                                                      (Item.Antibiotics (ATB_Counter))));

      end loop;

   end Read_Card_From_File;

   -------------------------
   -- Write_Card_To_File --
   -------------------------
   procedure Write_Card_To_File (File           : in out Ada.Text_IO.File_Type;
                                  Item           : in Object;
                                  Name_ON        : in Boolean;
                                  Code_SIL_ON    : in Boolean;
                                  CMI_ON         : in Boolean;
                                  SIR_ON         : in Boolean) is
   begin -- Write_Card_To_File

      if Code_SIL_ON then
         Ada.Text_IO.Put_Line (File => File, Item => (+Item.Code_SIL));
      end if;

      for ATB_Counter in 1 .. Item.Anti_Counter loop

         ATB_IO.Put
           (File           => File,
            Item           => Item.Antibiotics (ATB_Counter),
            Name_ON        => Name_ON,
            Code_SIL_ON    => Code_SIL_ON,
            CMI_ON         => CMI_ON,
            SIR_ON         => SIR_ON);

      end loop;

   end Write_Card_To_File;

   ------------
   -- To_BCI --
   ------------
   procedure To_BCI (Item : in Object;
                     File : in out Ada.Text_IO.File_Type) is
   begin -- To_BCI

      Ada.Text_IO.Put (File => File,
                       Item => "|ta|rt");
      Ada.Text_IO.Put (File => File,
                       Item => (+Item.Code_SIL));

      Ada.Text_IO.Put (File => File,
                       Item => "|rr");
      Ada.Integer_Text_IO.Put (File  => File,
                               Item  => Item.Lot,
                               Width => 0);

      Germes.IO.To_BCI (File => File,
                        Item => Item.Germe);

      for Counter in 1 .. Item.Anti_Counter loop

         Antibiotics.IO.To_BCI (File => File,
                                Item => Item.Antibiotics (Counter));
      end loop;

   end To_BCI;

end Cards.IO;
