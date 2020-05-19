cmake_minimum_required(VERSION 3.15.0)
project (CBA_CompileFunctions)

set(CMAKE_CXX_STANDARD 17)

file (GLOB SOURCES "CompileFunctions.cpp")

add_library(CBA_CompileFunctions SHARED ${SOURCES})

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${PROJECT_NAME}> ${PROJECT_SOURCE_DIR}/../${PROJECT_NAME}_x64.dll
)
