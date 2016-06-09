package body Common_IO is

   procedure Get (File      : in Ada.Text_IO.File_Type;
                  Item      : out Ub_S;
                  Item_Type : in String;
                  Max       : in Positive) is
   begin -- Get

      declare

         S : String := Ada.Text_IO.Get_Line (File => File);

      begin -- declare

         if S'Length = 0 then
            raise Name_Too_Short;
         elsif S'Length <= Max then
            Item := (+S);
         else
            raise Name_Too_Long;
         end if;

      end; -- declare

   end Get;

   procedure Get (Item      : out Ub_S;
                  Item_Type : in String;
                  Max       : in Positive) is
   begin -- Get

      Get (File      => Ada.Text_IO.Standard_Input,
           Item      => Item,
           Item_Type => Item_Type,
           Max       => Max);

   end Get;

end Common_IO;
