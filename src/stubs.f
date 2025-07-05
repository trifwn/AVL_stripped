C***********************************************************************
C    Module:  stubs.f
C 
C    Copyright (C) 2002 Mark Drela, Harold Youngren
C 
C    This program is free software; you can redistribute it and/or modify
C    it under the terms of the GNU General Public License as published by
C    the Free Software Foundation; either version 2 of the License, or
C    (at your option) any later version.
C
C    This program is distributed in the hope that it will be useful,
C    but WITHOUT ANY WARRANTY; without even the implied warranty of
C    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
C    GNU General Public License for more details.
C
C    You should have received a copy of the GNU General Public License
C    along with this program; if not, write to the Free Software
C    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
C***********************************************************************

C---- Stub routines for plotting-related functions that have been removed

      SUBROUTINE AXISADJ(A,B,C,D,E)
C     Stub for axis adjustment routine (plotting only)
      REAL A,B,C,D
      INTEGER E
      RETURN
      END

      SUBROUTINE CLRZOOM
C     Stub for clear zoom routine (plotting only)
      RETURN
      END

      SUBROUTINE PLEMAP(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P)
C     Stub for plot mapping routine (plotting only)
      REAL A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P
      RETURN
      END

      SUBROUTINE TETRAN(A,B,C,D)
C     Stub for transformation routine (plotting only)
      REAL A(3),B(3,3),C(3),D(3)
      RETURN
      END

      SUBROUTINE VIEWPROJ(A,B,C)
C     Stub for view projection routine (plotting only)
      REAL A(3,*)
      INTEGER B,C
      RETURN
      END

      FUNCTION GMAX()
C     Stub for GMAX function (plotting only)
      REAL GMAX
      GMAX = 0.0
      RETURN
      END

      FUNCTION GMIN()
C     Stub for GMIN function (plotting only)
      REAL GMIN
      GMIN = 0.0
      RETURN
      END 