#CMAKE_MINIMUM_REQUIRED(VERSION 2.6)
#SET(CMAKE_LEGACY_CYGWIN_WIN32 0)

#PROJECT(g2o)

#SET(g2o_C_FLAGS)
#SET(g2o_CXX_FLAGS)

## default built type
#IF(NOT CMAKE_BUILD_TYPE)
#  SET(CMAKE_BUILD_TYPE Release)
#ENDIF()

#MESSAGE(STATUS "BUILD TYPE:" ${CMAKE_BUILD_TYPE})

#SET (G2O_LIB_TYPE SHARED)

## There seems to be an issue with MSVC8
## see http://eigen.tuxfamily.org/bz/show_bug.cgi?id=83
#if(MSVC90)
#  add_definitions(-DEIGEN_DONT_ALIGN_STATICALLY=1)
#  message(STATUS "Disabling memory alignment for MSVC8")
#endif(MSVC90)

## Set search directory for looking for our custom CMake scripts to
## look for SuiteSparse, QGLViewer, and Eigen3.
#LIST(APPEND CMAKE_MODULE_PATH ${g2o_SOURCE_DIR}/cmake_modules)

## Detect OS and define macros appropriately
#IF(UNIX)
#  ADD_DEFINITIONS(-DUNIX)
#  MESSAGE(STATUS "Compiling on Unix")
#ENDIF(UNIX)

## For building the CHOLMOD / CSPARSE solvers
## FIND_PACKAGE(BLAS REQUIRED)
## FIND_PACKAGE(LAPACK REQUIRED)

## Eigen library parallelise itself, though, presumably due to performance issues
## OPENMP is experimental. We experienced some slowdown with it
#FIND_PACKAGE(OpenMP)
#SET(G2O_USE_OPENMP OFF CACHE BOOL "Build g2o with OpenMP support (EXPERIMENTAL)")
#IF(OPENMP_FOUND AND G2O_USE_OPENMP)
#  SET (G2O_OPENMP 1)
#  SET(g2o_C_FLAGS "${g2o_C_FLAGS} ${OpenMP_C_FLAGS}")
#  SET(g2o_CXX_FLAGS "${g2o_CXX_FLAGS} -DEIGEN_DONT_PARALLELIZE ${OpenMP_CXX_FLAGS}")
#  MESSAGE(STATUS "Compiling with OpenMP support")
#ENDIF(OPENMP_FOUND AND G2O_USE_OPENMP)

#IF(WIN32)
#  #ADD_DEFINITIONS(-DG2O_SHARED_LIBS)
#  SET (G2O_LIB_TYPE STATIC)
#  ADD_DEFINITIONS(-DWINDOWS)
#  MESSAGE(STATUS "Compiling on Windows")
#  IF(MSVC)
#    MESSAGE(STATUS "Compiling with MSVC")
#    ADD_DEFINITIONS(-DNOMINMAX)
#    ADD_DEFINITIONS(-D_USE_MATH_DEFINES)
#    add_definitions(-D_CRT_SECURE_NO_WARNINGS=1)  # Avoid deprecated fprintf(), etc.
#    add_definitions("/nologo")
#    add_definitions("/wd4244") # Conversion from double -> int
#    add_definitions("/wd4267") # Conversion during return
#    add_definitions("/wd4522") # Duplicated operator=() in Eigen headers
#    add_definitions("/wd4514") # unreferenced inline function has been removed
#    add_definitions("/wd4625") # copy constructor was implicitly defined as deleted
#    add_definitions("/wd4365") # conversion from 'int' to '::size_t'
#    add_definitions("/wd5026") # move constructor was implicitly defined as deleted
#    add_definitions("/wd4626") # assignment operator was implicitly defined as deleted
#    add_definitions("/wd5027") # move assignment operator was implicitly defined as deleted
#    add_definitions("/wd4820") # '4' bytes padding added after data member
#  ENDIF(MSVC)
#ENDIF(WIN32)

#IF(CMAKE_COMPILER_IS_GNUCXX)
#  # Compiler specific options for gcc
#  SET(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3 -march=native")
#  SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -O3 -march=native")

#  # activate warnings !!!
#  SET(g2o_C_FLAGS "${g2o_C_FLAGS} -Wall -W")
#  SET(g2o_CXX_FLAGS "${g2o_CXX_FLAGS} -Wall -W")
#ENDIF(CMAKE_COMPILER_IS_GNUCXX)

## specifying compiler flags
#SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${g2o_CXX_FLAGS}")
#SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${g2o_C_FLAGS}")

## Find Eigen3
#FIND_PACKAGE(Eigen3 3.1.0 REQUIRED)

## Generate config.h
#SET(G2O_SHARED_LIBS ${BUILD_SHARED_LIBS})
#SET(G2O_CXX_COMPILER "${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER}")
#configure_file(config.h.in ${g2o_SOURCE_DIR}/config.h)

