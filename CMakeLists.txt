cmake_minimum_required(VERSION 3.2)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(BUILD_EXAMPLES "Build examples" ON)
option(BUILD_TESTS "Build tests" ON)

include("cmake/HunterGate.cmake")
     HunterGate(
         URL "https://github.com/path/to/hunter/archive.tar.gz"
         SHA1 "798501e983f14b28b10cda16afa4de69eee1da1d"
     )


project(sqrt)
set(SQRT_VERSION_MAJOR 0)
set(SQRT_VERSION_MINOR 1)
set(SQRT_VERSION_PATCH 0)
set(SQRT_VERSION_TWEAK 0)
set(SQRT_VERSION
        ${SQRT_VERSION_MAJOR}.${SQRT_VERSION_MINOR}.${SQRT_VERSION_PATCH}.${SQRT_VERSION_TWEAK})
set(SQRT_VERSION_STRING "v${SQRT_VERSION}")

hunter_add_package(GTest)
find_package(GTest CONFIG REQUIRED)

add_library(sqrt STATIC ${CMAKE_CURRENT_SOURCE_DIR}/sources/sqrt.cpp)
        
target_include_directories(sqrt PUBLIC
                           $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
                           $<INSTALL_INTERFACE:include>
                           )

if (BUILD_EXAMPLES)
file(GLOB EXAMPLE_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/examples/*.cpp")
foreach (EXAMPLE_SOURCE ${EXAMPLE_SOURCES})
get_filename_component(EXAMPLE_NAME ${EXAMPLE_SOURCE} NAME_WE)
add_executable(${EXAMPLE_NAME} ${EXAMPLE_SOURCE})
target_link_libraries(${EXAMPLE_NAME} sqrt)
install(TARGETS ${EXAMPLE_NAME}
        RUNTIME DESTINATION bin
        )
endforeach (EXAMPLE_SOURCE ${EXAMPLE_SOURCES})
endif ()

install(TARGETS sqrt
        EXPORT sqrt-config
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib
        )


install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include/ DESTINATION include)
install(EXPORT sqrt-config DESTINATION cmake)

if(BUILD_TESTS)
    enable_testing()
    file(GLOB ${PROJECT_NAME}_TEST_SOURCES tests/*.cpp)
    add_executable(check ${${PROJECT_NAME}_TEST_SOURCES})
    target_link_libraries(check ${PROJECT_NAME} GTest::gtest_main)
    add_test(NAME check COMMAND check)
endif()

include(CPackConfig.cmake)
