#Author: Mohamed Newir
#Date: 1/3/2025
#File Name: CMakelists.txt
#Description:
#       This file is used to build the xor_cipher library

# CMake version of the project
cmake_minimum_required(VERSION 3.10)
# Name of the project xor_cipher and the language is C
project(xor_cipher LANGUAGES C)

# Create the output directories
file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/../Application/out)   
file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/../Application/out/lib)   
file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/../Application/out/gens)

# Set the output directory to Application/out/lib
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/../Application/out/lib)
# Include the header files of the library
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/inc)
# Add the source files of the library
add_library(xor_cipher SHARED
    ${CMAKE_CURRENT_SOURCE_DIR}/src/xor_encrypt.c
    ${CMAKE_CURRENT_SOURCE_DIR}/src/xor_decrypt.c
)

# Set the output name of the library --> libxor_cipher.so
set_target_properties(xor_cipher PROPERTIES
    OUTPUT_NAME "xor_cipher"
    PREFIX "lib"
    SUFFIX ".so"
    ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/../Application/out/gens
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/../Application/out/lib
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/../Application/out/gens
)

add_custom_command(TARGET xor_cipher PRE_LINK
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
    ${CMAKE_BINARY_DIR}/xor_cipher_build/CMakeFiles/xor_cipher.dir/src/xor_encrypt.c.o
    ${CMAKE_SOURCE_DIR}/../Application/out/gens/xor_encrypt.o
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
    ${CMAKE_BINARY_DIR}/xor_cipher_build/CMakeFiles/xor_cipher.dir/src/xor_decrypt.c.o
    ${CMAKE_SOURCE_DIR}/../Application/out/gens/xor_decrypt.o
)