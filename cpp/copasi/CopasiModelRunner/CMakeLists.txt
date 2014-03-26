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

# link_directories( ${CMAKE_SOURCE_DIR} )

# add all folds in folder to target
file(GLOB CopasiModelRunner_SRC
    "src/*.h"
    "src/*.cpp"
)
add_executable(CopasiModelRunner ${CopasiModelRunner_SRC})

find_library(BOOST_SYSTEM boost_system /usr/include)
target_link_libraries(CopasiModelRunner ${BOOST_SYSTEM})
find_library(BOOST_PROGRAM_OPTIONS boost_program_options /usr/include)
target_link_libraries(CopasiModelRunner ${BOOST_PROGRAM_OPTIONS})

# add static libraries for the linker
# LIBS := -lboost_system -lboost_program_options -lCOPASISE -lSBW-static -lsbml-static -lraptor -llapack -lblas -lcppunit -lexpat -lf2c
target_link_libraries(CopasiModelRunner ${CMAKE_SOURCE_DIR}/libCOPASISE.a)
target_link_libraries(CopasiModelRunner ${CMAKE_SOURCE_DIR}/libSBW-static.a)
target_link_libraries(CopasiModelRunner ${CMAKE_SOURCE_DIR}/libsbml-static.a)
target_link_libraries(CopasiModelRunner ${CMAKE_SOURCE_DIR}/libraptor.a)
target_link_libraries(CopasiModelRunner ${CMAKE_SOURCE_DIR}/liblapack.a)
target_link_libraries(CopasiModelRunner ${CMAKE_SOURCE_DIR}/libblas.a)
target_link_libraries(CopasiModelRunner ${CMAKE_SOURCE_DIR}/libcppunit.a)
target_link_libraries(CopasiModelRunner ${CMAKE_SOURCE_DIR}/libexpat.a)
target_link_libraries(CopasiModelRunner ${CMAKE_SOURCE_DIR}/libf2c.a)
