# GAMEBOY-MBC5-CPLD-2MB

>[!WARNING]
>Current circuit board revision does not include support for the MAX7000 or ATF150x CPLD without bodges.

## Introduction:

This is my take of a CPLD based flash cart for the Gameboy.

The whole project is based from Alex's project from years back. Without that project, I would never have picked this up and spend my time figuring out how to work with CPLDs. I am not a programmer and do not claim to be. Picking up Alex's code I can see how things work with my previous knowledge of how carts operate.

The newest update has been done with the help of AI. I just wanted to get this thing done so it is off my active project list. Even though AI has helped, I have learned a little bit more about how CPLDs work because of it. In the future I'd like to use the knowledge to do another project.

Some reasons to build this project are:

	+ No need for sourcing a donor cartridge
	+ Multi MBC compatibility
	+ Cheaper to build vs a donor cart (initially not, more made, more saved)

>[!IMPORTANT]
> This project is designed with MBC5 functionality as the main priority. Compatibility with MBC1 is added on top, therefore, compatibility is not guaranteed. Super Mario Land 2 & Zelda: Link's Awakening work here, where they have issues running on a normal MBC5 chip. However, Donkey Kong Land does not work. Maybe one day I can create an MBC1 CPLD mapper.

>[!NOTE]
>For updates, see towards the end of the readme

## 🟦 Project State:

### :green_circle: Done

	- Get a cartridge that works well enough
	- Make the Altera 3032A & 3064A both work
	- Fix SRAM problems with MAX7000 and edge case MAX3000
	- Fix this readme after half updating and rage quitting. Remove V2.0 PCB pics.
	- Write draft of instructions for programming Atmel chips

### :yellow_circle: In Progress

	- Do some power tests of carts I have built so far.

### :white_circle: To Do

	- Test flashing Atmel chips in circuit
	- Design some hardware to flash Atmel chips in circuit
	- Update PCB to include solder jumper for different CPLD families.
	- Some issues with SRAM in FlashGBX with Atmel 1502A. Check hardware over & adjust WinCUPL settings.

## 🟨 Prerequisites

	* The full components parts list and cart PCB
	* (Optional) JTAG adaptor PCB
	* Altera USB Blaster or FT232 for JTAG (cheap clones work)
	* Windows PC with Quartus II Programmer, Quartus II Web Edition or OpenOCD
	* GBxCart and related software
 	* Modified Gameboy cart shell or (optional) 3D printed Game Gear cart adaptor
	* Equipment to solder tiny SMD components
	* Skills to solder tiny SMD components reliably

## 🔌 CPLD Programming

>[!TIP]
>Guides on setting up and programming your chosen CPLD

[Altera Guide](AlteraProgrammingGuide.md) <br>
[Atmel Guide](AtmelProgrammingGuide.md) <br>

## 🟦 Parts List

### Cartridge x1

>[!IMPORTANT]
>When ordering cartridge PCBs, make sure to choose 0.8mm thickness and gold plating. <br>
>Altera MAX3000 & MAX7000 CPLDs are obselete and only found on Aliexpress. I suggest the 3032A. (MAX7000 is a relic at this point). <br>
>If ordering MAX7000, get the S version, otherwise throw your money in a fire. Eg, EPM7032S <br>
>Atmel ATF150x parts can be bought new from reputable sellers. However they are trickier to program for the average person. <br>
>Order FRAM from Aliexpress & eBay at your own risk, they are known to be ***extremely*** unreliable. <br>

| Part No. | Package | Qty |
| -------- | ------- | --- |
| 29F016 | TSOP48 | 1 |
| FM1808 | SOIC28 | 1 |
| EPM3064A/32A | TQFP44 | 1 |
| 74LVC1G332 | TSOP6 | 1 |
| AP2127K-3.3TRG1 | SOT23-5 | 1 |
| Cap 100nF | 0603 | 4 |
| Cap 1uF | 0603 | 2 |
| Res 10K | 0603 | 1 |

### JTAG Adaptor

| Part No. | Qty |
| -------- | --- |
| DS Lite Cart Conn | 1 |
| USB C USB4125 | 1 |
| Pin Headers | 2x5-P2.54mm |
| GG Adaptor or Shell | 1 |
| USB Blaster | 1 |

>[!TIP]
>Link to GG Adaptor: https://www.thingiverse.com/thing:5830799

## Build Photos

<img width="760" height="532" alt="cpldfram3" src="https://github.com/user-attachments/assets/41530c03-686e-400e-816a-e2e53a2379e0" />

