
package body Antibiotics.IO is

   ---------
   -- Put --
   ---------
   procedure Put (File        : in Ada.Text_IO.File_Type;
                  Item        : in Object;
                  Name_ON     : in Boolean;
                  Code_SIL_ON : in Boolean;
                  CMI_ON      : in Boolean;
                  SIR_ON      : in Boolean) is
   begin -- Put

      if Name_ON then
         Ada.Text_IO.Put (File => File, Item => (+Item.Name) & ' ');
      end if;

      if Code_SIL_ON then
         Ada.Text_IO.Put (File => File, Item => (+Item.Code_SIL) & ' ');
      end if;

      if CMI_ON then
         Ada.Text_IO.Put (File => File, Item => (+Item.CMI) & ' ');
      end if;

      if SIR_ON then
         Ada.Text_IO.Put (File => File, Item => (+Item.SIR));
      end if;

      Ada.Text_IO.New_Line (File);

   end Put;

   ---------
   -- Put --
   ---------
   procedure Put (Item        : in Object;
                  Name_ON     : in Boolean;
                  Code_SIL_ON : in Boolean;
                  CMI_ON      : in Boolean;
                  SIR_ON      : in Boolean) is
   begin -- Put

      Put (File        => Ada.Text_IO.Standard_Output,
           Item        => Item,
           Name_ON     => Name_ON,
           Code_SIL_ON => Code_SIL_ON,
           CMI_ON      => CMI_ON,
           SIR_ON      => SIR_ON);

   end Put;

   ------------------
   -- Put_To_Gnoga --
   ------------------
   procedure Put_To_Gnoga (Item        : in Object;
                           Name_ON     : in Boolean;
                           Code_SIL_ON : in Boolean;
                           CMI_ON      : in Boolean;
                           SIR_ON      : in Boolean) is
   begin -- Put

      if Name_ON then
         Main_View.Put (+Item.Name & ' ');
      end if;

      if Code_SIL_ON then
         Main_View.Put (+Item.Code_SIL & ' ');
      end if;

      if CMI_ON then
         Main_View.Put (+Item.CMI & ' ');
      end if;

      if SIR_ON then
         Main_View.Put (+Item.SIR);
      end if;

      Main_View.New_Line;

   end Put_To_Gnoga;

   ---------
   -- Get --
   ---------
   procedure Get (File        : in Ada.Text_IO.File_Type;
                  Item        : out Object;
                  Name_ON     : in Boolean;
                  Code_SIL_ON : in Boolean;
                  CMI_ON      : in Boolean;
                  SIR_ON      : in Boolean) is

   begin -- Get
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
      if CMI_ON then
         Get (File      => File,
              Item      => Item.CMI,
              Item_Type => "CMI",
              Max       => Max_CMI);
      end if;
      if SIR_ON then
         Get (File      => File,
              Item      => Item.SIR,
              Item_Type => "SIR",
              Max       => Max_SIR);
      end if;
   end Get;

   ------------
   -- To_BCI --
   ------------
   procedure To_BCI (Item : in Object;
                     File : in out Ada.Text_IO.File_Type) is
   begin -- To_BCI
      Ada.Text_IO.Put (File => File,
                       Item => "|ra|a1");
      Ada.Text_IO.Put (File => File,
                       Item => (+Item.Code_SIL));
      Ada.Text_IO.Put (File => File,
                       Item => "|a3");
      Ada.Text_IO.Put (File => File,
                       Item => (+Item.CMI));
      Ada.Text_IO.Put (File => File,
                       Item => "|a4");
      Ada.Text_IO.Put (File => File,
                       Item => (+Item.SIR));
   end To_BCI;

end Antibiotics.IO;
