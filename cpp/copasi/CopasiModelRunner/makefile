##########################################################################
# Makefile for CopasiModelRunner
#
##########################################################################

# COMPILE THE RESOURCES
# make all 
# Building file: ../src/CopasiModelRunner.cpp
# Invoking: Cross G++ Compiler
# g++ -I/home/mkoenig/copasi/COPASI -I/home/mkoenig/copasi/COPASI/copasi -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"src/CopasiModelRunner.d" -MT"src/CopasiModelRunner.d" -o "src/CopasiModelRunner.o" "../src/CopasiModelRunner.cpp"
# Finished building: ../src/CopasiModelRunner.cpp

# Building file: ../src/MParameter.cpp
# Invoking: Cross G++ Compiler
# g++ -I/home/mkoenig/copasi/COPASI -I/home/mkoenig/copasi/COPASI/copasi -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"src/MParameter.d" -MT"src/MParameter.d" -o "src/MParameter.o" "../src/MParameter.cpp"
# Finished building: ../src/MParameter.cpp
 
# Building file: ../src/ModelSimulator.cpp
# Invoking: Cross G++ Compiler
# g++ -I/home/mkoenig/copasi/COPASI -I/home/mkoenig/copasi/COPASI/copasi -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"src/ModelSimulator.d" -MT"src/ModelSimulator.d" -o "src/ModelSimulator.o" "../src/ModelSimulator.cpp"
# Finished building: ../src/ModelSimulator.cpp
 
# Building file: ../src/TimecourseParameters.cpp
# Invoking: Cross G++ Compiler
# g++ -I/home/mkoenig/copasi/COPASI -I/home/mkoenig/copasi/COPASI/copasi -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"src/# TimecourseParameters.d" -MT"src/TimecourseParameters.d" -o "src/TimecourseParameters.o" "../src/TimecourseParameters.cpp"
# Finished building: ../src/TimecourseParameters.cpp

# LINK THE RESOURCES
# Building target: CopasiModelRunner
# Invoking: Cross G++ Linker
# g++ -L"/home/mkoenig/multiscale-galactose/cpp/copasi/CopasiModelRunner" -L/usr/include -o "CopasiModelRunner"  ./src/CopasiModelRunner.o ./src/MParameter.o ./src/ModelSimulator.o ./src/TimecourseParameters.o   -lboost_system -lboost_program_options -lCOPASISE -lSBW-static -lsbml-static -lraptor -llapack -lblas -lcppunit -lexpat -lf2c
# Finished building target: CopasiModelRunner

LIBS := -lboost_system -lboost_program_options -lCOPASISE -lSBW-static -lsbml-static -lraptor -llapack -lblas -lcppunit -lexpat -lf2c

# Compiling instructions, but the dependencies have to be defined 
# somewhere
# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: Cross G++ Compiler'
	g++ -I/home/mkoenig/copasi/COPASI -I/home/mkoenig/copasi/COPASI/copasi -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '