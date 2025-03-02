#Author: Mohamed Newir
#Date: 1/3/2025
#File Name: CMakelists.txt
#Description:
#       This file is used to build the caesar_cipher library

# CMake version of the project 
cmake_minimum_required(VERSION 3.10)
# Name of the project caesar_cipher and the language is C
project(caesar_cipher LANGUAGES C)
# Set the output directory to the Application/out/lib
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/../../Application/out/lib)
# Include the header files of the library
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/inc)
# Add the source files of the library
add_library(caesar_cipher STATIC
    ${CMAKE_CURRENT_SOURCE_DIR}/src/caesar_encrypt.c
    ${CMAKE_CURRENT_SOURCE_DIR}/src/caesar_decrypt.c
)
# Set the output name of the library --> libcaesar_cipher.a
set_target_properties(caesar_cipher PROPERTIES
    OUTPUT_NAME "caesar_cipher"
    PREFIX "lib"
    SUFFIX ".a"
    ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/../../Application/out/lib
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/../../Application/out/gens
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/../../Application/out/gens
)
