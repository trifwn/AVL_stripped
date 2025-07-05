# EISPACK library for eigenvalue computations

# Set source file based on precision
if(BUILD_DOUBLE_PRECISION)
    # Note: Double precision eispack file doesn't exist, using single precision with double precision flags
    set(EISPACK_SRC eispack.f)
    set(EISPACK_LIB eispack_dp)
else()
    set(EISPACK_SRC eispack.f)
    set(EISPACK_LIB eispack)
endif()

# Create the library
add_library(${EISPACK_LIB} STATIC ${EISPACK_SRC})

# Set include directories
target_include_directories(${EISPACK_LIB} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# Set compile flags based on compiler
if(BUILD_DOUBLE_PRECISION)
    get_double_precision_flag(DP_FLAG)
    target_compile_options(${EISPACK_LIB} PRIVATE ${DP_FLAG})
endif()

# Install the library
install(TARGETS ${EISPACK_LIB} DESTINATION lib) 