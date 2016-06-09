
package Patients.IO is

   ---------
   -- Put --
   ---------
   procedure Put (File        : in Ada.Text_IO.File_Type;
                  Item        : in Object);
   -- writes an Object record to a file
   -- Pre: Item is defined
   -- Post: writes the fields of Item to file

   ---------
   -- Put --
   ---------
   procedure Put (Item : in Object);
   -- displays a Patient record on the screen
   -- Pre: Item is defined
   -- Post: displays the fields of Item on the screen

   ------------------
   -- Put_To_Gnoga --
   ------------------
   procedure Put_To_Gnoga (Item : in Object);
   -- displays a Patient record on the screen
   -- Pre: Item is defined
   -- Post: displays the fields of Item on the screen via gnoga

   ------------
   -- To_BCI --
   ------------
   procedure To_BCI (Item : in Object;
                     File : in out Ada.Text_IO.File_Type);
   -- writes the content of Item in the BCI format into a file
   -- Pre: Item and File are defined
   -- Post: writes the content of Item into File

end Patients.IO;