## Set up the top-level include directories
#INCLUDE_DIRECTORIES(
#${g2o_SOURCE_DIR}/core
#${g2o_SOURCE_DIR}/types
#${g2o_SOURCE_DIR}/stuff
#${EIGEN3_INCLUDE_DIR})

## Include the subdirectories
#add_library(g2o STATIC ${G2O_LIB_TYPE}
##types
#include/g2o/types/types_sba.h
#include/g2o/types/types_six_dof_expmap.h
#src/types/types_sba.cpp
#src/types/types_six_dof_expmap.cpp
#src/types/types_seven_dof_expmap.cpp
#include/g2o/types/types_seven_dof_expmap.h
#include/g2o/types/se3quat.h
#include/g2o/types/se3_ops.h
#include/g2o/types/se3_ops.hpp
##core
#include/g2o/core/base_edge.h
#include/g2o/core/base_binary_edge.h
#src/core/hyper_graph_action.cpp
#include/g2o/core/base_binary_edge.hpp
#include/g2o/core/hyper_graph_action.h
#include/g2o/core/base_multi_edge.h
#src/core/hyper_graph.cpp
#include/g2o/core/base_multi_edge.hpp
#include/g2o/core/hyper_graph.h
#include/g2o/core/base_unary_edge.h
#include/g2o/core/linear_solver.h
#include/g2o/core/base_unary_edge.hpp
#src/core/marginal_covariance_cholesky.cpp
#include/g2o/core/base_vertex.h
#include/g2o/core/marginal_covariance_cholesky.h
#include/g2o/core/base_vertex.hpp
#src/core/matrix_structure.cpp
#src/core/batch_stats.cpp
#include/g2o/core/matrix_structure.h
#include/g2o/core/batch_stats.h
#include/g2o/core/openmp_mutex.h
#include/g2o/core/block_solver.h
#include/g2o/core/block_solver.hpp
#src/core/parameter.cpp
#include/g2o/core/parameter.h
#src/core/cache.cpp
#include/g2o/core/cache.h
#src/core/optimizable_graph.cpp
#include/g2o/core/optimizable_graph.h
#src/core/solver.cpp
#include/g2o/core/solver.h
#include/g2o/core/creators.h
#src/core/optimization_algorithm_factory.cpp
#src/core/estimate_propagator.cpp
#include/g2o/core/optimization_algorithm_factory.h
#include/g2o/core/estimate_propagator.h
#src/core/factory.cpp
#include/g2o/core/optimization_algorithm_property.h
#include/g2o/core/factory.h
#include/g2o/core/sparse_block_matrix.h
#include/g2o/core/sparse_block_matrix_ccs.h
#include/g2o/core/sparse_block_matrix_diagonal.h
#src/core/sparse_optimizer.cpp
#include/g2o/core/sparse_block_matrix.hpp
#include/g2o/core/sparse_optimizer.h
#src/core/hyper_dijkstra.cpp
#include/g2o/core/hyper_dijkstra.h
#src/core/parameter_container.cpp
#include/g2o/core/parameter_container.h
#src/core/optimization_algorithm.cpp
#include/g2o/core/optimization_algorithm.h
#src/core/optimization_algorithm_with_hessian.cpp
#include/g2o/core/optimization_algorithm_with_hessian.h
#src/core/optimization_algorithm_levenberg.cpp
#include/g2o/core/optimization_algorithm_levenberg.h
#src/core/jacobian_workspace.cpp
#include/g2o/core/jacobian_workspace.h
#src/core/robust_kernel.cpp
#include/g2o/core/robust_kernel.h
#src/core/robust_kernel_factory.cpp
#include/g2o/core/robust_kernel_factory.h
#src/core/robust_kernel_impl.cpp
#include/g2o/core/robust_kernel_impl.h
##stuff
#include/g2o/stuff/string_tools.h
#include/g2o/stuff/color_macros.h
#include/g2o/stuff/macros.h
#src/stuff/timeutil.cpp
#include/g2o/stuff/misc.h
#include/g2o/stuff/timeutil.h
#src/stuff/os_specific.c
#include/g2o/stuff/os_specific.h
#src/stuff/string_tools.cpp
#src/stuff/property.cpp
#include/g2o/stuff/property.h
#)

cmake_minimum_required(VERSION 2.6)
project(g2o)

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

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake_modules)

# Eigen library parallelise itself, though, presumably due to performance issues
# OPENMP is experimental. We experienced some slowdown with it
find_package(OpenMP)
set(G2O_USE_OPENMP OFF CACHE BOOL "Build g2o with OpenMP support (EXPERIMENTAL)")
if(OPENMP_FOUND AND G2O_USE_OPENMP)
  set(G2O_OPENMP 1)
  set(g2o_C_FLAGS "${g2o_C_FLAGS} ${OpenMP_C_FLAGS}")
  set(g2o_CXX_FLAGS "${g2o_CXX_FLAGS} -DEIGEN_DONT_PARALLELIZE ${OpenMP_CXX_FLAGS}")
  message(STATUS "Compiling with OpenMP support")
