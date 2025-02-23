# CMake package config file for callbacks library.
#
# The following target is imported:
#
#   callbacks::callbacks
#
# Type of target to import (static or shared) is determined by the following algorithm:
#
#   1. if LIB_SHARED_LIBS is defined and:
#     1.1 is true, then import shared library target or issue error
#     1.2 is false, then import static library target or issue error
#
#   2. if BUILD_SHARED_LIBS is true and file containing shared library target definition exists,
#      then import shared library target
#
#   3. if file containing static library target definition exists, then import static library target
#
#   4. import shared library target or issue error


####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was callbacks-config.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

macro(set_and_check _var _file)
  set(${_var} "${_file}")
  if(NOT EXISTS "${_file}")
    message(FATAL_ERROR "File or directory ${_file} referenced by variable ${_var} does not exist !")
  endif()
endmacro()

macro(check_required_components _NAME)
  foreach(comp ${${_NAME}_FIND_COMPONENTS})
    if(NOT ${_NAME}_${comp}_FOUND)
      if(${_NAME}_FIND_REQUIRED_${comp})
        set(${_NAME}_FOUND FALSE)
      endif()
    endif()
  endforeach()
endmacro()

####################################################################################

macro(import_targets type)
    if(NOT EXISTS "${CMAKE_CURRENT_LIST_DIR}/callbacks-${type}-targets.cmake")
        set(${CMAKE_FIND_PACKAGE_NAME}_NOT_FOUND_MESSAGE "callbacks ${type} libraries were requested but not found")
        set(${CMAKE_FIND_PACKAGE_NAME}_FOUND OFF)
        return()
    endif()

    include("${CMAKE_CURRENT_LIST_DIR}/callbacks-${type}-targets.cmake")
endmacro()

if(NOT TARGET callbacks::callbacks)
    set(type "")

    if(DEFINED LIB_SHARED_LIBS)
        if(LIB_SHARED_LIBS)
            set(type "shared")
        else()
            set(type "static")
        endif()
    elseif(BUILD_SHARED_LIBS AND EXISTS "${CMAKE_CURRENT_LIST_DIR}/callbacks-shared-targets.cmake")
        set(type "shared")
    elseif(EXISTS "${CMAKE_CURRENT_LIST_DIR}/callbacks-static-targets.cmake")
        set(type "static")
    else()
        set(type "shared")
    endif()

    import_targets(${type})
    check_required_components(callbacks)
    message("-- Found ${type} callbacks (version ${${CMAKE_FIND_PACKAGE_NAME}_VERSION})")
endif()
