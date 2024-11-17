# This file will be regenerated by `mulle-sourcetree-to-cmake` via
# `mulle-sde reflect` and any edits will be lost.
#
# This file will be included by cmake/share/Files.cmake
#
# Disable generation of this file with:
#
# mulle-sde environment set MULLE_SOURCETREE_TO_CMAKE_DEPENDENCIES_FILE DISABLE
#
if( MULLE_TRACE_INCLUDE)
   message( STATUS "# Include \"${CMAKE_CURRENT_LIST_FILE}\"" )
endif()

#
# Generated from sourcetree: 4EFE2D74-80DA-4D84-B56F-612F746A8C54;mulle-musl;no-all-load,no-cmake-loader,no-cmake-searchpath,no-header,no-import,only-cmake-sdk-musl,only-craft-sdk-musl;c
# Disable with : `mulle-sourcetree mark mulle-musl no-link`
# Disable for this platform: `mulle-sourcetree mark mulle-musl no-cmake-platform-${MULLE_UNAME}`
# Disable for a sdk: `mulle-sourcetree mark mulle-musl no-cmake-sdk-<name>`
#
if( MUSL_STATIC_ONLY)
   if( COLLECT_DEPENDENCY_LIBRARIES_AS_NAMES)
      list( APPEND DEPENDENCY_LIBRARIES "c")
   else()
      if( NOT MULLE__MUSL_LIBRARY)
         find_library( MULLE__MUSL_LIBRARY NAMES
            ${CMAKE_STATIC_LIBRARY_PREFIX}c${CMAKE_DEBUG_POSTFIX}${CMAKE_STATIC_LIBRARY_SUFFIX}
            ${CMAKE_STATIC_LIBRARY_PREFIX}c${CMAKE_STATIC_LIBRARY_SUFFIX}
            c
            NO_CMAKE_SYSTEM_PATH NO_SYSTEM_ENVIRONMENT_PATH
         )
         if( NOT MULLE__MUSL_LIBRARY AND NOT DEPENDENCY_IGNORE_SYSTEM_LIBARIES)
            find_library( MULLE__MUSL_LIBRARY NAMES
               ${CMAKE_STATIC_LIBRARY_PREFIX}c${CMAKE_DEBUG_POSTFIX}${CMAKE_STATIC_LIBRARY_SUFFIX}
               ${CMAKE_STATIC_LIBRARY_PREFIX}c${CMAKE_STATIC_LIBRARY_SUFFIX}
               c
            )
         endif()
         message( STATUS "MULLE__MUSL_LIBRARY is ${MULLE__MUSL_LIBRARY}")
         #
         # The order looks ascending, but due to the way this file is read
         # it ends up being descending, which is what we need.
         #
         if( MULLE__MUSL_LIBRARY)
            #
            # Add MULLE__MUSL_LIBRARY to DEPENDENCY_LIBRARIES list.
            # Disable with: `mulle-sourcetree mark mulle-musl no-cmake-add`
            #
            list( APPEND DEPENDENCY_LIBRARIES ${MULLE__MUSL_LIBRARY})
            #
            # Inherit information from dependency.
            # Encompasses: no-cmake-searchpath,no-cmake-dependency,no-cmake-loader
            # Disable with: `mulle-sourcetree mark mulle-musl no-cmake-inherit`
            #
            # temporarily expand CMAKE_MODULE_PATH
            get_filename_component( _TMP_MULLE__MUSL_ROOT "${MULLE__MUSL_LIBRARY}" DIRECTORY)
            get_filename_component( _TMP_MULLE__MUSL_ROOT "${_TMP_MULLE__MUSL_ROOT}" DIRECTORY)
            #
            #
            # Search for "Definitions.cmake" and "DependenciesAndLibraries.cmake" to include.
            # Disable with: `mulle-sourcetree mark mulle-musl no-cmake-dependency`
            #
            foreach( _TMP_MULLE__MUSL_NAME "c")
               set( _TMP_MULLE__MUSL_DIR "${_TMP_MULLE__MUSL_ROOT}/include/${_TMP_MULLE__MUSL_NAME}/cmake")
               # use explicit path to avoid "surprises"
               if( IS_DIRECTORY "${_TMP_MULLE__MUSL_DIR}")
                  list( INSERT CMAKE_MODULE_PATH 0 "${_TMP_MULLE__MUSL_DIR}")
                  #
                  include( "${_TMP_MULLE__MUSL_DIR}/DependenciesAndLibraries.cmake" OPTIONAL)
                  #
                  list( REMOVE_ITEM CMAKE_MODULE_PATH "${_TMP_MULLE__MUSL_DIR}")
                  #
                  unset( MULLE__MUSL_DEFINITIONS)
                  include( "${_TMP_MULLE__MUSL_DIR}/Definitions.cmake" OPTIONAL)
                  list( APPEND INHERITED_DEFINITIONS ${MULLE__MUSL_DEFINITIONS})
                  break()
               else()
                  message( STATUS "${_TMP_MULLE__MUSL_DIR} not found")
               endif()
            endforeach()
         else()
            # Disable with: `mulle-sourcetree mark mulle-musl no-require-link`
            message( SEND_ERROR "MULLE__MUSL_LIBRARY was not found")
         endif()
      endif()
   endif()
