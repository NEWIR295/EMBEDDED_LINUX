cmake_minimum_required(VERSION 3.19)
project(Server_GUI LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Core Widgets Charts Quick QuickWidgets)

set(PROJECT_SOURCES
    main.cpp
    mainwindow.cpp
    mainwindow.h
    mainwindow.ui
    realTimeMonitor.cpp
    realTimeMonitor.hpp
    historicalAnalysis.cpp
    historicalAnalysis.hpp
    configuration.cpp
    configuration.hpp
    quickAccess.cpp
    quickAccess.hpp
    resources.qrc
)

set(IoT_Device_Communication_System_Lib ${CMAKE_CURRENT_SOURCE_DIR}/Lib/libIoT_Device_Communication_System_Lib.a)

add_executable(Server_Gui
    ${PROJECT_SOURCES}
)

target_link_libraries(Server_Gui PRIVATE Qt6::Core Qt6::Widgets Qt6::Charts Qt6::Quick Qt6::QuickWidgets ${IoT_Device_Communication_System_Lib})
target_include_directories(Server_Gui PRIVATE ./Include)

set_target_properties(Server_Gui PROPERTIES
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

include(GNUInstallDirs)

install(TARGETS Server_Gui
    BUNDLE  DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
