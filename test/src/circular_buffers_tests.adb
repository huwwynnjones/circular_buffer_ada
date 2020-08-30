with AUnit.Assertions; use AUnit.Assertions;
with AUnit.Test_Cases; use AUnit.Test_Cases.Registration;
with Circular_Buffers;

package body Circular_Buffers_Tests is

   procedure Register_Tests (T : in out Circular_Buffers_Test) is
   begin
      Register_Routine
        (T, Test_Basic_Read_Write'Access,
         "Test simple reading and writing into buffer");
   end Register_Tests;

   function Name (T : Circular_Buffers_Test) return Message_String is
   begin
      return Format ("Circular buffer tests");
   end Name;

   package CB_Natural is new Circular_Buffers (T => Natural, Max_Size => 5);

   procedure Test_Basic_Read_Write (T : in out Test_Cases.Test_Case'Class) is
      Buf        : CB_Natural.Circular_Buffer;
      Write_Item : constant Natural := 3;
      Read_Item  : Natural;
   begin
      CB_Natural.Write (C => Buf, Item => Write_Item);
      Assert
        ((CB_Natural.Read (Buf) = Write_Item),
         "Item read did not match that written");
      CB_Natural.Next_Read (Buf);
      Read_Item := CB_Natural.Read (Buf);
      Assert
        (Read_Item = Write_Item,
         "Got" & Read_Item'Image & " Expected" & Write_Item'Image);
   end Test_Basic_Read_Write;

end Circular_Buffers_Tests;
