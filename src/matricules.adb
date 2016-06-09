
package body Matricules is

   -- Setters

   -----------------
   -- Set_Rnd_Nbr --
   -----------------
   procedure Set_Rnd_Nbr (Item    : in out Object;
                          Rnd_Nbr : in Rnd_Nbr_Type) is
   begin
      Item.XXX := Rnd_Nbr;
   end Set_Rnd_Nbr;

   ------------
   -- Set_C1 --
   ------------
   procedure Set_C1 (Item : in out Object;
                     C1   : in Control_Digit_Type) is
   begin
      Item.C1 := C1;
   end Set_C1;

   ------------
   -- Set_C2 --
   ------------
   procedure Set_C2 (Item : in out Object;
                     C2   : in Control_Digit_Type) is
   begin
      Item.C2 := C2;
   end Set_C2;

   -- Getters

   -----------------
   -- Get_Rnd_Nbr --
   -----------------
   function Get_Rnd_Nbr (Item : in Object) return Rnd_Nbr_Type is
   begin
      return Item.XXX;
   end Get_Rnd_Nbr;

   ------------
   -- Get_C1 --
   ------------
   function Get_C1 (Item : in Object) return Control_Digit_Type is
   begin
      return Item.C1;
   end Get_C1;

   ------------
   -- Get_C2 --
   ------------
   function Get_C2 (Item : in Object) return Control_Digit_Type is
   begin
      return Item.C2;
   end Get_C2;

   -- Constructor

   ----------
   -- Make --
   ----------
   function Make (Year  : in Year_Number;
                            Month : in Month_Number;
                            Day     : in Day_Number;
                            Rnd_Nbr : in Rnd_Nbr_Type;
                            C1, C2  : in Control_Digit_Type) return Object is
      Item : Object;

   begin

      Set_Year (Item => Item.DOB, Year => Year);
      Set_Month (Item => Item.DOB, Month => Month);
      Set_Day (Item => Item.DOB, Day => Day);
      Item.XXX := Rnd_Nbr;
      Item.C1 := C1;
      Item.C2 := C2;

      return Item;

   end Make;

   function Make (Matricule : in String) return Object is

      Item : Object;

   begin -- Make

      if  Matricule'Length < Min_Length or Matricule'Length > Max_Length then
         raise Constraint_Error;
      end if;

      if Matricule'Length >= Min_Length then
         Set_Year (Item.DOB, Year_Number'Value (Matricule (Matricule'First .. Matricule'First + 3)));
         Set_Month (Item.DOB, Month_Number'Value (Matricule (Matricule'First + 4 .. Matricule'First + 5)));
         Set_Day (Item.DOB, Day_Number'Value (Matricule (Matricule'First + 6 .. Matricule'First + 7)));
         Item.XXX := Rnd_Nbr_Type'Value (Matricule (Matricule'First + 8 .. Matricule'First + 10));
      end if;

      if Matricule'Length = Max_Length then
         Item.C1 := Control_Digit_Type'Value (Matricule (Matricule'First + 11 .. Matricule'First + 11));
         Item.C2 := Control_Digit_Type'Value (Matricule (Matricule'First + 12 .. Matricule'First + 12));
      end if;

      return Item;

   end Make;

   -- Others
--     function Is_Valid (Item : in Matricule) return Boolean is
--        Success : Boolean := False;
--     begin
--        pragma Compile_Time_Warning(True,"Is_Valid not finished");
--        return Success;
--     end Is_Valid;

end Matricules;
