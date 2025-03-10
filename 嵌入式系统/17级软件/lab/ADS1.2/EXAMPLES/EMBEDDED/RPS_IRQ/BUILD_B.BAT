armasm -g vectors.s
armasm -g init.s
armasm -g stack.s
armasm -g heap.s
REM Use the following two lines to build without the serial port. 
armcc -c -g -O1 main.c -I..\include -DEMBEDDED
armcc -c -g -O1 retarget.c
REM Use the following two lines to build using the serial port. 
REM armcc -c -g -O1 main.c -I..\include -DEMBEDDED -DUSE_SERIAL_PORT
REM armcc -c -g -O1 retarget.c -DUSE_SERIAL_PORT
armcc -c -g -O1 uart.c -I..\include
armcc -c -g -O1 serial.c -I..\include
armcc -c -g -O1 int_handler.c -I..\include
armlink vectors.o init.o main.o retarget.o uart.o serial.o stack.o heap.o int_handler.o -scatter scat_b.scf -o rps_irq.axf -entry 0x0 -info totals -info unused
fromelf rps_irq.axf -bin -o rps_irq.bin
fromelf rps_irq.axf -m32 -o rps_irq.m32

