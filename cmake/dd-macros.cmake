macro(setup_qt)

  if(NOT DEFINED USE_QT_VERSION)
    set(USE_QT_VERSION 4)
  endif()

  if(DEFINED Qt5_DIR AND DEFINED QT_QMAKE_EXECUTABLE)
    message(FATAL_ERROR
      "This project should not be configured with both Qt5_DIR and QT_QMAKE_EXECUTABLE options.
  To build with Qt4, specify QT_QMAKE_EXECUTABLE. To build with Qt5, specify  Qt5_DIR.")
  endif()

  if(USE_QT_VERSION MATCHES 4)
    find_package(Qt4 REQUIRED QtCore QtGui QtOpenGL QtScript)
    include(${QT_USE_FILE})
  elseif(USE_QT_VERSION MATCHES 5)
    find_package(Qt5 REQUIRED Core Gui Widgets OpenGL)
  else()
    message(FATAL_ERROR "USE_QT_VERSION is set to an unexpected value: ${USE_QT_VERSION}")
  endif()

endmacro()


macro(use_cpp11)
  if (CMAKE_COMPILER_IS_GNUCC)
    execute_process(COMMAND ${CMAKE_C_COMPILER} -dumpversion
                    OUTPUT_VARIABLE GCC_VERSION)
    if (NOT (GCC_VERSION VERSION_GREATER 4.3 OR GCC_VERSION VERSION_EQUAL 4.3))
      message(FATAL_ERROR "requires gcc version >= 4.3")  # to support the c++0x flag below
    elseif(GCC_VERSION VERSION_LESS 4.7)
      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
    else()
	    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
    endif()
  elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
    if (APPLE)
      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
    endif()
  endif()
endmacro()


macro(use_pkg target)

  find_package(PkgConfig REQUIRED)

  foreach (pkgname ${ARGN})
    set(cachevar ${pkgname}_pkgconfig)
    pkg_check_modules(${cachevar} ${pkgname})

    if (NOT ${cachevar}_FOUND)
      message(SEND_ERROR "required package ${pkgname} not found. PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH}")
    endif()

    string(REPLACE ";" " " _cflags_str "${${cachevar}_CFLAGS}")
    string(REPLACE ";" " " _ldflags_str "${${cachevar}_LDFLAGS}")
    set_property(TARGET ${target} APPEND_STRING PROPERTY COMPILE_FLAGS "${_cflags_str} ")
    set_property(TARGET ${target} APPEND_STRING PROPERTY LINK_FLAGS "${_ldflags_str} ")
    link_directories(${${cachevar}_LIBRARY_DIRS})
    target_link_libraries(${target} ${${cachevar}_LIBRARIES})

  endforeach()

endmacro()

macro(setup_pods_pkg_config_path)
  set(ENV{PKG_CONFIG_PATH} "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig:$ENV{PKG_CONFIG_PATH}")
endmacro()

setup_pods_pkg_config_path()
