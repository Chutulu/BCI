-- 9.8.2017: modified to take care of additional EOL

with Ada.Exceptions;
with Ada.Integer_Text_IO;
with Ada.IO_Exceptions;
with Ada.Strings.Unbounded;
with Ada.Text_IO;
with Gnat.Traceback.Symbolic; use Gnat;

with Common_Defs_BCI; use Common_Defs_BCI;
with Dates;
with Dates.IO; use Dates.IO;

with PragmARC.Text_IO;

-- with BCI_Messages;

procedure Import_BCI is

   -- Length of the pesky time stamp which contaminates every single line
   T_Stamp : constant Positive := 37;

   -- additional line endings, if true the logfile has an additional and visible
   -- line ending in the form of <CR><LF>
   Additional_EOL: Boolean:= True;
   Additinal_EOL_Lenght: constant Positive := 8;

   type File_Kind is (Save, Log);

   Log_File  : PragmARC.Text_IO.File_Handle;
   Save_File : PragmARC.Text_IO.File_Handle;

   -- character used to separate the different values in the CSV file
   CSV_Sep_Char : constant String := ";";

   use type Dates.Object;
   Begin_Date   : Dates.Object;
   End_Date : Dates.Object;

   -- bunch of constants used in the BCI message protocol; should perhaps be moved
   -- to a separate file or distributed among the different packages using them

   ETX      : constant String := "<ETX>"; -- end of message
   ACK      : constant String := "<ACK>";
   ENQ      : constant String := "<ENQ>";
   NAK      : constant String := "<NAK>";
   EOT      : constant String := "<EOT>"; -- end of transmission
   STX      : constant String := "<STX>"; -- message start
   GS       : constant String := "<GS>"; -- checksum
   RS       : constant String := "<RS>"; -- message record
   MTMPR    : constant String := "mtmpr"; -- message received from LIS
   MTRSL    : constant String := "mtrsl"; -- message send to LIS

   FS       : constant String := "|"; -- field separator

   PI       : constant String := "pi"; -- patient id#
   P2       : constant String := "p2"; -- service
   PP       : constant String := "pp"; -- medecin/demandeur code SIL
   P5       : constant String := "p5"; -- medecin/demandeur code SIL
   SI       : constant String := "si"; -- not used
   S0       : constant String := "s0"; -- collection #
   SS       : constant String := "ss"; -- sample type
   ST       : constant String := "st"; -- sample type long name
   S5       : constant String := "s5"; -- unknown
   CI       : constant String := "ci"; -- exam/culture id#
   C0       : constant String := "c0"; -- unknown
   CT       : constant String := "ct"; -- culture type
   TA       : constant String := "ta"; -- test separator
   RT       : constant String := "rt"; -- test type code aka AST name
   RR       : constant String := "rr"; -- AST lot #?
   T1       : constant String := "t1"; -- isolat #
   O1       : constant String := "o1"; -- organism code
   RA       : constant String := "ra"; -- test separator
   A1       : constant String := "a1"; -- drug code
   A2       : constant String := "a2"; -- final MIC
   A3       : constant String := "a3"; -- final result
   ZZ       : constant String := "zz"; -- end message

   -- Debug: Boolean:= False; uncomment the blocks commented with "debugging"

   ------------------
   -- Read_Message --
   ------------------
   procedure Read_Message (File         : in PragmARC.Text_IO.File_Handle;
                           Buffer       : out Ub_S;
                           Has_Finished : out Boolean)
   is
   begin -- Read_Message
      Has_Finished := False;
      Buffer := +"";

      while not Has_Finished loop
         declare
            S     : String := PragmARC.Text_IO.Get_Line (File => File);
            -- this useless timestamp wastes only space
            Line  : String (1 .. S'Length - T_Stamp);

         begin -- declare

            Line (1 .. Line'Last) := S (T_Stamp + 1 .. S'Last );

            -- debugging
            -- if Debug = True then
               -- Ada.Text_IO.Put_Line ("Line: " & Line);
               -- Ada.Text_IO.Put_Line ("Line'Length" & Integer'Image (Line'Length));
               -- Ada.Text_IO.Put_Line ("Line'Last" & Integer'Image (Line'Last));
            -- end if;

            if Line (1 .. 5) = EOT then
               -- we have reached the end of the message so we can exit the loop
               -- and hand over the Buffer for treatment
               -- Has_Finished has to be set to True

               Has_Finished := True;
               exit; -- end of message

            elsif Line (1 .. 5) = ETX -- line contains <ETX>
              or Line (1 .. 5) = ACK -- <ACK>
              or Line (1 .. 5) = ENQ -- <ENQ>
              or Line (1 .. 5) = STX -- <STX>
              or Line (1 .. 4) = GS -- <GS>

            then -- we don't need them
               null; -- so just ignore them

            elsif Line (1 .. 4) = RS -- so Line contains <RS> which indicates
            -- the begin of a message
            then -- we have to take care of those lines
               if Additional_EOL = True then
                  U_B.Append (Source   => Buffer,
                              New_Item => Line (5 .. Line'Last- Additinal_EOL_Lenght));
               else
                  U_B.Append (Source   => Buffer,
                              New_Item => Line (5 .. Line'Last));
               end if;

            else -- Line contains garbage
               null; -- who cares?
            end if;

         end; -- declare
      end loop;

   exception
      when PragmARC.Text_IO.Character_IO.End_Error => null;

   end Read_Message;

   -------------------
   -- Treat_Message --
   -------------------
   procedure Treat_Message (Buffer    : in Ub_S;
                            Save_File : in out PragmARC.Text_IO.File_Handle)
   is
      Line          : String (1 .. U_B.Length (Buffer));
      Current, Last : Natural;

   begin -- Treat_Message

      Line := +Buffer;
      Current := 1;
      Last := 0;

      -- debugging
      -- if Debug = True then
         -- Ada.Text_IO.Put_Line ("<Line> " & Line & " <Line/>");
      -- end if;

      while Current <= Line'Last loop

         if Line (Current .. Current) = FS -- contains |
         then -- we arrived at the next separator and the end of a message field
            declare
               Token : String (Last + 1 .. Current - 1);
            begin -- declare
               Token := Line (Last + 1 .. Current - 1);

               -- debugging
               -- if Debug = True then
                  -- Ada.Text_IO.Put_Line ("<Token> " & Token & " <Token/>");
               -- end if;

               if Line (1 .. 5) = MTMPR -- contains mtmpr
               then -- no need/place for this info atm
                  null;

               elsif Line (1 .. 5) = MTRSL then -- we have a message to the LIS which we need to analyse

                  if Token = MTRSL -- we don't want to have those fields in our csv file
                    or Token (Token'First .. Token'First + 1) = TA -- dito
                    or Token (Token'First .. Token'First + 1) = RA -- dito
                    or Token (Token'First .. Token'First + 1) = S5 -- dito
                  then
                     null;

                  elsif  Token (Token'First .. Token'First + 1) = ZZ -- end of the message
                  then -- so we need a new line for the next message
                     PragmARC.Text_IO.New_Line (File    => Save_File,
                                                Spacing => 1);
                  else -- line contains the data we need
                     PragmARC.Text_IO.Put (File => Save_File,
                                           Item => Token (Token'First + 2 .. Token'Last));
                     PragmARC.Text_IO.Put (File => Save_File,
                                           Item => CSV_Sep_Char);
                  end if;

               end if;
               Last := Current;
            end; -- declare
         end if;

         Current := Current + 1;
      end loop;
   end Treat_Message;

   ---------------
   -- Read_Date --
   ---------------
   procedure Read_Date (Begin_Date, End_Date : out Dates.Object)
   is

   begin -- Read_Date

      loop -- Begin_Date
         begin -- exception handler
            Ada.Text_IO.Put ("Begin date (DD MM YYYY): ");
            Dates.IO.Get (Item => Begin_Date);
            exit; -- Item is a valid Date

         exception
            when Dates.Date_Error =>
               Ada.Text_IO.Put_Line ("Wrong date format please try again");
         end; -- exception handler
      end loop;

      loop -- End_Date
         begin -- exception handler
            Ada.Text_IO.Put ("End date (DD MM YYYY): ");
            Dates.IO.Get (Item => End_Date);
            exit; -- Item is a valid Date

         exception
            when Dates.Date_Error =>
               Ada.Text_IO.Put_Line ("Wrong date format please try again");
         end; -- exception handler
      end loop;

   end Read_Date;

   --------------------
   -- Make_File_Name --
   --------------------
   function Make_File_Name (Begin_Date : Dates.Object;
                            End_Date   : Dates.Object;
                            File_Type  : File_Kind) return String
   is
   begin -- Make_File_Name
      if File_Type = Log -- file is a log file
      then
         return "vba-" & Dates.IO.Image (Item => Begin_Date, Format => Numeric_Reverse) & ".log";
      else -- file is a save file
         return Dates.IO.Image (Item => Begin_Date, Format => Numeric_Reverse)
           & "-" & Dates.IO.Image (Item => End_Date, Format => Numeric_Reverse) & ".csv";
      end if;
   end Make_File_Name;

begin -- Main

   Ada.Text_IO.Put_Line ("Start Main");
   Ada.Text_IO.New_Line;

   declare

      Message_Buf : Ub_S := +"";
      Success     : Boolean;

      BCI_Log_File_Name : String := "vba-20150119.log"; -- too lazy to count the lenght of the file name
      -- to remember the name format
      Save_File_Name    : String := "20150101-20150331.csv"; -- save file  name composed of begin date to end date

      Temp_Date         : Dates.Object;

   begin -- declare

      Read_Date (Begin_Date, End_Date); -- get the period for the files we want to look for
      Temp_Date := Begin_Date; -- begin with the first one

      Success := False; -- for the moment not needed

      Save_File_Name := Make_File_Name (Begin_Date => Begin_Date,
                                        End_Date   => End_Date,
                                        File_Type  => Save);
      -- open the save file and associate it with the file variable name
      PragmARC.Text_IO.Create (File => Save_File,
                               Mode => PragmARC.Text_IO.Out_File,
                               Name => Save_File_Name,
                               EOL  => PragmARC.Text_IO.Unix_EOL);

      Main : loop
         begin -- exception handling

            BCI_Log_File_Name := Make_File_Name (Begin_Date => Temp_Date,
                                                 End_Date   => End_Date,
                                                 File_Type  => Log);

            -- open the log file and associate it with the file variable name
            PragmARC.Text_IO.Open (File => Log_File,
                                   Mode => PragmARC.Text_IO.In_File,
                                   Name => BCI_Log_File_Name);

            Ada.Text_IO.New_Line;
            Ada.Text_IO.Put_Line ("File " & BCI_Log_File_Name & " read");

            Read_Log_File :
            while not PragmARC.Text_IO.End_Of_File (Log_File) loop

               -- read the log file
               Read_Message (File         => Log_File,
                             Buffer       => Message_Buf,
                             Has_Finished => Success);

               -- treat the messages from the log file which Read_Message has found
               Treat_Message (Buffer    => Message_Buf,
                              Save_File => Save_File);

            end loop Read_Log_File;

            -- close the log file
            PragmARC.Text_IO.Close (File => Log_File);
            Ada.Text_IO.Put_Line ("File " & BCI_Log_File_Name & " closed");
            Ada.Text_IO.New_Line;

            Temp_Date := Temp_Date + 1;
            exit Main when Temp_Date > End_Date;

         exception
            when Ada.IO_Exceptions.Name_Error => -- the file we try to open doesn't exist
               Ada.Text_IO.Put_Line ("File " & BCI_Log_File_Name & " not found");
               Temp_Date := Temp_Date + 1; -- so try the next one

         end; -- exception handling

      end loop Main;

      -- close the save file
      PragmARC.Text_IO.Close (File => Save_File);

   end; -- declare

exception

   when Err : others =>
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put_Line ("Error: " &
                              Ada.Exceptions.Exception_Information (Err));

      Ada.Text_IO.Put_Line (Traceback.Symbolic.Symbolic_Traceback (Err));

end Import_BCI;
