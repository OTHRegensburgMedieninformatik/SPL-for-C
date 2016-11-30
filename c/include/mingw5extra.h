/*
 * File: mingw5extra.h
 * ---------------
 * This file defines macros missing with MinGW/gcc 5.X
 */

#ifndef _MINGW5EXTRA_H
#define _MINGW5EXTRA_H  1
 
#if defined(__MINGW32__) && __GNUC__ >= 5

#ifdef __cplusplus
# define _EXTERN_C       extern "C"
# define _BEGIN_C_DECLS  extern "C" {
# define _END_C_DECLS    }
# define __CRT_INLINE    inline
#else
# define _EXTERN_C       extern
# define _BEGIN_C_DECLS
# define _END_C_DECLS

# if __GNUC_STDC_INLINE__
#  define __CRT_INLINE   extern inline __attribute__((__gnu_inline__))
# else
#  define __CRT_INLINE   extern __inline__
# endif
#endif

# ifdef __GNUC__
#  define  _CRTALIAS   __CRT_INLINE __attribute__((__always_inline__))
#  define __CRT_ALIAS  __CRT_INLINE __attribute__((__always_inline__))
# else
#  define  _CRTALIAS   __CRT_INLINE
#  define __CRT_ALIAS  __CRT_INLINE
# endif

#define __JMPSTUB__(__BUILD_HINT__)
#define __LIBIMPL__(__BUILD_HINT__)

#endif

#endif
