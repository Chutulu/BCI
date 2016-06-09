with Ada.Exceptions;
with Ada.IO_Exceptions;
with Ada.Text_IO;
with Gnat.Traceback.Symbolic; use Gnat;

with Common_Defs_BCI; use Common_Defs_BCI;
with Dates;
with Dates.IO; use Dates.IO;

with BCI_Messages;
with Ada.Strings.Unbounded;

procedure Import_BCI is

   Log_File  : Ada.Text_IO.File_Type;

   ------------------
   -- Read_Message --
   ------------------
   procedure Read_Message (File         : in Ada.Text_IO.File_Type;
                           Buffer       : out Ub_S;
                           Has_Finished : out Boolean)
   is
   begin -- Read_Message
      Has_Finished := False;
      Buffer := +"";

      while not Ada.Text_IO.End_Of_File (File) loop
         declare
            Line     : String := Ada.Text_IO.Get_Line (File => File);

         begin -- declare

            Ada.Text_IO.Put_Line ("Line: " & Line);
            Ada.Text_IO.Put_Line ("Line'Length" & Integer'Image (Line'Length));
            Ada.Text_IO.Put_Line ("Line'Last" & Integer'Image (Line'Last));


            U_B.Append (Source   => Buffer,
                        New_Item => Line (5 .. Line'Last));

            Ada.Text_IO.Put_Line ("Buffer after append: " & (+Buffer));

            Ada.Text_IO.Put_Line ("Buffer'Last" & Integer'Image (Line'Last));


            Ada.Text_IO.Put_Line ("Buffer out: " & (+Buffer));
            Ada.Text_IO.New_Line;

         end;
      end loop;
   end Read_Message;

   ---------------
   -- File_Name --
   ---------------
   function File_Name (Item : Dates.Object) return String is
   begin -- File_Name
      return "vba-" & Dates.IO.Image (Item => Item, Format => Numeric_Reverse) & ".log";
   end File_Name;

begin -- Main

   Ada.Text_IO.Put_Line ("Start Main");

   declare

      Message_Buf : Ub_S := +"";
      Success     : Boolean;

      Log_File_Name : String := "vba-20150119.log";

      use type Dates.Object;
      Begin_Date  : constant Dates.Object := Dates.Make (Year  => 2015,
                                                         Month => 09,
                                                         Day   => 19);
      End_Date    : constant Dates.Object := Dates.Make (Year  => 2015,
                                                         Month => 09,
                                                         Day   => 19);
      Temp_Date : Dates.Object := Begin_Date;

   begin -- declare

      Success := False;

      loop
         exit when Temp_Date > End_Date;

         -- 1) define file_name
         -- 1.1) from date - to date
         -- 1.2) file_name: vba-date(yyyymmdd).log
         Log_File_Name := File_Name (Temp_Date);

         -- 2) open file(file_name)
         -- open the file and associate it with the file variable name
         Ada.Text_IO.Open (File => Log_File,
                           Mode => Ada.Text_IO.In_File, Name => Log_File_Name);
         Ada.Text_IO.Put_Line ("File " & Log_File_Name & " read");

         while not Ada.Text_IO.End_Of_File (Log_File) loop

            -- 3) read content(File_Name)

            Read_Message (File         => Log_File,
                          Buffer       => Message_Buf,
                          Has_Finished => Success);

            Ada.Text_IO.Put_Line ("Message Buffer main: " & (+Message_Buf));
         end loop;

         -- 5) close file(File_Name)
         Ada.Text_IO.Close (File => Log_File);
         Ada.Text_IO.Put_Line ("File " & Log_File_Name & " closed");

         Temp_Date := Temp_Date + 1;
      end loop;

      -- 4) extract informations(File_Name)

      -- 6) save informations

   end; -- declare

exception

   when Err : others =>
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put_Line ("Error: " &
                              Ada.Exceptions.Exception_Information (Err));

      Ada.Text_IO.Put_Line (Traceback.Symbolic.Symbolic_Traceback (Err));

end Import_BCI;
