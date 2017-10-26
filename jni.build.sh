#!/bin/bash

# Compile java code
javac Asd.java

# Generate C/C++ headers
javah -cp $(pwd) Asd

# -fpic := PIC(Position Independent Code)
gcc -c -I~/opt/java/jdk1.8.0_111/include -I~/opt/java/jdk1.8.0_111/include/linux  -Wall -Werror -fpic foo.c;
# Make shared library
gcc -I~/opt/java/jdk1.8.0_111/include/ -I~/opt/java/jdk1.8.0_111/include/linux -shared -o libfoo.so foo.o;
# Compile main, link foo [-lfoo], -Wl,-rpath := path to find shared library
gcc -I~/opt/java/jdk1.8.0_111/include/ -I~/opt/java/jdk1.8.0_111/include/linux -L$(pwd) -Wl,-rpath=$(pwd) -Wall -o test main.c -lfoo

# Run
java -cp $(pwd) Asd
