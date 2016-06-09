package Cards.IO is

   ---------
   -- Put --
   ---------
   procedure Put (File                   : in Ada.Text_IO.File_Type;
                  Item                   : in Object;
                  Name_ON                : in Boolean;
                  Antibiotique_SIL_ON    : in Boolean;
                  Carte_SIL_ON           : in Boolean;
                  CMI_ON                 : in Boolean;
                  SIR_ON                 : in Boolean);
   -- writes an Object record to a file
   -- Pre: Item is defined
   -- Post: writes the fields of Item to a file

   -------------
   -- Put --
   -------------
   procedure Put (Item                   : in Object;
                  Name_ON                : in Boolean;
                  Antibiotique_SIL_ON    : in Boolean;
                  Carte_SIL_ON           : in Boolean;
                  CMI_ON                 : in Boolean;
                  SIR_ON                 : in Boolean);
   -- displays an Object record on the screen
   -- Pre: Item is defined
   -- Post: displays the fields of Item on the screen

   ------------------
   -- Put_To_Gnoga --
   ------------------
   procedure Put_To_Gnoga (Item                   : in Object;
                           Name_ON                : in Boolean;
                           Antibiotique_SIL_ON    : in Boolean;
                           Carte_SIL_ON           : in Boolean;
                           CMI_ON                 : in Boolean;
                           SIR_ON                 : in Boolean);
   -- displays an Object record on the screen
   -- Pre: Item is defined
   -- Post: displays the fields of Item on the screen via gnoga

   --------------------------
   -- Read_Card_From_File --
   --------------------------
   procedure Read_Card_From_File (File        : in Ada.Text_IO.File_Type;
                                  Item        : out Object;
                                  Name_ON     : in Boolean;
                                  Code_SIL_ON : in Boolean;
                                  CMI_ON      : in Boolean;
                                  SIR_ON      : in Boolean);
   -- reads an Card record from a file
   -- Pre: File is defined
   -- Post: returns an Item of type Card

   -------------------------
   -- Write_Card_To_File --
   -------------------------
   procedure Write_Card_To_File (File           : in out Ada.Text_IO.File_Type;
                                 Item           : in Object;
                                 Name_ON        : in Boolean;
                                 Code_SIL_ON    : in Boolean;
                                 CMI_ON         : in Boolean;
                                 SIR_ON         : in Boolean);
   -- writes an Card record to a file
   -- Pre: Item is defined
   -- Post: writes the fields of Item to a file

   ------------
   -- To_BCI --
   ------------
   procedure To_BCI (Item : in Object;
                     File : in out Ada.Text_IO.File_Type);
   -- writes the content of Item in the BCI format into a file
   -- Pre: Item and File are defined
   -- Post: writes the content of Item into File

end Cards.IO;
