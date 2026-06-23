# Programming Guide

>[!TIP]
>For the USB Blaster I prefer the larger version shown below over the smaller version. I'm not sure if it is less reliable or if it's just me being stupid. Either way, up to you.

**Smol** <br>
![USB-Blaster-ALTERA-CPLDFPGA-Programmer-1-52150820](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/c1cf440a-68b1-4ccf-bb4e-ad689d0300b6)

**Big** <br>
![AliJTAG](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/7360df56-3824-4cea-9fbe-50ed7c374452)

>[!IMPORTANT]
>This is a rough guide and you are expected to know how to use a Windows PC, solder SMD parts, hold a pencil, etc.

Get your USB Blaster drivers installed. I used a github repo for the drivers. Install them through device manager. The links below have the details and drivers.

>[!NOTE]
>Driver Installation: https://www.terasic.com.tw/wiki/Intel_USB_Blaster_Driver_Installation_Instructions <br>
>Driver Download: https://github.com/sudhamshu091/USB-Blaster-Driver-for-DE10-lite

>[!TIP]
>Make sure you have good solder joints and that any flux is thoroughly cleaned from IC pins. The JTAG interface seems sensitive and excess flux has caused me issues trying to program.

Make sure to download the programmer software from here or source it yourself if you wish. The install is simple, just click through and wait. I have also uploaded it here:

https://archive.org/details/quartus-iiprogrammer-and-signal-tap-ii-13.1.0.162.7z

Insert your assembled cart into the JTAG adaptor using the 3D printed shim so that the cart can be inserted upside down. (The back side with the 6 cart edge pins).

>[!TIP]
>If you don’t have access to a 3D printer, you can make one by cutting around 15mm off the bottom of a cartridge shell back piece.

Launch the Quartus II Programmer software you just installed.

<img width="800" height="425" alt="quartus main page" src="https://github.com/user-attachments/assets/6f8d38b6-c2e8-4eff-95ae-e2b0d749143c" />

Make sure that the USB Blaster is detected and selected in Quartus. If not click “Hardware Setup…” and find it.

<img width="431" height="349" alt="quartus blaster select" src="https://github.com/user-attachments/assets/53464c17-f83c-415b-a870-80b15d8d1181" />

Once selected select the POF file for the CPLD you are using, 3064A, 3032A, 7032S or 7064S.

<img width="741" height="538" alt="quartus blaster selected" src="https://github.com/user-attachments/assets/618e5194-9fab-4e0c-a0ec-215f631cf2cd" />

If the CPLD is not yet proven, it is possible that it is already programmed from its previous life. Click “Erase” and press start. If your JTAG is connected properly and working, it should erase quickly. If problems continue, recheck JTAG connections, solder joints and flux residue. If things still do not work, then the CPLD is already programmed with JTAG disabled (requiring a professional programmer) or it is damaged.

Erasing is not required as this is done automaticall when programming. I like to do an erase on new CPLDs to prove the JTAG chain is working and the programming file isn't causing problems (wrong file, corrupted).

<img width="493" height="133" alt="quartus erase" src="https://github.com/user-attachments/assets/1080eeca-6c97-476c-867b-e9a0b839f693" />

Once erased, it is worth doing a “Blank-Check” to be sure that the erase worked correctly.

<img width="445" height="98" alt="quartus blank check" src="https://github.com/user-attachments/assets/4b3f7c62-906b-42f5-b992-2b4b7a8f6f65" />

Finally time to program the CPLD. Check “Program/Configure” and “Verify”, then click start for the last time. It should take about 2 seconds.

>[!TIP]
>If you have any trouble, check your JTAG connections, reflow the CPLD, make sure the adaptor board is powered, clean off flux residue, check the correct POF file is selected, check the POF file is not corrupt.

<img width="454" height="114" alt="quartus prog" src="https://github.com/user-attachments/assets/8556105b-b63e-4843-806a-e837706ebddb" />

The mapper is now programmed. You can put this stuff away for good unless you want to keep up with firmware update or program more cartridges.

Now move over to your GBxCart software and test it out.

>[!NOTE]
>Any problems in GBxCart are more likely an issue with flash chip soldering, or hidden solder between CPLD pins, than issues with the CPLD program. Any issues with programming game saves is the problem of cheap dead FRAM.
