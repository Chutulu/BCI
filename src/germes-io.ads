package Germes.IO is

   ---------
   -- Put --
   ---------
   procedure Put (File        : in Ada.Text_IO.File_Type;
                  Item        : in Object;
                  Name_ON     : in Boolean;
                  Code_SIL_ON : in Boolean);
   -- writes an Object record to a file
   -- Pre: Item is defined
   -- Post: writes the fields of Item to file

   ---------
   -- Put --
   ---------
   procedure Put (Item        : in Object;
                  Name_ON     : in Boolean;
                  Code_SIL_ON : in Boolean);
   -- displays an Object record on screen
   -- Pre: Item is defined
   -- Post: displays the fields of Item on screen

   ------------------
   -- Put_To_Gnoga --
   ------------------
   procedure Put_To_Gnoga (Item        : in Object;
                           Name_ON     : in Boolean;
                           Code_SIL_ON : in Boolean);
   -- displays an Object record on screen
   -- Pre: Item is defined
   -- Post: displays the fields of Item on screen via gnoga

   --------------------
   -- Read_From_File --
   --------------------
   procedure Read_From_File (File        : in Ada.Text_IO.File_Type;
                             Item        : out Object;
                             Name_ON     : in Boolean;
                             Code_SIL_ON : in Boolean);
   -- reads an Germe record from a file
   -- Pre: File is defined
   -- Post: returns an Item of type Germe

   -------------------
   -- Write_To_File --
   -------------------
   procedure Write_To_File (File           : in out Ada.Text_IO.File_Type;
                            Item           : in Object;
                            Name_ON        : in Boolean;
                            Code_SIL_ON    : in Boolean);
   -- writes an Germe record to a file
   -- Pre: Item is defined
   -- Post: writes the fields of Item to a file

   procedure To_BCI (Item : in Object;
                     File : in out Ada.Text_IO.File_Type);
   -- writes the content of Item in the BCI format into a file
   -- Pre: Item and File are defined
   -- Post: writes the content of Item into File

end Germes.IO;
