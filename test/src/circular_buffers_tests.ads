with AUnit;            use AUnit;
with AUnit.Test_Cases; use AUnit.Test_Cases;

package Circular_Buffers_Tests is

   type Circular_Buffers_Test is new Test_Cases.Test_Case with null record;

   procedure Register_Tests (T : in out Circular_Buffers_Test);
   -- Register routines to be run

   function Name (T : Circular_Buffers_Test) return Message_String;
   -- Provide name identifying the test case

   -- Test Routines:
   procedure Test_Basic_Read_Write (T : in out Test_Cases.Test_Case'Class);

end Circular_Buffers_Tests;
