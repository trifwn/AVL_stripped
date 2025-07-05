cmake_minimum_required(VERSION 3.16)
project(AVL VERSION 3.40 LANGUAGES Fortran C)

# Set Fortran standard
set(CMAKE_Fortran_STANDARD 77)
set(CMAKE_Fortran_STANDARD_REQUIRED ON)

# Set C standard
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)

# Function to get compiler-specific double precision flag
function(get_double_precision_flag result)
    if(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")
        set(${result} "-fdefault-real-8" PARENT_SCOPE)
    elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "Intel")
        set(${result} "-r8" PARENT_SCOPE)
    elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "PGI")
        set(${result} "-r8" PARENT_SCOPE)
    elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "Cray")
        set(${result} "-s real64" PARENT_SCOPE)
    elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "NAG")
        set(${result} "-double" PARENT_SCOPE)
    else()
        set(${result} "-fdefault-real-8" PARENT_SCOPE)
        message(WARNING "Unknown Fortran compiler ${CMAKE_Fortran_COMPILER_ID}, using gfortran double precision flag")
    endif()
endfunction()

# Build options
option(BUILD_DOUBLE_PRECISION "Build with double precision" ON)
option(BUILD_STATIC "Build static executable" OFF)
option(BUILD_DEBUG "Build with debug flags" OFF)
option(USE_LAPACK "Use LAPACK for matrix operations" ON)
option(USE_INTEL_MKL "Use Intel Math Kernel Library" OFF)

# Set compiler flags based on options and compiler
if(BUILD_DEBUG)
    if(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")
        set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -O0 -g -fbounds-check -finit-real=inf")
    elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "Intel")
        set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -O0 -g -check bounds -check uninit")
    elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "PGI")
        set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -O0 -g -Mbounds -Mchkptr")
    else()
        set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -O0 -g")
    endif()
    
    if(CMAKE_C_COMPILER_ID STREQUAL "GNU")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O0 -g -pedantic -Wall -Wextra")
    elseif(CMAKE_C_COMPILER_ID STREQUAL "Clang")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O0 -g -Wall -Wextra")
    elseif(CMAKE_C_COMPILER_ID STREQUAL "Intel")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O0 -g -Wall")
    else()
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O0 -g")
    endif()
else()
    if(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")
        set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -O2 -march=native -ffast-math -static-libgcc -static-libgfortran -static-libquadmath")
    elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "Intel")
        set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -O2 -march=native -fast")
    elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "PGI")
        set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -O2 -march=native -fast")
    else()
        set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -O2")
    endif()
    
    if(CMAKE_C_COMPILER_ID STREQUAL "GNU")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O2 -march=native")
    elseif(CMAKE_C_COMPILER_ID STREQUAL "Clang")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O2 -march=native")
    elseif(CMAKE_C_COMPILER_ID STREQUAL "Intel")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O2 -march=native")
    else()
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O2 -march=native")
    endif()
endif()

if(BUILD_DOUBLE_PRECISION)
    get_double_precision_flag(DP_FLAG)
    set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${DP_FLAG}")
endif()

if(BUILD_STATIC)
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static")
endif()

# Architecture flags
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -m64")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -m64")
else()
    set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -m32")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -m32")
endif()

# Find required packages
find_package(LAPACK REQUIRED)

# Add subdirectories
add_subdirectory(eispack)
add_subdirectory(mrf)
add_subdirectory(src)

# Create the main AVL executable
add_executable(avl
    src/avl.f
    src/aoper.f
    src/amode.f
    src/amass.f
    src/asetup.f
    src/amake.f
    src/ainput.f
    src/aoutput.f
    src/aoutmrf.f
    src/aero.f
    src/atrim.f
    src/atpforc.f
    src/aic.f
    src/cdcl.f
    src/airutil.f
    src/autil.f
    src/aoml.f
    src/limits.f
    src/hidden.f
    src/userio.f
    src/getvm.f
    src/spline.f
    src/sgutil.f
    src/stubs.f
    src/second.f
)

# Set include directories
target_include_directories(avl PRIVATE src)

# Link libraries
if(BUILD_DOUBLE_PRECISION)
    target_link_libraries(avl 
        eispack_dp
        avlmrf
        ${MATRIX_LIBRARY}
        ${LAPACK_LIBRARIES}
    )
else()
    target_link_libraries(avl 
        eispack
        avlmrf
        ${MATRIX_LIBRARY}
        ${LAPACK_LIBRARIES}
    )
endif()

# Set compile definitions
target_compile_definitions(avl PRIVATE
    $<$<BOOL:${BUILD_DOUBLE_PRECISION}>:DOUBLE_PRECISION>
)

# Install target
install(TARGETS avl DESTINATION bin)

# Print configuration summary
message(STATUS "AVL Configuration:")
message(STATUS "  Version: ${PROJECT_VERSION}")
message(STATUS "  Double Precision: ${BUILD_DOUBLE_PRECISION}")
message(STATUS "  Static Build: ${BUILD_STATIC}")
message(STATUS "  Debug Build: ${BUILD_DEBUG}")
message(STATUS "  Use LAPACK: ${USE_LAPACK}")
message(STATUS "  Use Intel MKL: ${USE_INTEL_MKL}")
message(STATUS "  Fortran Compiler: ${CMAKE_Fortran_COMPILER}")
message(STATUS "  C Compiler: ${CMAKE_C_COMPILER}") 