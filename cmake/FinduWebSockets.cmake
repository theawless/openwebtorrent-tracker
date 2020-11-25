include(FindPackageHandleStandardArgs)

# Dependencies
find_package(ZLIB REQUIRED)
find_package(uSockets REQUIRED)

# Get include dir
find_path(
	UWEBSOCKETS_INCLUDE_DIR
	NAMES "uWebSockets/src/App.h"
)

# Add library
file(GLOB_RECURSE UWS_H ${UWEBSOCKETS_INCLUDE_DIR}/uWebSockets/src/*.h)
file(GLOB_RECURSE UWS_C ${UWEBSOCKETS_INCLUDE_DIR}/uWebSockets/src/*.c)
file(GLOB_RECURSE UWS_HPP ${UWEBSOCKETS_INCLUDE_DIR}/uWebSockets/src/*.hpp)
file(GLOB_RECURSE UWS_CPP ${UWEBSOCKETS_INCLUDE_DIR}/uWebSockets/src/*.cpp)
add_library(uWebSockets STATIC
    ${UWS_H}
    ${UWS_C}
    ${UWS_HPP}
    ${UWS_CPP}
)
SET_TARGET_PROPERTIES(uWebSockets PROPERTIES LINKER_LANGUAGE CXX)

# Include and link
TARGET_INCLUDE_DIRECTORIES(uWebSockets PUBLIC
	${UWEBSOCKETS_INCLUDE_DIR}/uWebSockets/src
	${ZLIB_INCLUDE_DIRS}
	${USOCKETS_INCLUDE_DIR}
)
TARGET_LINK_LIBRARIES(uWebSockets PUBLIC
	${ZLIB_LIBRARIES}
	${USOCKETS_LIBRARIES}
)

# Vars
SET(UWEBSOCKETS_INCLUDE_DIR ${UWEBSOCKETS_INCLUDE_DIR}/uWebSockets/src)
SET(UWEBSOCKETS_LIBRARIES uWebSockets)

find_package_handle_standard_args(
	uWebSockets
	DEFAULT_MSG
	UWEBSOCKETS_INCLUDE_DIR
	UWEBSOCKETS_LIBRARIES
)

mark_as_advanced(
	UWEBSOCKETS_INCLUDE_DIR
	UWEBSOCKETS_LIBRARIES
)
