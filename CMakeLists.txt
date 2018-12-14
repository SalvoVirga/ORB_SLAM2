cmake_minimum_required(VERSION 2.8)
project(orb_slam2)

### GENERAL

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Allows all symbols generated from the dynamic library to be exported.
if (WIN32)
  set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS TRUE)
endif(WIN32)

# Output all binaries and libs into a common folder across all libraries.
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake_modules)

# Set the compiler options to the given target according to the current architecture.
function(orbslam2_compile_options target_name)
  if(MSVC)
    target_compile_options(${target_name} PRIVATE /W4 /w44640 /WX)
    if (MSVC_VERSION GREATER 1900)
      target_compile_options(${target_name} PRIVATE /permissive-)
    endif()
  else()
    target_compile_options(${target_name} PRIVATE -Werror -Wall -Wextra -Wshadow -Wnon-virtual-dtor -pedantic)
  endif()
endfunction(orbslam2_compile_options)

### UTILITIES

option(ORBSLAM2_USE_IWYU "FALSE")
option(ORBSLAM2_USE_LWYU "FALSE")
mark_as_advanced(ORBSLAM2_USE_IWYU ORBSLAM2_USE_LWYU)

if (${ORBSLAM2_USE_IWYU})
  find_program(iwyu_path NAMES include-what-you-use iwyu)
  if(NOT iwyu_path)
    message(FATAL_ERROR "Could not find include-what-you-use")
  else()
    set(CMAKE_CXX_INCLUDE_WHAT_YOU_USE ${iwyu_path})
  endif()
endif()

if (${ORBSLAM2_USE_LWYU})
  set(CMAKE_LINK_WHAT_YOU_USE ON)
endif()

###### OPTIONAL BUILDS

option(ORBSLAM2_BUILD_EXAMPLES "Build ORB_SLAM2 Examples" FALSE)
option(ORBSLAM2_BUILD_TESTS "Build ORB_SLAM2 Tests" FALSE)
option(ORBSLAM2_BUILD_DOC "Build ORB_SLAM2 Documentation" FALSE)

# Examples.
if (${ORBSLAM2_BUILD_EXAMPLES})
  add_subdirectory(examples)
endif()

# Documentation.
if (${ORBSLAM2_BUILD_DOC})
  add_subdirectory(doc)
endif()

### FIND PACKAGES

find_package(OpenCV 3.0 QUIET)
if(NOT OpenCV_FOUND)
   find_package(OpenCV 2.4.3 QUIET)
   if(NOT OpenCV_FOUND)
      message(FATAL_ERROR "OpenCV > 2.4.3 not found.")
   endif()
endif()

find_package(Eigen3 3.1.0 REQUIRED)
find_package(Pangolin REQUIRED)

### THIRPARTY LIBS

add_subdirectory(thirdparty/DBoW2)
add_subdirectory(thirdparty/g2o)

### TARGETS

file(GLOB ORBSLAM2_HEADERS "include/orb_slam2/*.h")

add_library(${PROJECT_NAME} SHARED
  src/System.cc
  src/Tracking.cc
  src/LocalMapping.cc
  src/LoopClosing.cc
  src/ORBextractor.cc
  src/ORBmatcher.cc
  src/FrameDrawer.cc
  src/Converter.cc
  src/MapPoint.cc
  src/KeyFrame.cc
  src/Map.cc
  src/MapDrawer.cc
  src/Optimizer.cc
  src/PnPsolver.cc
  src/Frame.cc
  src/KeyFrameDatabase.cc
  src/Sim3Solver.cc
  src/Initializer.cc
  src/Viewer.cc
)

target_include_directories(${PROJECT_NAME}
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  PRIVATE
    $<BUILD_INTERFACE:${EIGEN3_INCLUDE_DIR}>
    $<BUILD_INTERFACE:${Pangolin_INCLUDE_DIRS}>
)

target_link_libraries(${PROJECT_NAME} PUBLIC
  ${OpenCV_LIBS}
  ${Pangolin_LIBRARIES}
  DBoW2
  g2o
)