endif()


#
# Generated from sourcetree: 5C7B0A16-98BA-4D02-90ED-FAD925D8C216;Foundation;no-singlephase;
# Disable with : `mulle-sourcetree mark Foundation no-link`
# Disable for this platform: `mulle-sourcetree mark Foundation no-cmake-platform-${MULLE_UNAME}`
# Disable for a sdk: `mulle-sourcetree mark Foundation no-cmake-sdk-<name>`
#
if( COLLECT_ALL_LOAD_DEPENDENCY_LIBRARIES_AS_NAMES)
   list( APPEND ALL_LOAD_DEPENDENCY_LIBRARIES "Foundation")
else()
   if( NOT FOUNDATION_LIBRARY)
      find_library( FOUNDATION_LIBRARY NAMES
         ${CMAKE_STATIC_LIBRARY_PREFIX}Foundation${CMAKE_DEBUG_POSTFIX}${CMAKE_STATIC_LIBRARY_SUFFIX}
         ${CMAKE_STATIC_LIBRARY_PREFIX}Foundation${CMAKE_STATIC_LIBRARY_SUFFIX}
         Foundation
         NO_CMAKE_SYSTEM_PATH NO_SYSTEM_ENVIRONMENT_PATH
      )
      if( NOT FOUNDATION_LIBRARY AND NOT DEPENDENCY_IGNORE_SYSTEM_LIBARIES)
         find_library( FOUNDATION_LIBRARY NAMES
            ${CMAKE_STATIC_LIBRARY_PREFIX}Foundation${CMAKE_DEBUG_POSTFIX}${CMAKE_STATIC_LIBRARY_SUFFIX}
            ${CMAKE_STATIC_LIBRARY_PREFIX}Foundation${CMAKE_STATIC_LIBRARY_SUFFIX}
            Foundation
         )
      endif()
      message( STATUS "FOUNDATION_LIBRARY is ${FOUNDATION_LIBRARY}")
      #
      # The order looks ascending, but due to the way this file is read
      # it ends up being descending, which is what we need.
      #
      if( FOUNDATION_LIBRARY)
         #
         # Add FOUNDATION_LIBRARY to ALL_LOAD_DEPENDENCY_LIBRARIES list.
         # Disable with: `mulle-sourcetree mark Foundation no-cmake-add`
         #
         list( APPEND ALL_LOAD_DEPENDENCY_LIBRARIES ${FOUNDATION_LIBRARY})
         #
         # Inherit information from dependency.
         # Encompasses: no-cmake-searchpath,no-cmake-dependency,no-cmake-loader
         # Disable with: `mulle-sourcetree mark Foundation no-cmake-inherit`
         #
         # temporarily expand CMAKE_MODULE_PATH
         get_filename_component( _TMP_FOUNDATION_ROOT "${FOUNDATION_LIBRARY}" DIRECTORY)
         get_filename_component( _TMP_FOUNDATION_ROOT "${_TMP_FOUNDATION_ROOT}" DIRECTORY)
         #
         #
         # Search for "Definitions.cmake" and "DependenciesAndLibraries.cmake" to include.
         # Disable with: `mulle-sourcetree mark Foundation no-cmake-dependency`
         #
         foreach( _TMP_FOUNDATION_NAME "Foundation")
            set( _TMP_FOUNDATION_DIR "${_TMP_FOUNDATION_ROOT}/include/${_TMP_FOUNDATION_NAME}/cmake")
            # use explicit path to avoid "surprises"
            if( IS_DIRECTORY "${_TMP_FOUNDATION_DIR}")
               list( INSERT CMAKE_MODULE_PATH 0 "${_TMP_FOUNDATION_DIR}")
               #
               include( "${_TMP_FOUNDATION_DIR}/DependenciesAndLibraries.cmake" OPTIONAL)
               #
               list( REMOVE_ITEM CMAKE_MODULE_PATH "${_TMP_FOUNDATION_DIR}")
               #
               unset( FOUNDATION_DEFINITIONS)
               include( "${_TMP_FOUNDATION_DIR}/Definitions.cmake" OPTIONAL)
               list( APPEND INHERITED_DEFINITIONS ${FOUNDATION_DEFINITIONS})
               break()
            else()
               message( STATUS "${_TMP_FOUNDATION_DIR} not found")
            endif()
         endforeach()
         #
         # Search for "MulleObjCLoader+<name>.h" in include directory.
         # Disable with: `mulle-sourcetree mark Foundation no-cmake-loader`
         #
         if( NOT NO_INHERIT_OBJC_LOADERS)
            foreach( _TMP_FOUNDATION_NAME "Foundation")
               set( _TMP_FOUNDATION_FILE "${_TMP_FOUNDATION_ROOT}/include/${_TMP_FOUNDATION_NAME}/MulleObjCLoader+${_TMP_FOUNDATION_NAME}.h")
               if( EXISTS "${_TMP_FOUNDATION_FILE}")
                  list( APPEND INHERITED_OBJC_LOADERS ${_TMP_FOUNDATION_FILE})
                  break()
               endif()
            endforeach()
         endif()
      else()
         # Disable with: `mulle-sourcetree mark Foundation no-require-link`
         message( SEND_ERROR "FOUNDATION_LIBRARY was not found")
      endif()
   endif()
