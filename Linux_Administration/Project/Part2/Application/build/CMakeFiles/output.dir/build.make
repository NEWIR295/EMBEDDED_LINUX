# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.28

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/build

# Include any dependencies generated for this target.
include CMakeFiles/output.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/output.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/output.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/output.dir/flags.make

CMakeFiles/output.dir/app.c.o: CMakeFiles/output.dir/flags.make
CMakeFiles/output.dir/app.c.o: /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/app.c
CMakeFiles/output.dir/app.c.o: CMakeFiles/output.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/output.dir/app.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/output.dir/app.c.o -MF CMakeFiles/output.dir/app.c.o.d -o CMakeFiles/output.dir/app.c.o -c /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/app.c

CMakeFiles/output.dir/app.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/output.dir/app.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/app.c > CMakeFiles/output.dir/app.c.i

CMakeFiles/output.dir/app.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/output.dir/app.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/app.c -o CMakeFiles/output.dir/app.c.s

# Object files for target output
output_OBJECTS = \
"CMakeFiles/output.dir/app.c.o"

# External object files for target output
output_EXTERNAL_OBJECTS =

/home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/output: CMakeFiles/output.dir/app.c.o
/home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/output: CMakeFiles/output.dir/build.make
/home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/output: /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/out/lib/libcaesar_cipher.a
/home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/output: /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/out/lib/libxor_cipher.so
/home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/output: CMakeFiles/output.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/output"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/output.dir/link.txt --verbose=$(VERBOSE)
	/usr/bin/cmake -E rename /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/build/CMakeFiles/output.dir/app.c.o /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/out/gens/app.o

# Rule to build all files generated by this target.
CMakeFiles/output.dir/build: /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/output
.PHONY : CMakeFiles/output.dir/build

CMakeFiles/output.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/output.dir/cmake_clean.cmake
.PHONY : CMakeFiles/output.dir/clean

CMakeFiles/output.dir/depend:
	cd /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/build /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/build /home/newir529/EMBEDDED_LINUX/Linux_Administration/Project/Part2/Application/build/CMakeFiles/output.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/output.dir/depend

