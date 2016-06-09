
package body Matricules.IO is

   ---------
   -- Put --
   ---------
   procedure Put (File : in Ada.Text_IO.File_Type;
                  Item : in Object) is
   begin -- Put

      Ada.Text_IO.Put (File => File,
                       Item => PragmARC.Date_Handler.Year_Image_Long
                         (Year      => Get_Year (Item.DOB),
                          Zero_Fill => True,
                          Width     => 4));

      Ada.Text_IO.Put (File => File,
                       Item => PragmARC.Date_Handler.Month_Image_Numeric
                         (Month     => Get_Month (Item.DOB),
                          Zero_Fill => True));

      Ada.Text_IO.Put (File => File,
                       Item => PragmARC.Date_Handler.Day_Image
                         (Day       => Get_Day (Item.DOB),
                          Zero_Fill => True));

      Ada.Integer_Text_IO.Put (File  => File,
                               Item  => Item.XXX,
                               Width => 0);

      if Item.C1 /= 0 then
         Ada.Integer_Text_IO.Put (File => File,
                                  Item => Item.C1,
                                  Width => 0);
      end if;

      if Item.C2 /= 0 then
         Ada.Integer_Text_IO.Put (File  => File,
                                  Item  => Item.C2,
                                  Width => 0);
      end if;
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

      Main_View.Put (PragmARC.Date_Handler.Year_Image_Long
                   (Year      => Get_Year (Item.DOB),
                    Zero_Fill => True,
                    Width     => 4));

      Main_View.Put (PragmARC.Date_Handler.Month_Image_Numeric
                   (Month     => Get_Month (Item.DOB),
                    Zero_Fill => True));

      Main_View.Put (PragmARC.Date_Handler.Day_Image
                   (Day       => Get_Day (Item.DOB),
                    Zero_Fill => True));

      Main_View.Put (Item.XXX'Img);

      if Item.C1 /= 0 then
         Main_View.Put (Trim (Item.C1'Img));
      end if;

      if Item.C2 /= 0 then
         Main_View.Put (Trim (Item.C2'Img));
      end if;
   end Put_To_Gnoga;

   ------------
   -- To_BCI --
   ------------
   procedure To_BCI (Item : in Object;
                     File : in out Ada.Text_IO.File_Type) is
   begin -- To_BCI
      Ada.Text_IO.Put (File => File,
                       Item => "|pi");

      Ada.Text_IO.Put (File => File,
                               Item => PragmARC.Date_Handler.Year_Image_Long (Year      => Get_Year (Item.DOB),
                                                                              Zero_Fill => True,
                                                                              Width     => 4));

      Ada.Text_IO.Put (File => File,
                               Item => PragmARC.Date_Handler.Month_Image_Numeric (Month     => Get_Month (Item.DOB),
                                                                                  Zero_Fill => True));

      Ada.Text_IO.Put (File => File,
                               Item => PragmARC.Date_Handler.Day_Image (Day       => Get_Day (Item.DOB),
                                                                        Zero_Fill => True));

      Ada.Integer_Text_IO.Put (File => File,
                               Item  => Item.XXX,
                               Width => 0);
      if Item.C1 /= 0 then
         Ada.Integer_Text_IO.Put (File => File,
                                  Item => Item.C1,
                                  Width => 0);
      end if;

      if Item.C2 /= 0 then
         Ada.Integer_Text_IO.Put (File  => File,
                                  Item  => Item.C2,
                                  Width => 0);
      end if;
   end To_BCI;

end Matricules.IO;