endif()


#
# Generated from sourcetree: A7F3F89B-BF3E-4326-994A-DA5BFF120CB7;Foundation-startup;no-dynamic-link,no-header,no-intermediate-link;
# Disable with : `mulle-sourcetree mark Foundation-startup no-link`
# Disable for this platform: `mulle-sourcetree mark Foundation-startup no-cmake-platform-${MULLE_UNAME}`
# Disable for a sdk: `mulle-sourcetree mark Foundation-startup no-cmake-sdk-<name>`
#
if( COLLECT_STARTUP_ALL_LOAD_DEPENDENCY_LIBRARIES_AS_NAMES)
   list( APPEND STARTUP_ALL_LOAD_DEPENDENCY_LIBRARIES "Foundation-startup")
else()
   if( NOT FOUNDATION__STARTUP_LIBRARY)
      find_library( FOUNDATION__STARTUP_LIBRARY NAMES
         ${CMAKE_STATIC_LIBRARY_PREFIX}Foundation-startup${CMAKE_DEBUG_POSTFIX}${CMAKE_STATIC_LIBRARY_SUFFIX}
         ${CMAKE_STATIC_LIBRARY_PREFIX}Foundation-startup${CMAKE_STATIC_LIBRARY_SUFFIX}
         NO_CMAKE_SYSTEM_PATH NO_SYSTEM_ENVIRONMENT_PATH
      )
      if( NOT FOUNDATION__STARTUP_LIBRARY AND NOT DEPENDENCY_IGNORE_SYSTEM_LIBARIES)
         find_library( FOUNDATION__STARTUP_LIBRARY NAMES
            ${CMAKE_STATIC_LIBRARY_PREFIX}Foundation-startup${CMAKE_DEBUG_POSTFIX}${CMAKE_STATIC_LIBRARY_SUFFIX}
            ${CMAKE_STATIC_LIBRARY_PREFIX}Foundation-startup${CMAKE_STATIC_LIBRARY_SUFFIX}
         )
      endif()
      message( STATUS "FOUNDATION__STARTUP_LIBRARY is ${FOUNDATION__STARTUP_LIBRARY}")
      #
      # The order looks ascending, but due to the way this file is read
      # it ends up being descending, which is what we need.
      #
      if( FOUNDATION__STARTUP_LIBRARY)
         #
         # Add FOUNDATION__STARTUP_LIBRARY to STARTUP_ALL_LOAD_DEPENDENCY_LIBRARIES list.
         # Disable with: `mulle-sourcetree mark Foundation-startup no-cmake-add`
         #
         list( APPEND STARTUP_ALL_LOAD_DEPENDENCY_LIBRARIES ${FOUNDATION__STARTUP_LIBRARY})
         #
         # Inherit information from dependency.
         # Encompasses: no-cmake-searchpath,no-cmake-dependency,no-cmake-loader
         # Disable with: `mulle-sourcetree mark Foundation-startup no-cmake-inherit`
         #
         # temporarily expand CMAKE_MODULE_PATH
         get_filename_component( _TMP_FOUNDATION__STARTUP_ROOT "${FOUNDATION__STARTUP_LIBRARY}" DIRECTORY)
         get_filename_component( _TMP_FOUNDATION__STARTUP_ROOT "${_TMP_FOUNDATION__STARTUP_ROOT}" DIRECTORY)
         #
         #
         # Search for "Definitions.cmake" and "DependenciesAndLibraries.cmake" to include.
         # Disable with: `mulle-sourcetree mark Foundation-startup no-cmake-dependency`
         #
         foreach( _TMP_FOUNDATION__STARTUP_NAME "Foundation-startup")
            set( _TMP_FOUNDATION__STARTUP_DIR "${_TMP_FOUNDATION__STARTUP_ROOT}/include/${_TMP_FOUNDATION__STARTUP_NAME}/cmake")
            # use explicit path to avoid "surprises"
            if( IS_DIRECTORY "${_TMP_FOUNDATION__STARTUP_DIR}")
               list( INSERT CMAKE_MODULE_PATH 0 "${_TMP_FOUNDATION__STARTUP_DIR}")
               #
               include( "${_TMP_FOUNDATION__STARTUP_DIR}/DependenciesAndLibraries.cmake" OPTIONAL)
               #
               list( REMOVE_ITEM CMAKE_MODULE_PATH "${_TMP_FOUNDATION__STARTUP_DIR}")
               #
               unset( FOUNDATION__STARTUP_DEFINITIONS)
               include( "${_TMP_FOUNDATION__STARTUP_DIR}/Definitions.cmake" OPTIONAL)
               list( APPEND INHERITED_DEFINITIONS ${FOUNDATION__STARTUP_DEFINITIONS})
               break()
            else()
               message( STATUS "${_TMP_FOUNDATION__STARTUP_DIR} not found")
            endif()
         endforeach()
         #
         # Search for "MulleObjCLoader+<name>.h" in include directory.
         # Disable with: `mulle-sourcetree mark Foundation-startup no-cmake-loader`
         #
         if( NOT NO_INHERIT_OBJC_LOADERS)
            foreach( _TMP_FOUNDATION__STARTUP_NAME "Foundation-startup")
               set( _TMP_FOUNDATION__STARTUP_FILE "${_TMP_FOUNDATION__STARTUP_ROOT}/include/${_TMP_FOUNDATION__STARTUP_NAME}/MulleObjCLoader+${_TMP_FOUNDATION__STARTUP_NAME}.h")
               if( EXISTS "${_TMP_FOUNDATION__STARTUP_FILE}")
                  list( APPEND INHERITED_OBJC_LOADERS ${_TMP_FOUNDATION__STARTUP_FILE})
                  break()
               endif()
            endforeach()
         endif()
      else()
         # Disable with: `mulle-sourcetree mark Foundation-startup no-require-link`
         message( SEND_ERROR "FOUNDATION__STARTUP_LIBRARY was not found")
      endif()
   endif()
