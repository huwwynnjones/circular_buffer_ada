with AUnit.Assertions;      use AUnit.Assertions;
with Circular_Buffers;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;


package body Circular_Buffers_Tests is
   use Test_Cases.Registration;

   procedure Register_Tests (T : in out Circular_Buffers_Test) is
   begin
      Register_Routine
        (T, Test_Basic_Read_Write'Access,
         "Test simple reading and writing into buffer");
      Register_Routine
        (T, Test_Overwriting'Access,
         "Test that the buffer overwrites when moving past the end of the buffer");
      Register_Routine
        (T, Test_Reader_Matches_Writer'Access,
         "Test we can know when the reader catches up with the writer");
      Register_Routine (T, Test_Read_Pre_Condition'Access, "Test pre-condition on Next_Read");
   end Register_Tests;

   function Name (T : Circular_Buffers_Test) return Message_String is
   begin
      return Format ("Circular buffer tests");
   end Name;

   package CB_Natural is new Circular_Buffers (T => Natural, Max_Size => 5);

   procedure Test_Basic_Read_Write (T : in out Test_Cases.Test_Case'Class) is
      Buf        : CB_Natural.Circular_Buffer;
      Write_Item : constant Natural := 3;
   begin
      CB_Natural.Write (CB => Buf, Item => Write_Item);
      Assert
        ((CB_Natural.Read (Buf) = Write_Item),
         "Item read did not match that written");
   end Test_Basic_Read_Write;

   package CB_Char is new Circular_Buffers (T => Character, Max_Size => 6);

   procedure Test_Overwriting (T : in out Test_Cases.Test_Case'Class) is
      Buf            : CB_Char.Circular_Buffer;
      Input          : constant String := "Hello Ada";
      Output         : Unbounded_String;
      Correct_Output : constant String := "Adalo ";
   begin
      for C in Input'Range loop
         CB_Char.Write (Buf, Input (C));
         CB_Char.Next_Write (Buf);
      end loop;
      for I in 1 .. 6 loop
         Append (Output, CB_Char.Read (Buf));
         CB_Char.Next_Read (Buf);
      end loop;
      Assert (To_String (Output), Correct_Output, "Overwrite not correct");
   end Test_Overwriting;

   procedure Test_Reader_Matches_Writer (T : in out Test_Cases.Test_Case'Class)
   is
      Buf            : CB_Char.Circular_Buffer;
      Input          : constant String := "Hello Ada";
      Output         : Unbounded_String;
      Correct_Output : constant String := "Adalo Ada";
   begin
      for C in Input'Range loop
         CB_Char.Write (Buf, Input (C));
         CB_Char.Next_Write (Buf);
      end loop;
      while not CB_Char.Reader_Matches_Writer (Buf) loop
         Append (Output, CB_Char.Read (Buf));
         CB_Char.Next_Read (Buf);
      end loop;
      Assert (To_String (Output), Correct_Output, "Overwrite not correct");
   end Test_Reader_Matches_Writer;

   procedure Test_Read_Pre_Condition (T : in out Test_Cases.Test_Case'Class) is
      Buf   : CB_Char.Circular_Buffer;
      Input : constant String := "Hello Ada";
   begin
      for C in Input'Range loop
         CB_Char.Write (Buf, Input (C));
         CB_Char.Next_Write (Buf);
      end loop;
      for I in Input'Range loop
         CB_Char.Next_Read (Buf);
      end loop;
      CB_Char.Next_Read (Buf);
      Assert (False, "Pre check not triggered");
   exception
      when others =>
         Assert (True, "Pre check triggered");
   end Test_Read_Pre_Condition;

end Circular_Buffers_Tests;
