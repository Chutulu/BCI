package body Germes.IO is

   ---------
   -- Put --
   ---------
   procedure Put (File        : in Ada.Text_IO.File_Type;
                  Item        : in Object;
                  Name_ON     : in Boolean;
                  Code_SIL_ON : in Boolean) is
   begin -- Put
      if Name_ON then
         Ada.Text_IO.Put_Line (File => File,
                               Item => "Germe nom: " & (+Item.Name));
      end if;
      if Code_SIL_ON then
         Ada.Text_IO.Put_Line (File => File,
                               Item => "Code SIL: " & (+Item.Code_SIL));
      end if;
   end Put;

   ---------
   -- Put --
   ---------
   procedure Put (Item        : in Object;
                  Name_ON     : in Boolean;
                  Code_SIL_ON : in Boolean) is
   begin -- Put

      Put (File        => Ada.Text_IO.Standard_Output,
           Item        => Item,
           Name_ON     => Name_ON,
           Code_SIL_ON => Code_SIL_ON);

   end Put;

   ------------------
   -- Put_To_Gnoga --
   ------------------
   procedure Put_To_Gnoga (Item        : in Object;
                           Name_ON     : in Boolean;
                           Code_SIL_ON : in Boolean) is

   begin -- Put_To_Gnoga

      if Name_ON then
         Main_View.Put_Line ("Germe nom: " & (+Item.Name));
      end if;

      if Code_SIL_ON then
         Main_View.Put_Line ("Code SIL: " & (+Item.Code_SIL));
      end if;
   end Put_To_Gnoga;

   --------------------
   -- Read_From_File --
   --------------------
   procedure Read_From_File (File        : in Ada.Text_IO.File_Type;
                                   Item        : out Object;
                                   Name_ON     : in Boolean;
                                   Code_SIL_ON : in Boolean) is

   begin -- Read_From_File

      if Name_ON then
         Get (File      => File,
              Item      => Item.Name,
              Item_Type => "Name",
              Max       => Max_Name);
      end if;

      if Code_SIL_ON then
         Get (File      => File,
              Item      => Item.Code_SIL,
              Item_Type => "Code SIL",
              Max       => Max_Code);
      end if;

   end Read_From_File;

   -------------------
   -- Write_To_File --
   -------------------
   procedure Write_To_File (File        : in out Ada.Text_IO.File_Type;
                            Item        : in Object;
                            Name_ON     : in Boolean;
                            Code_SIL_ON : in Boolean) is
   begin -- Write_To_File

      if Name_ON then
         Ada.Text_IO.Put_Line (File => File, Item => (+Item.Name));
      end if;

      if Code_SIL_ON then
         Ada.Text_IO.Put_Line (File => File, Item => (+Item.Code_SIL));
      end if;

   end Write_To_File;

   ------------
   -- To_BCI --
   ------------
   procedure To_BCI (Item : in Object;
                     File : in out Ada.Text_IO.File_Type) is
   begin -- To_BCI

      Ada.Text_IO.Put (File => File,
                       Item => "|t1");
      Ada.Integer_Text_IO.Put (File  => File,
                               Item  => Item.Isolat,
                               Width => 0);
      Ada.Text_IO.Put (File => File,
                       Item => "|o1");
      Ada.Text_IO.Put (File => File,
                       Item => (+Item.Code_SIL));

   end To_BCI;

end Germes.IO;
