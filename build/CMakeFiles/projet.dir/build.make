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
CMAKE_SOURCE_DIR = /home/maxime/projet-compilation

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/maxime/projet-compilation/build

# Include any dependencies generated for this target.
include CMakeFiles/projet.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/projet.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/projet.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/projet.dir/flags.make

parser.cpp: /home/maxime/projet-compilation/parser/parser.yy
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/home/maxime/projet-compilation/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "[BISON][parser] Building parser with bison 3.8.2"
	cd /home/maxime/projet-compilation && /usr/bin/bison -d --verbose -o /home/maxime/projet-compilation/build/parser.cpp parser/parser.yy

parser.output: parser.cpp
	@$(CMAKE_COMMAND) -E touch_nocreate parser.output

parser.hpp: parser.cpp
	@$(CMAKE_COMMAND) -E touch_nocreate parser.hpp

automate.txt: parser.output
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/home/maxime/projet-compilation/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "[BISON][parser] Copying bison verbose table to /home/maxime/projet-compilation/build/automate.txt"
	cd /home/maxime/projet-compilation && /usr/bin/cmake -E copy /home/maxime/projet-compilation/build/parser.output /home/maxime/projet-compilation/build/automate.txt

scanner.cpp: /home/maxime/projet-compilation/parser/scanner.ll
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/home/maxime/projet-compilation/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "[FLEX][scanner] Building scanner with flex 2.6.4"
	cd /home/maxime/projet-compilation && /usr/bin/flex -o/home/maxime/projet-compilation/build/scanner.cpp parser/scanner.ll

CMakeFiles/projet.dir/parser/main.cc.o: CMakeFiles/projet.dir/flags.make
CMakeFiles/projet.dir/parser/main.cc.o: /home/maxime/projet-compilation/parser/main.cc
CMakeFiles/projet.dir/parser/main.cc.o: CMakeFiles/projet.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/maxime/projet-compilation/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object CMakeFiles/projet.dir/parser/main.cc.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/projet.dir/parser/main.cc.o -MF CMakeFiles/projet.dir/parser/main.cc.o.d -o CMakeFiles/projet.dir/parser/main.cc.o -c /home/maxime/projet-compilation/parser/main.cc

CMakeFiles/projet.dir/parser/main.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/projet.dir/parser/main.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/maxime/projet-compilation/parser/main.cc > CMakeFiles/projet.dir/parser/main.cc.i

CMakeFiles/projet.dir/parser/main.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/projet.dir/parser/main.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/maxime/projet-compilation/parser/main.cc -o CMakeFiles/projet.dir/parser/main.cc.s

CMakeFiles/projet.dir/parser/driver.cc.o: CMakeFiles/projet.dir/flags.make
CMakeFiles/projet.dir/parser/driver.cc.o: /home/maxime/projet-compilation/parser/driver.cc
CMakeFiles/projet.dir/parser/driver.cc.o: CMakeFiles/projet.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/maxime/projet-compilation/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building CXX object CMakeFiles/projet.dir/parser/driver.cc.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/projet.dir/parser/driver.cc.o -MF CMakeFiles/projet.dir/parser/driver.cc.o.d -o CMakeFiles/projet.dir/parser/driver.cc.o -c /home/maxime/projet-compilation/parser/driver.cc

CMakeFiles/projet.dir/parser/driver.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/projet.dir/parser/driver.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/maxime/projet-compilation/parser/driver.cc > CMakeFiles/projet.dir/parser/driver.cc.i

CMakeFiles/projet.dir/parser/driver.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/projet.dir/parser/driver.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/maxime/projet-compilation/parser/driver.cc -o CMakeFiles/projet.dir/parser/driver.cc.s

CMakeFiles/projet.dir/parser.cpp.o: CMakeFiles/projet.dir/flags.make
CMakeFiles/projet.dir/parser.cpp.o: parser.cpp
CMakeFiles/projet.dir/parser.cpp.o: CMakeFiles/projet.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/maxime/projet-compilation/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building CXX object CMakeFiles/projet.dir/parser.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/projet.dir/parser.cpp.o -MF CMakeFiles/projet.dir/parser.cpp.o.d -o CMakeFiles/projet.dir/parser.cpp.o -c /home/maxime/projet-compilation/build/parser.cpp

CMakeFiles/projet.dir/parser.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/projet.dir/parser.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/maxime/projet-compilation/build/parser.cpp > CMakeFiles/projet.dir/parser.cpp.i

CMakeFiles/projet.dir/parser.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/projet.dir/parser.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/maxime/projet-compilation/build/parser.cpp -o CMakeFiles/projet.dir/parser.cpp.s

CMakeFiles/projet.dir/scanner.cpp.o: CMakeFiles/projet.dir/flags.make
CMakeFiles/projet.dir/scanner.cpp.o: scanner.cpp
CMakeFiles/projet.dir/scanner.cpp.o: parser.hpp
CMakeFiles/projet.dir/scanner.cpp.o: CMakeFiles/projet.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/maxime/projet-compilation/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building CXX object CMakeFiles/projet.dir/scanner.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/projet.dir/scanner.cpp.o -MF CMakeFiles/projet.dir/scanner.cpp.o.d -o CMakeFiles/projet.dir/scanner.cpp.o -c /home/maxime/projet-compilation/build/scanner.cpp

CMakeFiles/projet.dir/scanner.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/projet.dir/scanner.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/maxime/projet-compilation/build/scanner.cpp > CMakeFiles/projet.dir/scanner.cpp.i

CMakeFiles/projet.dir/scanner.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/projet.dir/scanner.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/maxime/projet-compilation/build/scanner.cpp -o CMakeFiles/projet.dir/scanner.cpp.s

# Object files for target projet
projet_OBJECTS = \
"CMakeFiles/projet.dir/parser/main.cc.o" \
"CMakeFiles/projet.dir/parser/driver.cc.o" \
"CMakeFiles/projet.dir/parser.cpp.o" \
"CMakeFiles/projet.dir/scanner.cpp.o"

# External object files for target projet
projet_EXTERNAL_OBJECTS =

projet: CMakeFiles/projet.dir/parser/main.cc.o
projet: CMakeFiles/projet.dir/parser/driver.cc.o
projet: CMakeFiles/projet.dir/parser.cpp.o
projet: CMakeFiles/projet.dir/scanner.cpp.o
projet: CMakeFiles/projet.dir/build.make
projet: libexpressions.a
projet: CMakeFiles/projet.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/home/maxime/projet-compilation/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Linking CXX executable projet"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/projet.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/projet.dir/build: projet
.PHONY : CMakeFiles/projet.dir/build

CMakeFiles/projet.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/projet.dir/cmake_clean.cmake
.PHONY : CMakeFiles/projet.dir/clean

CMakeFiles/projet.dir/depend: automate.txt
CMakeFiles/projet.dir/depend: parser.cpp
CMakeFiles/projet.dir/depend: parser.hpp
CMakeFiles/projet.dir/depend: parser.output
CMakeFiles/projet.dir/depend: scanner.cpp
	cd /home/maxime/projet-compilation/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/maxime/projet-compilation /home/maxime/projet-compilation /home/maxime/projet-compilation/build /home/maxime/projet-compilation/build /home/maxime/projet-compilation/build/CMakeFiles/projet.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/projet.dir/depend

