with My_Strings; use My_Strings;
with My_Strings.Handle; use My_Strings.Handle;

package Base_Types is

   type Base_Type is abstract tagged private;

   function Create return Base_Type is abstract;

private

   type Base_Type is abstract tagged
      record
         Name : My_Safe_String;
         Code_SIL : My_Safe_String;
      end record;

end Base_Types;
