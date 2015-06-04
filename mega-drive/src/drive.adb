-- Copyright (c) 2015 Kyle Isom <coder@kyleisom.net>
--
-- Permission is hereby granted, free of charge, to any person obtaining a
-- copy of this software and associated documentation files (the "Software"),
-- to deal in the Software without restriction, including without limitation
-- the rights to use, copy, modify, merge, publish, distribute, sublicense,
-- and/or sell copies of the Software, and to permit persons to whom the
-- Software is furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included
-- in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
-- THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
-- OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
-- ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
-- OTHER DEALINGS IN THE SOFTWARE.

-- Blink demo for the Arduino Mega 2560. Prints a hello message on serial,
-- then begins blinking the LED.

--  pragma Profile (Ravenscar);

with AVR;
use  AVR;

with Interfaces;
use  Interfaces;

with AVR.MCU;             -- port and pin definitions.
with AVR.Real_Time.Clock; -- required for delay to work.
pragma Unreferenced (AVR.Real_Time.Clock);
with AVR.Timer1;

procedure Drive is

   Right_Motor : Boolean renames MCU.PORTB_Bits (3); -- digital pin 11
   Left_Motor  : Boolean renames MCU.PORTB_Bits (4); -- digital pin 12
   LED1        : Boolean renames MCU.PORTH_Bits (5); -- digital pin 8
   LED2        : Boolean renames MCU.PORTH_Bits (4); -- digital pin 7
   Speed       : Interfaces.Unsigned_16 := 1000;

begin
   MCU.DDRB_Bits :=  (others => DD_Output);
   MCU.DDRH_Bits :=  (others => DD_Output);
   Timer1.Init_PWM (Timer1.Scale_By_8,
                    Timer1.Fast_PWM_8bit,
                    False);


   MCU.DDRB_Bits (3) := DD_Output;
   MCU.DDRB_Bits (4) := DD_Output;
   MCU.DDRH_Bits (4) := DD_Output;
   MCU.DDRH_Bits (5) := DD_Output;

   LED1 := High;
   LED2 := High;

   MCU.PRR1_Bits (MCU.PRTIM1_Bit) := Low;
   MCU.TCCR1A_Bits := (
                 MCU.COM1A1_Bit => True,
                 MCU.COM1B1_Bit => True,
                 MCU.WGM11_Bit  => True,
                 others => False);
   MCU.TCCR1B_Bits := (
                 MCU.WGM12_Bit => True,
                 MCU.WGM13_Bit => True,
                 MCU.CS10_Bit => True,
                 others => False);
   MCU.ICR1 := 20_000; --  20ms top value

   MCU.OCR1B := 3400;
   MCU.OCR1A := 2600;
   delay(1.0);

   loop
      LED1 := High;
      delay(0.1);
      LED1 := Low;
      LED2 := High;
      delay(0.1);
      LED2 := Low;
      delay(0.8);
   end loop;

end Drive;

