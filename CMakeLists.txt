cmake_minimum_required( VERSION 3.1)

project( mulle-scion C)
add_definitions( -DMULLE_SCION_EXTERN_GLOBAL=extern)



### mulle-sde environment

# add cmake module paths to search path
list( INSERT CMAKE_MODULE_PATH 0 "${PROJECT_SOURCE_DIR}/cmake/share")
list( INSERT CMAKE_MODULE_PATH 0 "${PROJECT_SOURCE_DIR}/cmake/reflect")
list( INSERT CMAKE_MODULE_PATH 0 "${PROJECT_SOURCE_DIR}/cmake")

include( Environment)
include( Files)
include( Dependencies)

### Executable

# for some of the more funky filenames, cmake croaks so just copy the
# dox directory verbatim
set( RESOURCES)
set( INSTALL_MULLE_SCION_RESOURCE_DIRS dox)
if( CMAKE_INSTALL_PREFIX)
   set( TMP_PREFIX "${CMAKE_INSTALL_PREFIX}")
else()
   set( TMP_PREFIX "/usr/local")
endif()
add_definitions( -DINSTALL_PREFIX=\"${TMP_PREFIX}\")

include( Executable)
include( InstallExecutable)
include( FinalOutput OPTIONAL)

# only for Executable
include( Motd OPTIONAL)