endif()


#
# Generated from sourcetree: 671DBE4D-4DB4-4AE9-AA29-C96136355B21;MulleHoedown;no-singlephase;
# Disable with : `mulle-sourcetree mark MulleHoedown no-link`
# Disable for this platform: `mulle-sourcetree mark MulleHoedown no-cmake-platform-${MULLE_UNAME}`
# Disable for a sdk: `mulle-sourcetree mark MulleHoedown no-cmake-sdk-<name>`
#
if( COLLECT_ALL_LOAD_DEPENDENCY_LIBRARIES_AS_NAMES)
   list( APPEND ALL_LOAD_DEPENDENCY_LIBRARIES "MulleHoedown")
else()
   if( NOT MULLE_HOEDOWN_LIBRARY)
      find_library( MULLE_HOEDOWN_LIBRARY NAMES
         ${CMAKE_STATIC_LIBRARY_PREFIX}MulleHoedown${CMAKE_DEBUG_POSTFIX}${CMAKE_STATIC_LIBRARY_SUFFIX}
         ${CMAKE_STATIC_LIBRARY_PREFIX}MulleHoedown${CMAKE_STATIC_LIBRARY_SUFFIX}
         MulleHoedown
         NO_CMAKE_SYSTEM_PATH NO_SYSTEM_ENVIRONMENT_PATH
      )
      if( NOT MULLE_HOEDOWN_LIBRARY AND NOT DEPENDENCY_IGNORE_SYSTEM_LIBARIES)
         find_library( MULLE_HOEDOWN_LIBRARY NAMES
            ${CMAKE_STATIC_LIBRARY_PREFIX}MulleHoedown${CMAKE_DEBUG_POSTFIX}${CMAKE_STATIC_LIBRARY_SUFFIX}
            ${CMAKE_STATIC_LIBRARY_PREFIX}MulleHoedown${CMAKE_STATIC_LIBRARY_SUFFIX}
            MulleHoedown
         )
      endif()
      message( STATUS "MULLE_HOEDOWN_LIBRARY is ${MULLE_HOEDOWN_LIBRARY}")
      #
      # The order looks ascending, but due to the way this file is read
      # it ends up being descending, which is what we need.
      #
      if( MULLE_HOEDOWN_LIBRARY)
         #
         # Add MULLE_HOEDOWN_LIBRARY to ALL_LOAD_DEPENDENCY_LIBRARIES list.
         # Disable with: `mulle-sourcetree mark MulleHoedown no-cmake-add`
         #
         list( APPEND ALL_LOAD_DEPENDENCY_LIBRARIES ${MULLE_HOEDOWN_LIBRARY})
         #
         # Inherit information from dependency.
         # Encompasses: no-cmake-searchpath,no-cmake-dependency,no-cmake-loader
         # Disable with: `mulle-sourcetree mark MulleHoedown no-cmake-inherit`
         #
         # temporarily expand CMAKE_MODULE_PATH
         get_filename_component( _TMP_MULLE_HOEDOWN_ROOT "${MULLE_HOEDOWN_LIBRARY}" DIRECTORY)
         get_filename_component( _TMP_MULLE_HOEDOWN_ROOT "${_TMP_MULLE_HOEDOWN_ROOT}" DIRECTORY)
         #
         #
         # Search for "Definitions.cmake" and "DependenciesAndLibraries.cmake" to include.
         # Disable with: `mulle-sourcetree mark MulleHoedown no-cmake-dependency`
         #
         foreach( _TMP_MULLE_HOEDOWN_NAME "MulleHoedown")
            set( _TMP_MULLE_HOEDOWN_DIR "${_TMP_MULLE_HOEDOWN_ROOT}/include/${_TMP_MULLE_HOEDOWN_NAME}/cmake")
            # use explicit path to avoid "surprises"
            if( IS_DIRECTORY "${_TMP_MULLE_HOEDOWN_DIR}")
               list( INSERT CMAKE_MODULE_PATH 0 "${_TMP_MULLE_HOEDOWN_DIR}")
               #
               include( "${_TMP_MULLE_HOEDOWN_DIR}/DependenciesAndLibraries.cmake" OPTIONAL)
               #
               list( REMOVE_ITEM CMAKE_MODULE_PATH "${_TMP_MULLE_HOEDOWN_DIR}")
               #
               unset( MULLE_HOEDOWN_DEFINITIONS)
               include( "${_TMP_MULLE_HOEDOWN_DIR}/Definitions.cmake" OPTIONAL)
               list( APPEND INHERITED_DEFINITIONS ${MULLE_HOEDOWN_DEFINITIONS})
               break()
            else()
               message( STATUS "${_TMP_MULLE_HOEDOWN_DIR} not found")
            endif()
         endforeach()
         #
         # Search for "MulleObjCLoader+<name>.h" in include directory.
         # Disable with: `mulle-sourcetree mark MulleHoedown no-cmake-loader`
         #
         if( NOT NO_INHERIT_OBJC_LOADERS)
            foreach( _TMP_MULLE_HOEDOWN_NAME "MulleHoedown")
               set( _TMP_MULLE_HOEDOWN_FILE "${_TMP_MULLE_HOEDOWN_ROOT}/include/${_TMP_MULLE_HOEDOWN_NAME}/MulleObjCLoader+${_TMP_MULLE_HOEDOWN_NAME}.h")
               if( EXISTS "${_TMP_MULLE_HOEDOWN_FILE}")
                  list( APPEND INHERITED_OBJC_LOADERS ${_TMP_MULLE_HOEDOWN_FILE})
                  break()
               endif()
            endforeach()
         endif()
      else()
         # Disable with: `mulle-sourcetree mark MulleHoedown no-require-link`
         message( SEND_ERROR "MULLE_HOEDOWN_LIBRARY was not found")
      endif()
   endif()
