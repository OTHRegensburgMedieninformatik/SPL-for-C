cmake_minimum_required(VERSION 3.6)
project(StarterProject)

set(CMAKE_C_STANDARD 11)

set(SOURCE_FILES HelloGraphics.c)

# Include Directories
include_directories("include")

# Executables
add_executable(StarterProject ${SOURCE_FILES})

# Linked Libraries
target_link_libraries(StarterProject ${CMAKE_CURRENT_SOURCE_DIR}/lib/libcs.a)
target_link_libraries(StarterProject ${CMAKE_CURRENT_SOURCE_DIR}/lib/libfreeimage.a)
target_link_libraries(StarterProject stdc++)
target_link_libraries(StarterProject m)

# This file has  to be in output directory
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/lib/spl.jar DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
