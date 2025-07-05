# AVL-stripped: Headless Fork of Mark Drela's AVL

This repository contains a modified version of **Mark Drela’s AVL (Athena Vortex Lattice)** with **all graphical/X11 plotting routines stripped**, resulting in a **lightweight, headless** executable suitable for:

- Server-side simulations
- Batch execution workflows
- Automated design loops
- Remote environments with no X11/display support

---

## 🔧 Features

- ✅ No X11 or graphical dependencies
- ✅ Clean command-line/batch mode operation
- ✅ Ideal for scripting and automation
- ✅ Produces the same numerical results as the original AVL
- ⚠️ Plotting windows and interactive graphics are **disabled/removed**

---

## 📦 Build Instructions

### 📌 Prerequisites

- GCC or Clang
- Make
- (Optional) `gfortran` if you wish to recompile any supporting Fortran code

### 🛠 Build

```bash
git clone https://github.com/YOUR-USERNAME/avl-noplot.git
cd avl-noplot
make
```


## 🚀 Usage

AVL operates entirely through standard input. Run it with a command script:

```bash
./avl < your_script.run
```

Example script:

```text
LOAD my_aircraft.avl
OPER
ASEQ 0 10 5
X
```

This will:
- Load the aircraft definition `my_aircraft.avl`
- Run an angle-of-attack sweep from 0° to 10° in 5 steps
- Exit the program

All results will be printed to the console or written to output files if specified in the script.

---

## 📂 Directory Structure

```
.
├── src/                # Modified AVL source files (C and Fortran)
├── Makefile            # Simplified makefile (no X11)
├── avl                 # Compiled binary (after build)
└── README.md           # You're here
```

---

## 📎 Notes

- Original AVL by Mark Drela: http://web.mit.edu/drela/Public/web/avl/
- This fork removes all dependencies and functions related to X11 plotting, including:
  - `X11/Xlib.h` references
  - Plot-related functions (`plotfoil`, `plotaxes`, etc.)
  - All interactive mouse/GUI handling

This version is **not intended for interactive use**. If you need visualization, use the original AVL or wrap the output in your own plotting tool.

---

## ⚖️ License

Original AVL is distributed with implicit academic/research usage rights. This fork retains those assumptions. No warranty is provided. Refer to the original AVL documentation for terms.

---

## 🙏 Credits

- AVL by **Mark Drela**, MIT
- Fork maintained by [YOUR NAME](https://github.com/YOUR-USERNAME)
```

---
