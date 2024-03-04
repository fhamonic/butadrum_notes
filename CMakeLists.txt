cmake_minimum_required(VERSION 3.12)

project(
  MEBENCHMARK_LONS
  VERSION 1.0
  DESCRIPTION "Butadrum note disposition"
  LANGUAGES CXX)

# set(CMAKE_VERBOSE_MAKEFILE ON)

# ################### Options ####################
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(WARNINGS "Enable warnings" OFF)
option(OPTIMIZE_FOR_NATIVE "Build with -march=native" OFF)

# ################### Modules ####################
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})
include(GNUInstallDirs)
include(CompilerWarnings)
include(CompilerOptimizations)

# ################### Packages ####################
find_package(range-v3 REQUIRED)
find_package(mippp REQUIRED)
find_package(GUROBI REQUIRED)

# ################## Main Target ##################
add_executable(butadrum_notes src/main.cpp)
target_link_libraries(butadrum_notes PUBLIC mippp::mippp)

find_package(SCIP REQUIRED)
target_compile_definitions(butadrum_notes PUBLIC MIPPP_USE_SCIP=1)
target_include_directories(butadrum_notes PUBLIC ${SCIP_INCLUDE_DIR})
target_link_libraries(butadrum_notes PUBLIC ${SCIP_LIBRARIES})

# find_package(GUROBI REQUIRED)
# target_compile_definitions(butadrum_notes PUBLIC MIPPP_USE_GUROBI=1)
# target_include_directories(butadrum_notes PUBLIC ${GUROBI_INCLUDE_DIR})
# target_link_libraries(butadrum_notes PUBLIC ${GUROBI_LIBRARIES})
