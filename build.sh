#!/bin/bash

# AVL Build Script
# This script provides easy configuration and building of the AVL project

set -e

# Default values
BUILD_TYPE="Release"
BUILD_DIR="build"
INSTALL_DIR=""
DOUBLE_PRECISION=false
STATIC_BUILD=false
DEBUG_BUILD=false
USE_LAPACK=true
USE_INTEL_MKL=false
BUILD_MRF_TESTS=false

# Function to print usage
print_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -h, --help              Show this help message"
    echo "  -d, --debug             Build with debug flags"
    echo "  -D, --double-precision  Build with double precision"
    echo "  -s, --static            Build static executable"
    echo "  -t, --tests             Build MRF tests"
    echo "  -i, --install DIR       Install to directory DIR"
    echo "  -b, --build-dir DIR     Use build directory DIR (default: build)"
    echo "  --no-lapack             Don't use LAPACK (use generic matrix solver)"
    echo "  --intel-mkl             Use Intel Math Kernel Library"
    echo ""
    echo "Examples:"
    echo "  $0                      # Standard build"
    echo "  $0 -d                   # Debug build"
    echo "  $0 -D -s                # Double precision static build"
    echo "  $0 -i /usr/local        # Install to /usr/local"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            print_usage
            exit 0
            ;;
        -d|--debug)
            DEBUG_BUILD=true
            BUILD_TYPE="Debug"
            shift
            ;;
        -D|--double-precision)
            DOUBLE_PRECISION=true
            shift
            ;;
        -s|--static)
            STATIC_BUILD=true
            shift
            ;;
        -t|--tests)
            BUILD_MRF_TESTS=true
            shift
            ;;
        -i|--install)
            INSTALL_DIR="$2"
            shift 2
            ;;
        -b|--build-dir)
            BUILD_DIR="$2"
            shift 2
            ;;
        --no-lapack)
            USE_LAPACK=false
            shift
            ;;
        --intel-mkl)
            USE_INTEL_MKL=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            print_usage
            exit 1
            ;;
    esac
done

# Create build directory
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# Configure CMake
echo "Configuring AVL build..."
cmake .. \
    -DCMAKE_BUILD_TYPE="$BUILD_TYPE" \
    -DBUILD_DOUBLE_PRECISION="$DOUBLE_PRECISION" \
    -DBUILD_STATIC="$STATIC_BUILD" \
    -DBUILD_DEBUG="$DEBUG_BUILD" \
    -DUSE_LAPACK="$USE_LAPACK" \
    -DUSE_INTEL_MKL="$USE_INTEL_MKL" \
    -DBUILD_MRF_TESTS="$BUILD_MRF_TESTS" \
    ${INSTALL_DIR:+-DCMAKE_INSTALL_PREFIX="$INSTALL_DIR"}

# Build
echo "Building AVL..."
make -j$(nproc)

# Install if requested
if [[ -n "$INSTALL_DIR" ]]; then
    echo "Installing AVL to $INSTALL_DIR..."
    make install
fi

echo "Build completed successfully!"
echo "AVL executable is located in: $BUILD_DIR/avl" 