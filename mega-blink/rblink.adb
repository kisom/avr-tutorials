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
-- then begins blinking the LED. This version is an attempt to start
-- making sense of the Ravenscar profile.

pragma Profile (Ravenscar);

with AVR;
use  AVR;

with AVR.MCU;             -- port and pin definitions.
with AVR.Real_Time.Clock; -- required for delay to work.
pragma Unreferenced (AVR.Real_Time.Clock);
with AVR.Serial;

procedure RBlink is

   type LED_State is (On, Off);
   type LED is record
      Pin : MCU.Bits_In_Byte;
      State : LED_State;
   end LED;

   LED_pin : Boolean renames MCU.PORTB_Bits (7);

begin
   MCU.DDRB_Bits :=  (others => DD_Output);
   Serial.Init(Serial.Baud_9600_16MHz);

   Serial.Put ("Boot OK");
   Serial.CRLF;

   loop
      LED_pin :=  High;
      --  not allowed by Ravenscar: no relative delays
      --  delay (0.1);

      Serial.Put ("Beacon");
      Serial.CRLF;

      LED_pin := Low;
      --  not allowed by Ravenscar: no relative delays
      --  delay (0.9);
   end loop;

end Blink;

