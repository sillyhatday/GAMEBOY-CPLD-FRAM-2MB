## Programming Atmel parts (DRAFT)

I'm going to do my best to document this. These Atmel parts are more involved to get working. There is also a save bug with larger save files that needs solving. I figured out how to do this once before and forgot, so spent hours figuring it out again. Nothing I do is ever easy or simple.

Firstly, for programming Atmel parts, Quartus Programmer is of no use. The program used in its place is `OpenOCD`. It's a command line/terminal program that is far from user friendly. It is a powerful tool, that means there are a lot of options to configure. I've bundled these options into a config file to help simplify things.

As with Altera parts, there needs to be some hardware to do the programming. I use a generic FT232H clone from Aliexpress. It was about £3. Right now this is the state of the programmer:

<img width="800" height="451" alt="atmelflasher" src="https://github.com/user-attachments/assets/94e23af1-7819-4b64-9935-ec1b92f0634e" />

I plan to do something to make this more user friendly. Firstly, make it so the chips can be flashed in circuit. The issue in making it more user friendly is that there are so many different FT232 clones that I can't make every one of them plug into the JTAG adaptor. I can make a separate board that the ribbon cable can plug into along with the FT232. That is more of the same problem with so many different FT232 clones. Plus, it's another PCB to make to add more expense and complication. I need to think.

>[!WARNING]
>I suggest doing this in Windows and not Linux. On Linux I've had problems talking to the FT232 due to the driver being held by something else. I think it's `brltty` but I gave up solving it.

Download OpenOCD. Move the program to a simple folder path like `C:\openocd` to make things easier when using the command line. Open this folder and go to the `bin` folder inside. This is where some files need to be placed. In here copy `prog.cfg` and the SVF file for the CPLD you are using.

That should be the software setup ready. Check if OpenOCD can talk to the FT232 device. If not, a new driver needs to be installed.

Plug in your FT232 device and connect the CPLD to it (HOWEVER I DECIDE TO HAVE THEM CONNECT) Run the following in the command line:

```
openocd -f interface/ftdi/um232h.cfg -c "transport select jtag" -c "adapter speed 5" -c "init" -c "scan_chain"
```

This is the expected output:

```
xPack Open On-Chip Debugger 0.12.0+dev-02228-ge5888bda3-dirty (2025-10-04-22:44)
Licensed under GNU GPL v2
For bug reports, read
        http://openocd.org/doc/doxygen/bugs.html
adapter speed: 5 kHz
Info : clock speed 5 kHz
Warn : There are no enabled taps.  AUTO PROBING MIGHT NOT WORK!!
Info : JTAG tap: auto0.tap tap/device found: 0x0151203f (mfg: 0x01f (Atmel), part: 0x1512, ver: 0x0)
Warn : AUTO auto0.tap - use "jtag newtap auto0 tap -irlen 3 -expected-id 0x0151203f"
Warn : gdb services need one or more targets defined
   TapName             Enabled  IdCode     Expected   IrLen IrCap IrMask
-- ------------------- -------- ---------- ---------- ----- ----- ------
 0 auto0.tap              Y     0x0151203f 0x00000000     3 0x01  0x03
Info : Listening on port 6666 for tcl connections
Info : Listening on port 4444 for telnet connections
```

You can see the ID code of the part has been found, `0x0151203F`. If there are no devices found, then install the new driver.

>[!NOTE]
>Download Zadig from https://zadig.akeo.ie/, tell it to show all devices. Select your FT232 device, then select libusbk as the driver. Install it and wait, it can take some time. You may want to reboot the system but I should work without. Run the scan again.

If the scan has worked, then everything is ready to program. Run the following:

```
openocd -f interface/ftdi/um232h.cfg -f prog.cfg
```

If it is working then you will see the command line scrolling after each SVF instruction. It's set to program slowly as the FT232 clones are not great and they can vary on how well they handle higher speeds.

That should be it, the Atmel part is programmed. Load the cart into GBXcart and program it with whatever you desire to play.

>[!TIP]
>If you get an ID mismatch error, I think it is because OpenOCD is not up to date with the newest revisions of CPLDs. The SVF files provided are manually edited to correct the expected ID. There is a chance that the CPLD you have is from an older or even a newer revision. In which  case, open the SVF file and edit the ID string to match the one you have being read from the chip. As an example, OpenOCD expects `0x0150203F` as the ID for the `ATF1502AS`, where the ones I have tried return `0x0151203F`. These were bought new from LCSC and should be legitimate parts.
