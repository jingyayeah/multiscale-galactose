#Specify the version being used aswell as the language
cmake_minimum_required(VERSION 2.6)

#Name your project here
project(CopasiModelRunner)
# Define folders
Set(COPASI_H1 /home/mkoenig/copasi/COPASI)
Set(COPASI_H2 /home/mkoenig/copasi/COPASI/copasi)

# include header files
# Two things must be done. First add the directory to be included:
include_directories(${COPASI_H1} ${COPASI_H2})



#Sends the -std=c99 flag to the gcc compiler
# add_definitions(-std=c99)

# add all folds in folder to target
file(GLOB CopasiModelRunner_SRC
    "src/*.h"
    "src/*.cpp"
)
add_executable(CopasiModelRunner ${CopasiModelRunner_SRC})


#This tells CMake to fib.c and name it fibonacci
# add_executable(CopasiModelRunner src/CopasiModelRunner.cpp)
