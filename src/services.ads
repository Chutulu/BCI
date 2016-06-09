with Ada.Integer_Text_IO;
with Ada.Text_IO;
with Common_IO; use Common_IO;

package Services is

   Max_Service : constant Positive := 9999;

   subtype Service_Type is Positive range 1 .. Max_Service;

   type Object is private;

   -- Setters

   -----------------
   -- Set_Service --
   -----------------
   procedure Set_Service (Item : out Object; Code_Service : in Service_Type);
   -- Pre: Item and Service are defined
   -- Post: Sets the corresponding value of Item

   -- Getters

   -----------------
   -- Get_Service --
   -----------------
   function Get_Service (Item : in Object) return Service_Type;
   -- Pre: Item is defined
   -- Post: returns the corresponding value of Item

   -- Constructors

   ----------
   -- Make --
   ----------
   function Make (Code_Service : in Service_Type) return Object;
   -- Pre: ID is defined
   -- Post: returns an Item of type Service

private

   type Object is record

      Code_Service : Service_Type := 190;

   end record;

end Services;
