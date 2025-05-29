# Programming Guide

For the USB Blaster I would suggest avoiding the small ones shown below. I found them to be flakey. Talk to some CPLD and not others, even ones it could talk to it couldn't program. The same chips worked on other programmers.

![USB-Blaster-ALTERA-CPLDFPGA-Programmer-1-52150820](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/c1cf440a-68b1-4ccf-bb4e-ad689d0300b6)

I suggest this one, it has been much more solid.

![AliJTAG](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/7360df56-3824-4cea-9fbe-50ed7c374452)

This is a rough guide and you are expected to know some things already, such as how to use a Windows PC, solder SMD parts, etc.

First off, order the cart PCB from your manufacturer of choice. I use JLC for small quantity orders like this as they work out cheapest. Make sure to choose ENIG finish and 0.8mm thickness. You do not need to order the JTAG adaptor if you wish to manually solder to the test points on each cart. The adaptor does not need to be ENIG finsih.

Order your parts list for however many carts you ordered. Get them all from Aliexpress, unless you want to order legit FRAM from Digikey. The flash chip and CPLD are obsolete long ago and only available second hand.

Get your USB Blaster drivers installed. I used a github repo for the drivers. Install them through device manager. The links below have the details and drivers.

Driver Installation: https://www.terasic.com.tw/wiki/Intel_USB_Blaster_Driver_Installation_Instructions

Driver Download: https://github.com/sudhamshu091/USB-Blaster-Driver-for-DE10-lite

Assemble the cart. Make sure you have good solder joints and that any flux is thoroughly cleaned from IC pins. The JTAG interface seems sensitive and excess flux has caused me issues trying to program.

Make sure to download the programmer software from here or source it yourself if you wish. The install is simple, just click through and wait. I have also uploaded it here:

https://archive.org/details/quartus-iiprogrammer-and-signal-tap-ii-13.1.0.162.7z

Insert your assembled cart into the JTAG adaptor using the 3D printed shim so that the cart can be inserted upside down. (The side with the 6 cart edge pins). If you don’t have  access to a shim, you can sacrifice an old Gameboy cart by cutting it up so that your cart can fit in it upside down.

Launch the Quartus II Programmer software you just installed.

![2 MainProgUSBBlasterSelected](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/70f33a9c-51d2-422a-b8f0-de7029f098a5)

Make sure that the USB Blaster is detected and selected in Quartus. If not click “Hardware Setup…” and find it.

![1USB Blaster selection](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/b13a9b11-7825-42f8-b04a-1348c170efce)

Once selected select the POF file for the CPLD you are using, 3064A or 3032A.

![3 FileSelected](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/509d84be-c925-4928-9327-ad6c75a6f1af)

If the CPLD is unproven to work yet, it may also be programmed from its previous life. Click “Erase” and press start. If your JTAG is connected properly and working, it should erase quickly. If problems continue, recheck JTAG connections, solder joints and flux residue. By this point, if things still do not work, then the CPLD is already programmed with JTAG disabled (requiring an external programmer) or it is damaged internally.

![4 EraseCPLD](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/0c7be1bc-0fed-4b33-837c-dfc981d2b265)

Once erased, it is worth doing a “Blank-Check” to be sure that the erase worked correctly. If this fails, then it is not blank.

![5 BlankCheckCPLD](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/dcc28a9e-5c8f-4fdf-b71e-3b5c782faf33)

Finally time to program the CPLD. Check “Program/Configure” and “Verify”, then click start for the last time. It should take about 2 seconds. If you have any trouble, check your JTAG connections, reflow the CPLD, make sure the adaptor board is powered, clean off flux residue.

![6 ProgVerifyCPLD](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/22686784-cfa1-4366-9776-a0bd3121f770)

Now move over to your GBxCart software and test it out. Unplug the JTAG hardware and plug your cart into your GBxCart.