endif()


#
# Generated from sourcetree: D7FD831D-5E53-4BFD-B938-BC6C546A4D62;MulleWebServer;no-singlephase;
# Disable with : `mulle-sourcetree mark MulleWebServer no-link`
# Disable for this platform: `mulle-sourcetree mark MulleWebServer no-cmake-platform-${MULLE_UNAME}`
# Disable for a sdk: `mulle-sourcetree mark MulleWebServer no-cmake-sdk-<name>`
#
if( COLLECT_ALL_LOAD_DEPENDENCY_LIBRARIES_AS_NAMES)
   list( APPEND ALL_LOAD_DEPENDENCY_LIBRARIES "MulleWebServer")
else()
   if( NOT MULLE_WEB_SERVER_LIBRARY)
      find_library( MULLE_WEB_SERVER_LIBRARY NAMES
         ${CMAKE_STATIC_LIBRARY_PREFIX}MulleWebServer${CMAKE_DEBUG_POSTFIX}${CMAKE_STATIC_LIBRARY_SUFFIX}
         ${CMAKE_STATIC_LIBRARY_PREFIX}MulleWebServer${CMAKE_STATIC_LIBRARY_SUFFIX}
         MulleWebServer
         NO_CMAKE_SYSTEM_PATH NO_SYSTEM_ENVIRONMENT_PATH
      )
      if( NOT MULLE_WEB_SERVER_LIBRARY AND NOT DEPENDENCY_IGNORE_SYSTEM_LIBARIES)
         find_library( MULLE_WEB_SERVER_LIBRARY NAMES
            ${CMAKE_STATIC_LIBRARY_PREFIX}MulleWebServer${CMAKE_DEBUG_POSTFIX}${CMAKE_STATIC_LIBRARY_SUFFIX}
            ${CMAKE_STATIC_LIBRARY_PREFIX}MulleWebServer${CMAKE_STATIC_LIBRARY_SUFFIX}
            MulleWebServer
         )
      endif()
      message( STATUS "MULLE_WEB_SERVER_LIBRARY is ${MULLE_WEB_SERVER_LIBRARY}")
      #
      # The order looks ascending, but due to the way this file is read
      # it ends up being descending, which is what we need.
      #
      if( MULLE_WEB_SERVER_LIBRARY)
         #
         # Add MULLE_WEB_SERVER_LIBRARY to ALL_LOAD_DEPENDENCY_LIBRARIES list.
         # Disable with: `mulle-sourcetree mark MulleWebServer no-cmake-add`
         #
         list( APPEND ALL_LOAD_DEPENDENCY_LIBRARIES ${MULLE_WEB_SERVER_LIBRARY})
         #
         # Inherit information from dependency.
         # Encompasses: no-cmake-searchpath,no-cmake-dependency,no-cmake-loader
         # Disable with: `mulle-sourcetree mark MulleWebServer no-cmake-inherit`
         #
         # temporarily expand CMAKE_MODULE_PATH
         get_filename_component( _TMP_MULLE_WEB_SERVER_ROOT "${MULLE_WEB_SERVER_LIBRARY}" DIRECTORY)
         get_filename_component( _TMP_MULLE_WEB_SERVER_ROOT "${_TMP_MULLE_WEB_SERVER_ROOT}" DIRECTORY)
         #
         #
         # Search for "Definitions.cmake" and "DependenciesAndLibraries.cmake" to include.
         # Disable with: `mulle-sourcetree mark MulleWebServer no-cmake-dependency`
         #
         foreach( _TMP_MULLE_WEB_SERVER_NAME "MulleWebServer")
            set( _TMP_MULLE_WEB_SERVER_DIR "${_TMP_MULLE_WEB_SERVER_ROOT}/include/${_TMP_MULLE_WEB_SERVER_NAME}/cmake")
            # use explicit path to avoid "surprises"
            if( IS_DIRECTORY "${_TMP_MULLE_WEB_SERVER_DIR}")
               list( INSERT CMAKE_MODULE_PATH 0 "${_TMP_MULLE_WEB_SERVER_DIR}")
               #
               include( "${_TMP_MULLE_WEB_SERVER_DIR}/DependenciesAndLibraries.cmake" OPTIONAL)
               #
               list( REMOVE_ITEM CMAKE_MODULE_PATH "${_TMP_MULLE_WEB_SERVER_DIR}")
               #
               unset( MULLE_WEB_SERVER_DEFINITIONS)
               include( "${_TMP_MULLE_WEB_SERVER_DIR}/Definitions.cmake" OPTIONAL)
               list( APPEND INHERITED_DEFINITIONS ${MULLE_WEB_SERVER_DEFINITIONS})
               break()
            else()
               message( STATUS "${_TMP_MULLE_WEB_SERVER_DIR} not found")
            endif()
         endforeach()
         #
         # Search for "MulleObjCLoader+<name>.h" in include directory.
         # Disable with: `mulle-sourcetree mark MulleWebServer no-cmake-loader`
         #
         if( NOT NO_INHERIT_OBJC_LOADERS)
            foreach( _TMP_MULLE_WEB_SERVER_NAME "MulleWebServer")
               set( _TMP_MULLE_WEB_SERVER_FILE "${_TMP_MULLE_WEB_SERVER_ROOT}/include/${_TMP_MULLE_WEB_SERVER_NAME}/MulleObjCLoader+${_TMP_MULLE_WEB_SERVER_NAME}.h")
               if( EXISTS "${_TMP_MULLE_WEB_SERVER_FILE}")
                  list( APPEND INHERITED_OBJC_LOADERS ${_TMP_MULLE_WEB_SERVER_FILE})
                  break()
               endif()
            endforeach()
         endif()
      else()
         # Disable with: `mulle-sourcetree mark MulleWebServer no-require-link`
         message( SEND_ERROR "MULLE_WEB_SERVER_LIBRARY was not found")
      endif()
   endif()
