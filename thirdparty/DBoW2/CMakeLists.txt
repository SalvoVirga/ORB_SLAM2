cmake_minimum_required(VERSION 2.8)
project(DBoW2)

file(GLOB DBoW2_HEADERS "include/${PROJECT_NAME}/*.h" "include/${PROJECT_NAME}/*.hpp")

find_package(OpenCV 3.0 QUIET)
if(NOT OpenCV_FOUND)
   find_package(OpenCV 2.4.3 QUIET)
   if(NOT OpenCV_FOUND)
      message(FATAL_ERROR "OpenCV > 2.4.3 not found.")
   endif()
endif()

add_library(${PROJECT_NAME} SHARED
  ${DBoW2_HEADERS}  
  src/BowVector.cpp
  src/FORB.cpp      
  src/FeatureVector.cpp
  src/ScoringObject.cpp
  src/Random.cpp
  src/Timestamp.cpp)

target_include_directories(${PROJECT_NAME}
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  PRIVATE
    $<BUILD_INTERFACE:${OpenCV_INCLUDE_DIRS}>
)

target_link_libraries(${PROJECT_NAME} ${OpenCV_LIBS})

