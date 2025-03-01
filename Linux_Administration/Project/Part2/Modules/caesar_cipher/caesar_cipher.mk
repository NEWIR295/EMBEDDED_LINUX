#Author: Mohamed Newir
#Date: 1/3/2025
#File Name: caesar_cipher.mk
#Description: 
#			This makefile is used to build the static library for the caesar_cipher module.
#			The static library is built in the ../../Application/out/lib directory.
#			The object files are built in the ../../Application/out/gens directory.
#			The source files are in the ./src directory.
#			The include files are in the ./inc directory.
#			The static library is named libcaesar_cipher.a.
#			The clean target is used to remove the object files and the static library.
#			The static library is built using the rcs flags not cr flags because the order of the object files is important.
#			make -f caesar_cipher.mk --> used to build the static library.
#			make -f caesar_cipher.mk clean --> used to remove the object files and the static library.		

CAESAR_CIPHER_INCLUDES_DIR = /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Modules/caesar_cipher/inc
CAESAR_CIPHER_SOURCE_DIR = /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Modules/caesar_cipher/src

LIB_DIR = /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/out/lib
OBJ_DIR = /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/out/gens
OUT_DIR = /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/out

CC = gcc
AR = ar 
CFLAGS = -I$(CAESAR_CIPHER_INCLUDES_DIR) -Wall -Werror
STATIC_LIB_FLAGS = rcs 

COBJ = $(OBJ_DIR)/caesar_decrypt.o $(OBJ_DIR)/caesar_encrypt.o

STATIC_LIB = libcaesar_cipher.a 

caesar_all: $(LIB_DIR)/libcaesar_cipher.a


$(LIB_DIR)/libcaesar_cipher.a: $(COBJ)
	@if [ ! -d $(LIB_DIR) ]; then mkdir -p $(LIB_DIR); fi
	@if [ ! -d $(OBJ_DIR) ]; then mkdir -p $(OBJ_DIR); fi
	$(AR) $(STATIC_LIB_FLAGS) $(LIB_DIR)/libcaesar_cipher.a $(COBJ)


$(OBJ_DIR)/caesar_decrypt.o: $(CAESAR_CIPHER_SOURCE_DIR)/caesar_decrypt.c
	@if [ ! -d $(OBJ_DIR) ]; then mkdir -p $(OBJ_DIR); fi
	$(CC) $(CFLAGS) -c $(CAESAR_CIPHER_SOURCE_DIR)/caesar_decrypt.c -o $(OBJ_DIR)/caesar_decrypt.o

$(OBJ_DIR)/caesar_encrypt.o: $(CAESAR_CIPHER_SOURCE_DIR)/caesar_encrypt.c
	@if [ ! -d $(OBJ_DIR) ]; then mkdir -p $(OBJ_DIR); fi
	$(CC) $(CFLAGS) -c $(CAESAR_CIPHER_SOURCE_DIR)/caesar_encrypt.c -o $(OBJ_DIR)/caesar_encrypt.o


clean_caesar:
	rm -f $(OBJ_DIR)/caesar_encrypt.o $(OBJ_DIR)/caesar_decrypt.o
	rm -f $(LIB_DIR)/libcaesar_cipher.a
#	rm -r $(OUT_DIR)
