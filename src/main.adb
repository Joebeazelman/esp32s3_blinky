with ESP32.GPIO;
procedure main with
  No_Return
is
   --use type Ada.Real_Time.Time;

   Button : constant := 0;   --  Button pad
   LED    : constant := 25;  --  LED pad
begin
   ESP32.GPIO.Configure_All
     (((Pad       => LED, IO_MUX => ESP32.GPIO.GPIO_Matrix,
        Direction => ESP32.GPIO.Output,
        Output    => ESP32.GPIO.GPIO_OUT),  --  for Set_Level
       (Pad       => Button, IO_MUX => ESP32.GPIO.GPIO_Matrix,
        Direction => ESP32.GPIO.Input, Interrupt => ESP32.GPIO.Disabled,
        Input     => ESP32.GPIO.None)));    --  for Get_Level

   loop
      for J in 1 .. 10 loop
         --  Turl LED if button is not pressed
         ESP32.GPIO.Set_Level
           (LED, (J mod 2 = 1) and then ESP32.GPIO.Get_Level (Button));
      end loop;
   end loop;

   --  Make sure that main subprogram doen't return in a real project!
end main;