endif()


#
# Generated from sourcetree: CE994F9D-CBD0-4CA9-BC81-96B12D0BBB69;MulleScion;no-singlephase;
# Disable with : `mulle-sourcetree mark MulleScion no-link`
# Disable for this platform: `mulle-sourcetree mark MulleScion no-cmake-platform-${MULLE_UNAME}`
# Disable for a sdk: `mulle-sourcetree mark MulleScion no-cmake-sdk-<name>`
#
if( COLLECT_ALL_LOAD_DEPENDENCY_LIBRARIES_AS_NAMES)
   list( APPEND ALL_LOAD_DEPENDENCY_LIBRARIES "MulleScion")
else()
   if( NOT MULLE_SCION_LIBRARY)
      find_library( MULLE_SCION_LIBRARY NAMES
         ${CMAKE_STATIC_LIBRARY_PREFIX}MulleScion${CMAKE_DEBUG_POSTFIX}${CMAKE_STATIC_LIBRARY_SUFFIX}
         ${CMAKE_STATIC_LIBRARY_PREFIX}MulleScion${CMAKE_STATIC_LIBRARY_SUFFIX}
         MulleScion
         NO_CMAKE_SYSTEM_PATH NO_SYSTEM_ENVIRONMENT_PATH
      )
      if( NOT MULLE_SCION_LIBRARY AND NOT DEPENDENCY_IGNORE_SYSTEM_LIBARIES)
         find_library( MULLE_SCION_LIBRARY NAMES
            ${CMAKE_STATIC_LIBRARY_PREFIX}MulleScion${CMAKE_DEBUG_POSTFIX}${CMAKE_STATIC_LIBRARY_SUFFIX}
            ${CMAKE_STATIC_LIBRARY_PREFIX}MulleScion${CMAKE_STATIC_LIBRARY_SUFFIX}
            MulleScion
         )
      endif()
      message( STATUS "MULLE_SCION_LIBRARY is ${MULLE_SCION_LIBRARY}")
      #
      # The order looks ascending, but due to the way this file is read
      # it ends up being descending, which is what we need.
      #
      if( MULLE_SCION_LIBRARY)
         #
         # Add MULLE_SCION_LIBRARY to ALL_LOAD_DEPENDENCY_LIBRARIES list.
         # Disable with: `mulle-sourcetree mark MulleScion no-cmake-add`
         #
         list( APPEND ALL_LOAD_DEPENDENCY_LIBRARIES ${MULLE_SCION_LIBRARY})
         #
         # Inherit information from dependency.
         # Encompasses: no-cmake-searchpath,no-cmake-dependency,no-cmake-loader
         # Disable with: `mulle-sourcetree mark MulleScion no-cmake-inherit`
         #
         # temporarily expand CMAKE_MODULE_PATH
         get_filename_component( _TMP_MULLE_SCION_ROOT "${MULLE_SCION_LIBRARY}" DIRECTORY)
         get_filename_component( _TMP_MULLE_SCION_ROOT "${_TMP_MULLE_SCION_ROOT}" DIRECTORY)
         #
         #
         # Search for "Definitions.cmake" and "DependenciesAndLibraries.cmake" to include.
         # Disable with: `mulle-sourcetree mark MulleScion no-cmake-dependency`
         #
         foreach( _TMP_MULLE_SCION_NAME "MulleScion")
            set( _TMP_MULLE_SCION_DIR "${_TMP_MULLE_SCION_ROOT}/include/${_TMP_MULLE_SCION_NAME}/cmake")
            # use explicit path to avoid "surprises"
            if( IS_DIRECTORY "${_TMP_MULLE_SCION_DIR}")
               list( INSERT CMAKE_MODULE_PATH 0 "${_TMP_MULLE_SCION_DIR}")
               #
               include( "${_TMP_MULLE_SCION_DIR}/DependenciesAndLibraries.cmake" OPTIONAL)
               #
               list( REMOVE_ITEM CMAKE_MODULE_PATH "${_TMP_MULLE_SCION_DIR}")
               #
               unset( MULLE_SCION_DEFINITIONS)
               include( "${_TMP_MULLE_SCION_DIR}/Definitions.cmake" OPTIONAL)
               list( APPEND INHERITED_DEFINITIONS ${MULLE_SCION_DEFINITIONS})
               break()
            else()
               message( STATUS "${_TMP_MULLE_SCION_DIR} not found")
            endif()
         endforeach()
         #
         # Search for "MulleObjCLoader+<name>.h" in include directory.
         # Disable with: `mulle-sourcetree mark MulleScion no-cmake-loader`
         #
         if( NOT NO_INHERIT_OBJC_LOADERS)
            foreach( _TMP_MULLE_SCION_NAME "MulleScion")
               set( _TMP_MULLE_SCION_FILE "${_TMP_MULLE_SCION_ROOT}/include/${_TMP_MULLE_SCION_NAME}/MulleObjCLoader+${_TMP_MULLE_SCION_NAME}.h")
               if( EXISTS "${_TMP_MULLE_SCION_FILE}")
                  list( APPEND INHERITED_OBJC_LOADERS ${_TMP_MULLE_SCION_FILE})
                  break()
               endif()
            endforeach()
         endif()
      else()
         # Disable with: `mulle-sourcetree mark MulleScion no-require-link`
         message( SEND_ERROR "MULLE_SCION_LIBRARY was not found")
      endif()
   endif()