<img width="518" height="533" alt="cpldfram1" src="https://github.com/user-attachments/assets/66d644ff-2614-4e8a-81d5-7735039bf080" />

<img width="518" height="533" alt="cpldfram2" src="https://github.com/user-attachments/assets/77461c35-323b-4296-aec4-04a6360b78a8" />

**Different CPLD** <br>
<img width="750" height="725" alt="CPLDcartclose" src="https://github.com/user-attachments/assets/519aafab-0ec3-47fe-abc3-09b49094288e" />

**Original Prototype** <br>
<img width="734" height="637" alt="Prototype3064A" src="https://github.com/user-attachments/assets/b9e41937-1537-47e6-a22d-27dc9e45a5e8" />

## Update June 2026

I've picked this back up again when I found a PCB laying about. I had to wonder if AI was good enough now to help improve things. It is fortunately.

The previous update I was naive to think programming in C++ was anything like Verilog. I mean it is, but the device being programmed works so differently to other CPU based systems.

The issue that has been plaguing the 7032S & 1504A, is the save RAM functionality. Games would not save, or correctly use the cartridge as work RAM. This was on the Gameboy and cart readers. I tested this over a few carts and the first one kinda worked. It was flaky but saving, yet only on the GB and not the cart reader. There worst problem is that this problem crept into some of the 3032A and 3064A carts also.

This code refactor seems to have fixed all these problems, not only the MAX3000 but the MAX7000 also. As of now, the ATF1504 is untested. I am hopeful that it will work also. Programming those is more complex and I've since forgotten how to do it.

The smaller EPM3032A, EPM7032S & ATF1502 with 32 macro cells are now more than big enough to fit the program, no longer is it so tight. This is thanks to removing the 128KB RAM functionality, reducing the amount of registers required to address that has gained a lot of space. Additional code can be added for more functionality such as moving the FRAM gate logic into the CPLD and making it user programmable with a solder bridge on the PCB.

This is all very nice as the smaller chips tend to use less power than the larger counterparts, even though they use the same quantity of macro cells. I'll add more detailed information on the changes in its own readme.

When the Atmel part is confirmed working, I'll update the rest of the readme to walk though programming those. Ideally the PCB could use a revision to add the FRAM mode jumper and a jumper to bypass the 3.3v regulator when using the MAX7000 and ATF15xx chips. Again, I'll get to that when testing is complete.

## Firmware Versions

| Version | Status | Notes |
| ------- | ------ | ----- |
| V1.0.0  | Initial | Original code from Alex's blog |
| V1.0.1  | Fix | Removed internal FRAM chip select logic to lower cartridge power consumption 1 to 3% |
| V2.0.0  | Fix | Changed project compiler settings to lower cartridge power consumption 36 to 41% |
| V3.0.0  | Current | AI helper to teach me and structure code better. Use of macro cells more efficient. Logic split into smaller sections. More reliable, cleaner code, better output waveforms (I need to confirm that). |

## 🩷 Links

🔧 Driver Install: https://www.terasic.com.tw/wiki/Intel_USB_Blaster_Driver_Installation_Instructions <br>
⬇️ Driver Download: https://github.com/sudhamshu091/USB-Blaster-Driver-for-DE10-lite <br>
🖨️ Game gear Adaptor: https://www.thingiverse.com/thing:5830799 <br>
⏬ Alt Link Quartus: https://archive.org/details/quartus-iiprogrammer-and-signal-tap-ii-13.1.0.162.7z <br>
🛍️ Inside Gadgets Shop: https://shop.insidegadgets.com <br>
📎 Inside Gadgets GitHub: https://github.com/insidegadgets <br>
📷 Inside Gadgets Insta: https://www.instagram.com/inside.gadgets <br>
🖇️ Bytendo Mods GitHub: https://github.com/bytendomods <br>
🐭 Bucket Mouse: https://github.com/Bucket-Mouse <br>
🛒 Natalie Shop: https://nataliethenerd.com/ <br>
🤓 Natalie GitHub: https://github.com/natalie-lang/natalie <br>

Thanks to Xukkorz, Drew, Jamo, Alex, Deceptive Thinker, Natalie the Nerd & anyone else who I may have forgotten.

## License

This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License. You are able to copy and redistribute the material in any medium or format, as well as remix, transform, or build upon the material for any purpose (even commercial) - but you must give appropriate credit, provide a link to the license, and indicate if any changes were made.
