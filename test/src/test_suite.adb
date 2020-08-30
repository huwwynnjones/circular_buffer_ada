with Circular_Buffers_Tests;

package body Test_Suite is

   -- Statically allocate test suite:
   Result : aliased AUnit.Test_Suites.Test_Suite;

   --  Statically allocate test cases:
   Circular_Buffers_Test : aliased Circular_Buffers_Tests.Circular_Buffers_Test;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
   begin
      AUnit.Test_Suites.Add_Test (Result'Access, Circular_Buffers_Test'Access);
      return Result'Access;
   end Suite;

end Test_Suite;
