# AVL CMake Build System

This document describes how to build AVL using the new CMake build system.

## Prerequisites

- CMake 3.16 or higher
- Fortran compiler (gfortran, ifort, etc.)
- C compiler (gcc, clang, etc.)
- LAPACK and BLAS libraries

### Installing Prerequisites on macOS

```bash
# Using Homebrew
brew install cmake gcc lapack

# Using MacPorts
sudo port install cmake gcc9 lapack
```

### Installing Prerequisites on Ubuntu/Debian

```bash
sudo apt-get update
sudo apt-get install cmake gfortran gcc liblapack-dev libblas-dev
```

### Installing Prerequisites on CentOS/RHEL/Fedora

```bash
# CentOS/RHEL
sudo yum install cmake gcc-gfortran gcc lapack-devel blas-devel

# Fedora
sudo dnf install cmake gcc-gfortran gcc lapack-devel blas-devel
```

## Quick Start

### Using the Build Script (Recommended)

The easiest way to build AVL is using the provided build script:

```bash
# Standard build
./build.sh

# Debug build
./build.sh -d

# Double precision build
./build.sh -D

# Static build
./build.sh -s

# Install to system directory
./build.sh -i /usr/local

# Build with all options
./build.sh -d -D -s -i /usr/local
```

### Using CMake Directly

If you prefer to use CMake directly:

```bash
# Create build directory
mkdir build
cd build

# Configure
cmake ..

# Build
make

# Install (optional)
make install
```

## Build Options

### CMake Options

- `BUILD_DOUBLE_PRECISION`: Build with double precision (default: ON)
- `BUILD_STATIC`: Build static executable (default: OFF)
- `BUILD_DEBUG`: Build with debug flags (default: OFF)
- `USE_LAPACK`: Use LAPACK for matrix operations (default: ON)
- `USE_INTEL_MKL`: Use Intel Math Kernel Library (default: OFF)
- `BUILD_MRF_TESTS`: Build MRF tests (default: OFF)

### Build Script Options

- `-d, --debug`: Build with debug flags
- `-D, --double-precision`: Build with double precision
- `-s, --static`: Build static executable
- `-t, --tests`: Build MRF tests
- `-i, --install DIR`: Install to directory DIR
- `-b, --build-dir DIR`: Use build directory DIR (default: build)
- `--no-lapack`: Don't use LAPACK (use generic matrix solver)
- `--intel-mkl`: Use Intel Math Kernel Library

## Examples

### Standard Build
```bash
./build.sh
```

### Debug Build
```bash
./build.sh -d
```

### Double Precision Static Build
```bash
./build.sh -D -s
```

### Install to System Directory
```bash
./build.sh -i /usr/local
```

### Build Without LAPACK
```bash
./build.sh --no-lapack
```

### Custom Build Directory
```bash
./build.sh -b my_build_dir
```

## Project Structure

```
Avl/
├── CMakeLists.txt          # Main CMake configuration
├── build.sh               # Build script
├── eispack/
│   ├── CMakeLists.txt     # EISPACK library configuration
│   └── eispack.f          # EISPACK source
├── mrf/
│   ├── CMakeLists.txt     # MRF library configuration
│   ├── src/               # MRF source files
│   └── test/              # MRF tests
└── src/
    ├── CMakeLists.txt     # Matrix solver configuration
    └── *.f                # AVL source files
```

## Troubleshooting

### LAPACK Not Found
If CMake cannot find LAPACK, you may need to specify the path:

```bash
cmake .. -DLAPACK_LIBRARIES=/path/to/lapack
```

### Compiler Issues
If you have multiple Fortran compilers installed, you can specify which one to use:

```bash
cmake .. -DCMAKE_Fortran_COMPILER=gfortran
```

### Architecture Issues
The build system automatically detects 32-bit vs 64-bit architecture and sets appropriate flags. If you need to override this:

```bash
# Force 32-bit build
cmake .. -DCMAKE_Fortran_FLAGS="-m32" -DCMAKE_C_FLAGS="-m32"

# Force 64-bit build
cmake .. -DCMAKE_Fortran_FLAGS="-m64" -DCMAKE_C_FLAGS="-m64"
```

## Migration from Makefiles

The CMake build system replaces the following Makefiles:
- `bin/Makefile.gfortran`
- `bin/Makefile.ifort`
- `bin/Makefile.mingw`
- `eispack/Makefile.mingw`
- `mrf/Makefile.gcc`

All functionality from these Makefiles has been preserved in the CMake configuration.

## Benefits of CMake

1. **Cross-platform**: Works on Linux, macOS, and Windows
2. **Better dependency management**: Automatic LAPACK detection
3. **Flexible configuration**: Easy to add new build options
4. **IDE integration**: Works with Visual Studio, CLion, etc.
5. **Parallel builds**: Automatic parallel compilation
6. **Cleaner build**: Out-of-source builds
7. **Better error messages**: More informative compilation errors 