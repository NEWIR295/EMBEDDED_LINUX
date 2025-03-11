#Author: Mohamed Newir
#Date: 1/3/2025
#File Name: Makfile
#Description:
#			This makefile is used to build the application.
#			The dynamic library for the xor_cipher module is built in the ./out/lib directory.
#			The static library for the caesar_cipher module is built in the ./out/lib directory.
#			The object files are built in the ./out/gens directory.
#			The application is named output.
#			The clean target is used to remove the object files and the application.
#			make --> used to build the application.
#			make clean --> used to remove the object files and the application.

# current directory paths
LIB_DIR_ = ./out/lib
OBJ_DIR_ = ./out/gens
OUT_DIR_ = out
APP_DIR_ = .

# exported directory paths
XOR_CIPHER_INCLUDES_DIR_ = $(shell pwd)/../Modules/xor_cipher/inc
CAESAR_CIPHER_INCLUDES_DIR_ = $(shell pwd)/../Modules/caesar_cipher/inc
CFLAGS_ = -I$(XOR_CIPHER_INCLUDES_DIR_) -I$(CAESAR_CIPHER_INCLUDES_DIR_) -Wall -Werror

# used compiler
CC = gcc

# used libraries
DYNAMIC_LIB_ = $(LIB_DIR_)/libxor_cipher.so 
STATIC_LIB_ = $(LIB_DIR_)/libcaesar_cipher.a

# application obj file
OBJ_ = app.o

# Include sub Makefile
include $(shell pwd)/../Modules/xor_cipher/xor_cipher.mk
include $(shell pwd)/../Modules/caesar_cipher/caesar_cipher.mk


all:  xor_all caesar_all  $(OBJ_DIR_)/$(OBJ_)
	@if [ ! -d $(OUT_DIR_) ]; then mkdir -p $(OUT_DIR_); fi
	@if [ ! -d $(LIB_DIR_) ]; then mkdir -p $(LIB_DIR_); fi
	@if [ ! -d $(OBJ_DIR_) ]; then mkdir -p $(OBJ_DIR_); fi
	$(CC)  $(OBJ_DIR_)/app.o -L$(LIB_DIR_) -lcaesar_cipher -lxor_cipher -o $(APP_DIR_)/output
	@echo "							Run the following before executing the application:"
	@echo 'export LD_LIBRARY_PATH=$(LIB_DIR_)'
	@echo "Then execute for example: ./output 3 K “aaa”"

$(OBJ_DIR_)/app.o: $(APP_DIR_)/app.c
	@if [ ! -d $(OBJ_DIR_) ]; then mkdir -p $(OBJ_DIR_); fi
	$(CC) -c $(APP_DIR_)/app.c -o $(OBJ_DIR_)/app.o $(CFLAGS_)


clean:
	rm -f $(OBJ_DIR_)/*.o  output
	rm -f $(LIB_DIR_)/libxor_cipher.so $(LIB_DIR_)/libcaesar_cipher.a
	rm -r $(OUT_DIR_)

clean_xor_cipher: clean_xor

clean_caesar_cipher: clean_caesar