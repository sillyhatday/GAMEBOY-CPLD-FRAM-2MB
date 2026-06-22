Here is some reasons that the new code works, even though it functions exactly as before. Remember that Alex wrote the code originally and this was his first time programming a CPLD.

One thing that was always flagged up in compilation was the always declaration at the top of the huge code block. It listed some and then mentioned others after that weren't declared. This was definitely causing some weird behaviours. Now each always declaration is cheated by using auto detect "always(*)".

The main bug with the original software was that everything was performed in one main block. I guess one function is how I look at it. It updates everything on every pass. This makes everything tightly coupled, increasing the amount of macro cells used and making the internal routing more complex.

This large block is split into multiple smaller blocks. The smaller blocks mean that the compiler doesn't try and stuff everything together in one giant route, it routes each block separately with less connections between them. Certain things in the code do not need other things to be updated also. There is no need to refactor everything with each state change. Enabling the RAM just needs to check some variables, there is no need to recalculate those variables again when checking. The chip-enable path becomes a simple combinational equation rather than part of a large state machine. This is at least how I think it works.

The high address logic was once again all stuffed in one block. If you look at the code, you will see that the highAddress was assigned many times in the same block. The order was critical and you could end up with the desired final state overwritten.

This being split into their own blocks allows the compiler to optimise the code independently and not try to optimise it as one. Again, using less macro cells and making a simpler route in the chip. 

The code was always monitoring addresses for 128KB RAM. There was never any want for this amount of RAM in my project, so reducing the register size down to fit just 32KB is just a no brainer. Less registers, less resources. A clean fix.

I learned a bit about wires here. I guess this can be considered like reusing code in something like C++. Instead of writing the same code over and over, you make and call a function instead.

Behind a wire, is some combinational logic, this was written out multiple times in one giant block, so the compiler used different parts of the chip to perform the same task, wasting macro cells. The wires have made only one section of the chip do the logic decoding and each block can reference that logic. No longer, each time some logic is checked, is it recalculated based on that point in time.

I don't really know what I'm talking about here. To sum up what I think is going on, the code is the same, it is just structured better to allow the compiler to use the macro cells more efficient and effectively.

Additions:

In future I'd like to add code to enable FRAM pre-charge logic, by using a spare pin to enable/disable it based on a solder bridge.

wire framMode;                                                                               // New reusable function
assign ramCE_out = framMode ? (ramCE | clk) : ramCE;         // If pin is high, do or logic, else passthrough

I'd like to add support for 4MB ROM chips. This could be also controlled with a solder bridge or be a separate program for 4MB carts. If it ends up too big for the smaller CPLDs, then removing MBC1 detection logic will gain a bit of space back. You shouldn't be running MBC1 games on an expensive 4MB based cart anyway.
