cmake_minimum_required(VERSION 2.8 FATAL_ERROR)
project(esepp)

#---Locate the ROOT package and defines a number of variables (e.g. ROOT_INCLUDE_DIRS)
find_package(ROOT REQUIRED COMPONENTS MathMore Foam)
include(${ROOT_USE_FILE})

add_executable(
esepp
const.h
dialog.h
esepp.cxx
esepp.h
input_output.pdf
interference.h
lepton.h
proton.h
)

configure_file(vpol.dat vpol.dat COPYONLY)
target_link_libraries(esepp ${ROOT_LIBRARIES})

