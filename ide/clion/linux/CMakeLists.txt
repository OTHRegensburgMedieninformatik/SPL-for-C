cmake_minimum_required(VERSION 3.6)
project(StarterProject C CXX)

set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 17)

set(SOURCES HelloGraphics.c)
set(APPNAME StarterProject)

# Include Directories
include_directories("include")

# Executables
add_executable(${APPNAME} ${SOURCES})
set_target_properties(${APPNAME} PROPERTIES LINKER_LANGUAGE "CXX")

# Linked Libraries
target_link_libraries(${APPNAME} ${CMAKE_CURRENT_SOURCE_DIR}/lib/libcs.a)
target_link_libraries(${APPNAME} m pthread dl unwind)

# This file has  to be in output directory
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/lib/spl.jar DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
