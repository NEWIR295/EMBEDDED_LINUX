#Author: Mohamed Newir
#Date: 1/3/2025
#File Name: CMakelists.txt
#Description:
#       This file is used to build the application and it links the application with the libraries

# CMake version of the project 
cmake_minimum_required(VERSION 3.10)
# Name of the project Application and the language is C 
project(Application LANGUAGES C)

# Create the output directories 
file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/out)              
file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/out/gens)         
file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/out/lib)          

# Add the subdirectories of the libraries 
add_subdirectory(${CMAKE_SOURCE_DIR}/../Modules/caesar_cipher ${CMAKE_BINARY_DIR}/caesar_cipher_build)
add_subdirectory(${CMAKE_SOURCE_DIR}/../Modules/xor_cipher ${CMAKE_BINARY_DIR}/xor_cipher_build)

# Set the output directory to the current directory --> Application/
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR})  

# Include the header files of the libraries
include_directories(
    ${CMAKE_SOURCE_DIR}/../Modules/caesar_cipher/inc
    ${CMAKE_SOURCE_DIR}/../Modules/xor_cipher/inc
)

# Add the executable and link it with the libraries
add_executable(output ${CMAKE_SOURCE_DIR}/app.c)
# Link the libraries with the executable 
link_directories(${CMAKE_SOURCE_DIR}/out/lib)
# Link the libraries with the executable 
target_link_libraries(output caesar_cipher xor_cipher)
# Add the dependencies of the libraries 
add_dependencies(output caesar_cipher xor_cipher)

# Set the output directory of the executable 
set_target_properties(output PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR} 
    ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/out/gens
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/out/gens
)

# there was a problem as the object files were in the build directory not in out/gens directory
# so I had asked Grok for help and he told me to use the following command to rename the object files ('__') , So Sad
add_custom_command(TARGET output POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E rename
    ${CMAKE_BINARY_DIR}/CMakeFiles/output.dir/app.c.o
    ${CMAKE_SOURCE_DIR}/out/gens/app.o
)