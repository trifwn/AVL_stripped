# Matrix solver library for AVL

# Matrix solver options
if(USE_LAPACK)
    if(BUILD_DOUBLE_PRECISION)
        set(MATRIX_SOURCE matrix-lapackdp.f)
    else()
        set(MATRIX_SOURCE matrix-lapack.f)
    endif()
    set(MATRIX_LIB matrix_lapack)
else()
    set(MATRIX_SOURCE matrix.f)
    set(MATRIX_LIB matrix_generic)
endif()

# Create the matrix library
add_library(${MATRIX_LIB} STATIC ${MATRIX_SOURCE})

# Set include directories
target_include_directories(${MATRIX_LIB} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# Set compile flags based on compiler
if(BUILD_DOUBLE_PRECISION)
    get_double_precision_flag(DP_FLAG)
    target_compile_options(${MATRIX_LIB} PRIVATE ${DP_FLAG})
endif()

# Install the library
install(TARGETS ${MATRIX_LIB} DESTINATION lib)

# Export the library name for use in parent CMakeLists.txt
set(MATRIX_LIBRARY ${MATRIX_LIB} PARENT_SCOPE) 