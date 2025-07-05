# Machine Readable Format (MRF) library

# Source files
set(MRF_SOURCES
    src/avlRead_BODY.c
    src/avlRead_CNC.c
    src/avlRead_CPOML.c
    src/avlRead_DERMATB.c
    src/avlRead_DERMATM.c
    src/avlRead_DERMATS.c
    src/avlRead_ELE.c
    src/avlRead_STRP.c
    src/avlRead_SURF.c
    src/avlRead_HINGE.c
    src/avlRead_TOT.c
    src/avlRead_VM.c
)

# Create the library
add_library(avlmrf STATIC ${MRF_SOURCES})

# Set include directories
target_include_directories(avlmrf PUBLIC src)

# Set compile definitions
target_compile_definitions(avlmrf PRIVATE
    $<$<BOOL:${BUILD_DEBUG}>:DEBUG>
)

# Install the library
install(TARGETS avlmrf DESTINATION lib)

# Optional test executable
option(BUILD_MRF_TESTS "Build MRF tests" OFF)

if(BUILD_MRF_TESTS)
    add_executable(avlRead_test test/avlRead_test.c)
    target_include_directories(avlRead_test PRIVATE src)
    target_link_libraries(avlRead_test avlmrf)
    
    # Install test executable
    install(TARGETS avlRead_test DESTINATION bin)
endif() 