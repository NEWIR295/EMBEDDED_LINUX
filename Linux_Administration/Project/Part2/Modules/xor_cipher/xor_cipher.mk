#Author: Mohamed Newir
#Date: 1/3/2025
#File Name: xor_cipher.mk
#Description: 
#			This makefile is used to build the dynamic library for the xor_cipher module.
#			The dynamic library is built in the ../../Application/out/lib directory.
#			The object files are built in the ../../Application/out/gens directory.
#			The source files are in the ./src directory.
#			The include files are in the ./inc directory.
#			The dynamic library is named libxor_cipher.so.
#			The clean target is used to remove the object files and the dynamic library.
#			The dynamic library is built using the -shared flag.
#			The -fPIC flag is used to generate position-independent code.
#			The -I flag is used to specify the include directory.
#			The -Wall flag is used to enable all warnings and the -Werror flag is used to treat all warnings as errors.
#			The export LD_LIBRARY_PATH=$(LIB_DIR) command is used to set the library path.
#			make -f xor_cipher.mk --> used to build the dynamic library.
#			make -f xor_cipher.mk clean --> used to remove the object files and the dynamic library.	

XOR_CIPHER_INCLUDES_DIR = /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Modules/xor_cipher/inc
XOR_CIPHER_SOURCE_DIR = /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Modules/xor_cipher/src

LIB_DIR = /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/out/lib
OBJ_DIR = /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/out/gens
OUT_DIR = /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/out

CC = gcc
CFLAGS = -I$(XOR_CIPHER_INCLUDES_DIR) -fPIC -Wall -Werror
DYNAMIC_LIB_FLAGS = -shared

XOBJ = $(OBJ_DIR)/xor_decrypt.o $(OBJ_DIR)/xor_encrypt.o

DYNAMIC_LIB = $(LIB_DIR)/libxor_cipher.so

xor_all: $(LIB_DIR)/libxor_cipher.so

$(LIB_DIR)/libxor_cipher.so: $(XOBJ)
	@if [ ! -d $(LIB_DIR) ]; then mkdir -p $(LIB_DIR); fi
	@if [ ! -d $(OBJ_DIR) ]; then mkdir -p $(OBJ_DIR); fi
	$(CC) $(DYNAMIC_LIB_FLAGS) -o $(LIB_DIR)/libxor_cipher.so $(XOBJ)
#	export LD_LIBRARY_PATH=$(LIB_DIR) 
#	echo "export LD_LIBRARY_PATH=$(LIB_DIR)" >> ~/.bashrc

$(OBJ_DIR)/xor_decrypt.o: $(XOR_CIPHER_SOURCE_DIR)/xor_decrypt.c
	@if [ ! -d $(OBJ_DIR) ]; then mkdir -p $(OBJ_DIR); fi
	$(CC) $(CFLAGS) -c $(XOR_CIPHER_SOURCE_DIR)/xor_decrypt.c -o $(OBJ_DIR)/xor_decrypt.o

$(OBJ_DIR)/xor_encrypt.o: $(XOR_CIPHER_SOURCE_DIR)/xor_encrypt.c
	@if [ ! -d $(OBJ_DIR) ]; then mkdir -p $(OBJ_DIR); fi
	$(CC) $(CFLAGS) -c $(XOR_CIPHER_SOURCE_DIR)/xor_encrypt.c -o $(OBJ_DIR)/xor_encrypt.o


clean_xor:
	rm -f $(OBJ_DIR)/xor_encrypt.o  $(OBJ_DIR)/xor_decrypt.o
	rm -f $(LIB_DIR)/libxor_cipher.so
#	rm -r $(OUT_DIR)
