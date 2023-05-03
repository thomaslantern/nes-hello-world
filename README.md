# nes-hello-world
Basic "first" program for the NES (Nintendo Entertainment System) using VASM compiler

<h1>UNDER CONSTRUCTION!</h1>
<h1>"Hello, World!"</h1>

Ever wanted to code for the NES, but don't know how? Had the urge to do some 8-bit programming, but you've 16-bits of fear? (That's trying to be a joke.) Want to write the next Super Mario Bros.? Your journey begins here!

<h1> How to Compile "helloworld.asm" </h1>
If you're looking to compile the code, you'll need to use the VASM compiler. You can get it here: http://www.compilers.de/vasm.html . It's a great compiler that can be used for a variety of systems, and it was made by Dr. Volker Barthelmann. Check it out! To compile simply use: <code>vasm6502_oldstyle.exe DIR/helloworld.asm -chklabels -nocase -Fbin -o "DIR2/helloworld.nes"</code> where DIR and DIR2 are the paths/directories for the source file and target file, respectively. (If you have the win32 version of vasm, you may need to use vasm_oldstyle_win32.exe instead).

<h1>How to Run "helloworld.asm"</h1>
Assuming you've successfully followed the steps to compile above, you should now have an .nes file, "helloworld.nes". This file can be run in any NES (Nintendo Entertainment System) emulator. I tend to use Nestopia, but other NES developers really seem to enjoy FCEUX, so use whichever emulator you like to run it!

<h1>How to Use (and Learn From) "helloworld.asm"</h1>
There is a lot to take in here, for what should be a simple program! "Hello, World!" in Python is 1 line of code. In C++, it's 4 or 5. In ASM 6502 (NES Aassembly Code)? Well... it's about 90 or so.




<h1>insert thing about compiler comparisons</h1>
