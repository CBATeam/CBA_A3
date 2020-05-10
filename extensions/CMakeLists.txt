cmake_minimum_required(VERSION 3.2.0)
project (CBA_JoyKeys)

file (GLOB SOURCES "JoystickButtons.cpp")

add_library(CBA_JoyKeys SHARED ${SOURCES})

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${PROJECT_NAME}> ${PROJECT_SOURCE_DIR}/../${PROJECT_NAME}_x64.dll
)