endif()


#
# Generated from sourcetree: 3CD88D41-82EB-4B51-B024-CE0844B782F3;MulleBashStringExpansion;no-singlephase;
# Disable with : `mulle-sourcetree mark MulleBashStringExpansion no-link`
# Disable for this platform: `mulle-sourcetree mark MulleBashStringExpansion no-cmake-platform-${MULLE_UNAME}`
# Disable for a sdk: `mulle-sourcetree mark MulleBashStringExpansion no-cmake-sdk-<name>`
#
if( COLLECT_ALL_LOAD_DEPENDENCY_LIBRARIES_AS_NAMES)
   list( APPEND ALL_LOAD_DEPENDENCY_LIBRARIES "MulleBashStringExpansion")
else()
   if( NOT MULLE_BASH_STRING_EXPANSION_LIBRARY)
      find_library( MULLE_BASH_STRING_EXPANSION_LIBRARY NAMES
         ${CMAKE_STATIC_LIBRARY_PREFIX}MulleBashStringExpansion${CMAKE_DEBUG_POSTFIX}${CMAKE_STATIC_LIBRARY_SUFFIX}
         ${CMAKE_STATIC_LIBRARY_PREFIX}MulleBashStringExpansion${CMAKE_STATIC_LIBRARY_SUFFIX}
         MulleBashStringExpansion
         NO_CMAKE_SYSTEM_PATH NO_SYSTEM_ENVIRONMENT_PATH
      )
      if( NOT MULLE_BASH_STRING_EXPANSION_LIBRARY AND NOT DEPENDENCY_IGNORE_SYSTEM_LIBARIES)
         find_library( MULLE_BASH_STRING_EXPANSION_LIBRARY NAMES
            ${CMAKE_STATIC_LIBRARY_PREFIX}MulleBashStringExpansion${CMAKE_DEBUG_POSTFIX}${CMAKE_STATIC_LIBRARY_SUFFIX}
            ${CMAKE_STATIC_LIBRARY_PREFIX}MulleBashStringExpansion${CMAKE_STATIC_LIBRARY_SUFFIX}
            MulleBashStringExpansion
         )
      endif()
      message( STATUS "MULLE_BASH_STRING_EXPANSION_LIBRARY is ${MULLE_BASH_STRING_EXPANSION_LIBRARY}")
      #
      # The order looks ascending, but due to the way this file is read
      # it ends up being descending, which is what we need.
      #
      if( MULLE_BASH_STRING_EXPANSION_LIBRARY)
         #
         # Add MULLE_BASH_STRING_EXPANSION_LIBRARY to ALL_LOAD_DEPENDENCY_LIBRARIES list.
         # Disable with: `mulle-sourcetree mark MulleBashStringExpansion no-cmake-add`
         #
         list( APPEND ALL_LOAD_DEPENDENCY_LIBRARIES ${MULLE_BASH_STRING_EXPANSION_LIBRARY})
         #
         # Inherit information from dependency.
         # Encompasses: no-cmake-searchpath,no-cmake-dependency,no-cmake-loader
         # Disable with: `mulle-sourcetree mark MulleBashStringExpansion no-cmake-inherit`
         #
         # temporarily expand CMAKE_MODULE_PATH
         get_filename_component( _TMP_MULLE_BASH_STRING_EXPANSION_ROOT "${MULLE_BASH_STRING_EXPANSION_LIBRARY}" DIRECTORY)
         get_filename_component( _TMP_MULLE_BASH_STRING_EXPANSION_ROOT "${_TMP_MULLE_BASH_STRING_EXPANSION_ROOT}" DIRECTORY)
         #
         #
         # Search for "Definitions.cmake" and "DependenciesAndLibraries.cmake" to include.
         # Disable with: `mulle-sourcetree mark MulleBashStringExpansion no-cmake-dependency`
         #
         foreach( _TMP_MULLE_BASH_STRING_EXPANSION_NAME "MulleBashStringExpansion")
            set( _TMP_MULLE_BASH_STRING_EXPANSION_DIR "${_TMP_MULLE_BASH_STRING_EXPANSION_ROOT}/include/${_TMP_MULLE_BASH_STRING_EXPANSION_NAME}/cmake")
            # use explicit path to avoid "surprises"
            if( IS_DIRECTORY "${_TMP_MULLE_BASH_STRING_EXPANSION_DIR}")
               list( INSERT CMAKE_MODULE_PATH 0 "${_TMP_MULLE_BASH_STRING_EXPANSION_DIR}")
               #
               include( "${_TMP_MULLE_BASH_STRING_EXPANSION_DIR}/DependenciesAndLibraries.cmake" OPTIONAL)
               #
               list( REMOVE_ITEM CMAKE_MODULE_PATH "${_TMP_MULLE_BASH_STRING_EXPANSION_DIR}")
               #
               unset( MULLE_BASH_STRING_EXPANSION_DEFINITIONS)
               include( "${_TMP_MULLE_BASH_STRING_EXPANSION_DIR}/Definitions.cmake" OPTIONAL)
               list( APPEND INHERITED_DEFINITIONS ${MULLE_BASH_STRING_EXPANSION_DEFINITIONS})
               break()
            else()
               message( STATUS "${_TMP_MULLE_BASH_STRING_EXPANSION_DIR} not found")
            endif()
         endforeach()
         #
         # Search for "MulleObjCLoader+<name>.h" in include directory.
         # Disable with: `mulle-sourcetree mark MulleBashStringExpansion no-cmake-loader`
         #
         if( NOT NO_INHERIT_OBJC_LOADERS)
            foreach( _TMP_MULLE_BASH_STRING_EXPANSION_NAME "MulleBashStringExpansion")
               set( _TMP_MULLE_BASH_STRING_EXPANSION_FILE "${_TMP_MULLE_BASH_STRING_EXPANSION_ROOT}/include/${_TMP_MULLE_BASH_STRING_EXPANSION_NAME}/MulleObjCLoader+${_TMP_MULLE_BASH_STRING_EXPANSION_NAME}.h")
               if( EXISTS "${_TMP_MULLE_BASH_STRING_EXPANSION_FILE}")
                  list( APPEND INHERITED_OBJC_LOADERS ${_TMP_MULLE_BASH_STRING_EXPANSION_FILE})
                  break()
               endif()
            endforeach()
         endif()
      else()
         # Disable with: `mulle-sourcetree mark MulleBashStringExpansion no-require-link`
         message( SEND_ERROR "MULLE_BASH_STRING_EXPANSION_LIBRARY was not found")
      endif()
   endif()
endif()