endif(OPENMP_FOUND AND G2O_USE_OPENMP)

# Find Eigen3
find_package(Eigen3 3.1.0 REQUIRED)

# Generate config.h
configure_file(config.h.in ${PROJECT_SOURCE_DIR}/include/g2o/config.h)

### TARGETS

add_library(${PROJECT_NAME} SHARED
# headers
# core
include/g2o/core/base_binary_edge.h
include/g2o/core/estimate_propagator.h
include/g2o/core/optimization_algorithm.h
include/g2o/core/base_binary_edge.hpp
include/g2o/core/factory.h
include/g2o/core/optimization_algorithm_levenberg.h
include/g2o/core/base_edge.h
include/g2o/core/hyper_dijkstra.h
include/g2o/core/optimization_algorithm_property.h
include/g2o/core/base_multi_edge.h
include/g2o/core/hyper_graph_action.h
include/g2o/core/optimization_algorithm_with_hessian.h
include/g2o/core/base_multi_edge.hpp
include/g2o/core/hyper_graph.h
include/g2o/core/parameter_container.h
include/g2o/core/base_unary_edge.h
include/g2o/core/jacobian_workspace.h
include/g2o/core/parameter.h
include/g2o/core/base_unary_edge.hpp
include/g2o/core/linear_solver.h
include/g2o/core/robust_kernel_factory.h
include/g2o/core/base_vertex.h
include/g2o/core/marginal_covariance_cholesky.h
include/g2o/core/robust_kernel.h
include/g2o/core/base_vertex.hpp
include/g2o/core/matrix_operations.h
include/g2o/core/robust_kernel_impl.h
include/g2o/core/batch_stats.h
include/g2o/core/matrix_structure.h
include/g2o/core/solver.h
include/g2o/core/block_solver.h
include/g2o/core/openmp_mutex.h
include/g2o/core/sparse_block_matrix_ccs.h
include/g2o/core/block_solver.hpp
include/g2o/core/optimizable_graph.h
include/g2o/core/sparse_block_matrix_diagonal.h
include/g2o/core/cache.h
include/g2o/core/optimization_algorithm_dogleg.h
include/g2o/core/sparse_block_matrix.h
include/g2o/core/creators.h
include/g2o/core/optimization_algorithm_factory.h
include/g2o/core/sparse_block_matrix.hpp
include/g2o/core/eigen_types.h
include/g2o/core/optimization_algorithm_gauss_newton.h
include/g2o/core/sparse_optimizer.h
# types
include/g2o/types/se3_ops.h
include/g2o/types/se3_ops.hpp
include/g2o/types/se3quat.h
include/g2o/types/sim3.h
include/g2o/types/types_sba.h
include/g2o/types/types_seven_dof_expmap.h
include/g2o/types/types_six_dof_expmap.h
# stuff
include/g2o/stuff/color_macros.h
include/g2o/stuff/macros.h
include/g2o/stuff/misc.h
include/g2o/stuff/os_specific.h
include/g2o/stuff/property.h
include/g2o/stuff/string_tools.h
include/g2o/stuff/timeutil.h
# solvers
include/g2o/solvers/linear_solver_dense.h
include/g2o/solvers/linear_solver_eigen.h
# sources
# core
src/core/hyper_graph_action.cpp
src/core/hyper_graph.cpp
src/core/marginal_covariance_cholesky.cpp
src/core/matrix_structure.cpp
src/core/batch_stats.cpp
src/core/parameter.cpp
src/core/cache.cpp
src/core/solver.cpp
src/core/optimization_algorithm_factory.cpp
src/core/estimate_propagator.cpp
src/core/factory.cpp
src/core/sparse_optimizer.cpp
src/core/hyper_dijkstra.cpp
src/core/parameter_container.cpp
src/core/optimizable_graph.cpp
src/core/optimization_algorithm.cpp
src/core/optimization_algorithm_with_hessian.cpp
src/core/optimization_algorithm_levenberg.cpp
src/core/jacobian_workspace.cpp
src/core/robust_kernel.cpp
src/core/robust_kernel_factory.cpp
src/core/robust_kernel_impl.cpp
# types
src/types/types_sba.cpp
src/types/types_six_dof_expmap.cpp
src/types/types_seven_dof_expmap.cpp
# stuff
src/stuff/timeutil.cpp
src/stuff/os_specific.c
src/stuff/string_tools.cpp
src/stuff/property.cpp
)

target_include_directories(${PROJECT_NAME}
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  PRIVATE
    $<BUILD_INTERFACE:${EIGEN3_INCLUDE_DIR}>
)
