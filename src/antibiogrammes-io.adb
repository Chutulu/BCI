
package body Antibiogrammes.IO is

   ---------
   -- Put --
   ---------
   procedure Put (File : in Ada.Text_IO.File_Type;
                  Item : in Object) is
   begin -- Put

      Ada.Text_IO.Put (File => File, Item => "Code SIL de la culture: ");

      Culture_IO.Put (File => File, Item => Item.Culture);

      Ada.Text_IO.New_Line (File);

      Cards.IO.Put (File                   => File,
                    Item                   => Item.Card,
                    Name_ON                => True,
                    Antibiotique_SIL_ON    => False,
                    Carte_SIL_ON           => True,
                    CMI_ON                 => True,
                    SIR_ON                 => True);

   end Put;

   ---------
   -- Put --
   ---------
   procedure Put (Item : in Object) is

   begin -- Put

      Put (File => Ada.Text_IO.Standard_Output,
           Item => Item);

   end Put;

   ------------------
   -- Put_To_Gnoga --
   ------------------
   procedure Put_To_Gnoga (Item : in Object) is

   begin -- Put_To_Gnoga

      Main_View.Put ("Code SIL de la culture: ");
      Main_View.Put (Item.Culture'Img);

      Cards.IO.Put_To_Gnoga (Item                   => Item.Card,
                             Name_ON                => True,
                             Antibiotique_SIL_ON    => False,
                             Carte_SIL_ON           => True,
                             CMI_ON                 => True,
                             SIR_ON                 => True);

   end Put_To_Gnoga;

   ------------
   -- To_BCI --
   ------------
   procedure To_BCI (Item : in Object;
                     File : in out Ada.Text_IO.File_Type) is

   begin -- To_BCI

      Ada.Text_IO.Put (File => File,
                       Item => "|ct");
      Culture_IO.Put (File => File,
                       Item => Item.Culture);
      Cards.IO.To_BCI (File => File,
                        Item => Item.Card);

   end To_BCI;

end Antibiogrammes.IO;
