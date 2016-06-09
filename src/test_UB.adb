with Ada.Text_IO;
with Ada.Strings.Unbounded;

procedure Test_UB is

   package U_B renames Ada.Strings.Unbounded;
   subtype Ub_S is U_B.Unbounded_String;

   function "+" (Right : U_B.Unbounded_String) return String
                 renames U_B.To_String;

   function "+" (Right : String) return U_B.Unbounded_String
   is (U_B.To_Unbounded_String (Right));

   Log_File    : Ada.Text_IO.File_Type;
   Message_Buf : Ub_S;

   ------------------
   -- Read_Message --
   ------------------
   procedure Read_Message (File         : in Ada.Text_IO.File_Type;
                           Buffer       : out Ub_S)
   is
   begin -- Read_Message

      while not Ada.Text_IO.End_Of_File (File) loop
         declare
            Line     : String := Ada.Text_IO.Get_Line (File => File);

         begin -- declare

            Ada.Text_IO.Put_Line ("Line: " & Line);

            U_B.Append (Source   => Buffer,
                        New_Item => Line);

            Ada.Text_IO.Put_Line ("Buffer after append: " & (+Buffer));
            Ada.Text_IO.New_Line;

         end;
      end loop;
   end Read_Message;

begin -- Main

   Ada.Text_IO.Open (File => Log_File,
                     Mode => Ada.Text_IO.In_File, Name => "Test.log");

   Read_Message (File         => Log_File,
                 Buffer       => Message_Buf);

   Ada.Text_IO.Close (File => Log_File);

end Test_UB;
