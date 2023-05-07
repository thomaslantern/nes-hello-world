# nes-hello-world

<h1>UNDER CONSTRUCTION!</h1>
<h1>"Hello, World!"</h1>

Have you ever wanted to code for the NES, but you don't know how? Have you wanted 8-bit programming knowledge, but instead you're stuck with 16 bits of fear? (That's trying to be a joke.) Want to write the next Super Mario Bros.? Your journey begins here! This is my version of "Hello, World" for the NES, and I offer the code to you as an opportunity to begin learning to program for the NES/ASM 6502.

<h2>ASM 6502? What's that?</h2>
ASM 6502 is the aseembly language used to program on the NES. If you've never programmed in an assembly language before, it can be a bit difficult at first, but with a bit of time and patience you can learn it, just like any other language.

I've commented most of the code for this program, so this should help you as far as understanding what's going on with each line of the program, but you will probably need to reference the commands for ASM 6502.

<h1> How to Compile "helloworld.asm" </h1>
If you're looking to compile the code, you'll need to use the VASM compiler. You can get it here: http://www.compilers.de/vasm.html . It's a great compiler that can be used for a variety of systems, and it was made by Dr. Volker Barthelmann. Check it out! To compile simply use: <code>vasm6502_oldstyle.exe DIR/helloworld.asm -chklabels -nocase -Fbin -o "DIR2/helloworld.nes"</code> where DIR and DIR2 are the paths/directories for the source file and target file, respectively. (If you have the win32 version of vasm, you may need to use vasm_oldstyle_win32.exe instead).

<h1>How to Run "helloworld.nes"</h1>
Assuming you've successfully followed the steps to compile above, you should now have an .nes file, "helloworld.nes". This file can be run in any NES (Nintendo Entertainment System) emulator. I tend to use Nestopia, but other NES developers really seem to enjoy FCEUX, so use whichever emulator you like to run it!

<h1>How to Use (and Learn From) "helloworld.asm"</h1>
There is a lot to take in here, for what should be a simple program! "Hello, World!" in Python is 1 line of code. In C++, it's 4 or 5 lines. In ASM 6502 (NES Aassembly Code)? Well... including spaces and comments we're clocking in at around 250 lines of code. Yikes! But fear not! While there is much to learn, we will take it step by step, and you'll see it's not so bad. I've taken great pains to comment just about every line of code in this sample program, so you should at least have an easier time figuring it out.




<h1>insert thing about compiler comparisons</h1>

<h1>License</h1>
Feel free to copy this code, modify it, and use it for either personal or commercial purposes. If you manage to sell a cartridge copy of "Hello, World!", let me know! I'd love to see it ;)
