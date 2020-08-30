with Ada.Text_IO; use Ada.Text_IO;
with Test_Suite;
with AUnit.Run;
with AUnit.Reporter.Text;

procedure main is
   procedure Run is new AUnit.Run.Test_Runner (Test_Suite.Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Run (Reporter);
end main;
