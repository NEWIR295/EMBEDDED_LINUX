#Author: Mohamed Newir
#Date: 10/3/2025
#File Name: CMakelists.txt
#Description: This file is used to compile the source code for the project
#             and set the required version of cmake 
#             It also sets the compile options and the include directories for the project. 

#set the minimum required version of cmake
cmake_minimum_required(VERSION 3.10)

#set the project name
project(LAPP3
        VERSION 1.0.0
        DESCRIPTION "Linux Administration Project Part 3"
        LANGUAGES C)

#set the sources to be compiled 
set(SOURCES 
    ./Source/main.c
    #./Source/shape.cpp
    )

#add the executable
add_executable(Output ${SOURCES})
#add the include directories
target_include_directories(Output PRIVATE ./Include)
#add the compile options
target_compile_options(Output PRIVATE -Wall -Wextra -Werror -Wpedantic)