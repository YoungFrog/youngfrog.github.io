---
layout: post
title: "Édition vidéo pour les noobs tels que moi -- logiciels libres"
categories: informatique
# featured-image: 
# featured-source: 
summary: ""
---
## Comparaisons

Une vue comparative de kdenlive, openshot, shotcut & olive : https://www.youtube.com/watch?v=oWtsXXLIkgQ (c'est une comparaison sur des points spécifiques -- pas hyper pertinent pour moi ici -- mais on constate malgré tout qu'il y a de fortes ressemblances).

## blender

logiciel prévu pour du rendu 3D, mais peut faire de l'édition vidéo aussi

## kdenlive
## openshot
## shotcut

## [Olive Video Editor](https://www.olivevideoeditor.org/) -- licence GPLv3

j'ai suivi <https://www.olivevideoeditor.org/compile.php#ubuntu>

### configuration OpenColorIO

    $ cmake .. -G "Unix Makefiles" -DOCIO_BUILD_PYTHON=OFF
    -- The CXX compiler identification is GNU 9.3.0
    -- The C compiler identification is GNU 9.3.0
    -- Check for working CXX compiler: /usr/bin/c++
    -- Check for working CXX compiler: /usr/bin/c++ -- works
    -- Detecting CXX compiler ABI info
    -- Detecting CXX compiler ABI info - done
    -- Detecting CXX compile features
    -- Detecting CXX compile features - done
    -- Check for working C compiler: /usr/bin/cc
    -- Check for working C compiler: /usr/bin/cc -- works
    -- Detecting C compiler ABI info
    -- Detecting C compiler ABI info - done
    -- Detecting C compile features
    -- Detecting C compile features - done
    -- Setting build type to 'Release' as none was specified.
    -- Setting C++ version to '11' as none was specified.
    -- Performing Test COMPILER_SUPPORTS_CXX11
    -- Performing Test COMPILER_SUPPORTS_CXX11 - Success
    -- Performing Test COMPILER_SUPPORTS_CXX14
    -- Performing Test COMPILER_SUPPORTS_CXX14 - Success
    -- Performing Test COMPILER_SUPPORTS_CXX17
    -- Performing Test COMPILER_SUPPORTS_CXX17 - Success
    -- Found OpenGL: /usr/lib/x86_64-linux-gnu/libOpenGL.so  found components: OpenGL 
    -- Could NOT find GLEW (missing: GLEW_INCLUDE_DIRS GLEW_LIBRARIES) 
    -- Use "GLEW_ROOT" to specify an install location
    -- Could NOT find GLUT (missing: GLUT_glut_LIBRARY GLUT_INCLUDE_DIR) 
    -- Use "GLUT_ROOT" to specify an install location
    CMake Warning at share/cmake/utils/CheckSupportGL.cmake:47 (message):
      GPU rendering disabled
    Call Stack (most recent call first):
      CMakeLists.txt:143 (include)

    -- Performing Test HAVE_SSE2
    -- Performing Test HAVE_SSE2 - Success
    -- Setting SOVERSION to '2.0' as none was specified.
    -- Found expat: /usr/lib/x86_64-linux-gnu/libexpat.so (found suitable version "2.2.9", minimum required is "2.2.8") 
    -- Could NOT find yaml-cpp (missing: yaml-cpp_LIBRARY yaml-cpp_INCLUDE_DIR) (Required is at least version "0.6.3")
    -- Installing yaml-cpp: /home/youngfrog/sources-not-for-backup/OpenColorIO/build/ext/dist/lib/libyaml-cpp.a (version "0.6.3")
    -- Could NOT find Half: Found unsuitable version "2.3.0", but required is at least "2.4.0" (found /usr/lib/x86_64-linux-gnu/libHalf.so)
    -- Installing Half (IlmBase): /home/youngfrog/sources-not-for-backup/OpenColorIO/build/ext/dist/lib/libHalf-2_4.a (version "2.4.0")
    -- Could NOT find pystring (missing: pystring_INCLUDE_DIR pystring_LIBRARY) (Required is at least version "1.1.3")
    -- Installing pystring: /home/youngfrog/sources-not-for-backup/OpenColorIO/build/ext/dist/lib/libpystring.a (version "1.1.3")
    -- Found lcms2: /usr/include (found suitable version "2.9", minimum required is "2.2") 
    -- Found OpenImageIO: /usr/include (found suitable version "2.1.12.0", minimum required is "2.1.9") 
    -- OpenImageIO includes     = /usr/include
    -- OpenImageIO libraries    = /usr/lib/x86_64-linux-gnu/libOpenImageIO.so
    -- OpenImageIO library_dirs = /usr/lib/x86_64-linux-gnu
    -- OpenImageIO oiiotool     = OIIOTOOL_BIN-NOTFOUND
    CMake Warning at src/apps/ociochecklut/CMakeLists.txt:5 (message):
      GL component missing.  GPU disabled for ociochecklut.

    CMake Warning at src/apps/ocioconvert/CMakeLists.txt:5 (message):
      GL component missing.  GPU disabled for ocioconvert.

    CMake Warning at src/apps/ociodisplay/CMakeLists.txt:5 (message):
      GL component missing.  Skipping ociodisplay.

    CMake Warning at src/libutils/oglapphelpers/CMakeLists.txt:5 (message):
      GL component missing.  Skipping oglapphelpers.

    CMake Warning at tests/gpu/CMakeLists.txt:5 (message):
      GL component missing.  Skipping the GPU unit tests.

    -- Configuring done
    -- Generating done
    -- Build files have been written to: /home/youngfrog/sources-not-for-backup/OpenColorIO/build

pour OpenColorIO j'ai aussi installé
- libglew-dev
- freeglut3-dev
(probablement pas requis, mais j'imagine que ça fait pas de tort)

j'ai aussi installé libyaml-cpp-dev pour avoir yaml-cpp globalement (sinon OpenColorIO installe sa propre copie).
je n'ai pas  pu mettre à jour libHalf (du paquet libilmbase-dev) car mon Ubuntu ne contient pas la version requise 2.4.0 (j'ai juste la 2.3.0). 
Ce n'est pas grave, celui-là et pystring seront fournis par l'installeur de OpenColorIO.

J'ai lancé "sudo ldconfig" pour que ociodisplay trouve ses petits:

    ociodisplay: error while loading shared libraries: libOpenColorIO.so.2.0: cannot open shared object file: No such file or directory

### configuration olive

    $ cmake .. -DCMAKE_BUILD_TYPE=RelWithDebInfo 
    -- The CXX compiler identification is GNU 9.3.0
    -- Check for working CXX compiler: /usr/bin/c++
    -- Check for working CXX compiler: /usr/bin/c++ -- works
    -- Detecting CXX compiler ABI info
    -- Detecting CXX compiler ABI info - done
    -- Detecting CXX compile features
    -- Detecting CXX compile features - done
    -- Found OpenGL: /usr/lib/x86_64-linux-gnu/libOpenGL.so   
    -- Found OpenColorIO: /usr/local/lib/libOpenColorIO.so.2.0 (found suitable version "2.0.0", minimum required is "2.0.0") 
    -- Found OpenImageIO: /usr/lib/x86_64-linux-gnu/libOpenImageIO.so;/usr/lib/x86_64-linux-gnu/libOpenImageIO_Util.so (found suitable version "2.1.12", minimum required is "2.1.12") 
    -- Could NOT find Imath (missing: Imath_DIR)
    -- Could NOT find IlmBase (missing: IlmBase_DIR)
    -- Could NOT find OpenEXR (missing: OpenEXR_DIR)
    -- Found ZLIB: /usr/lib/x86_64-linux-gnu/libz.so (found version "1.2.11") 
    -- Looking for C++ include pthread.h
    -- Looking for C++ include pthread.h - found
    -- Performing Test CMAKE_HAVE_LIBC_PTHREAD
    -- Performing Test CMAKE_HAVE_LIBC_PTHREAD - Failed
    -- Looking for pthread_create in pthreads
    -- Looking for pthread_create in pthreads - not found
    -- Looking for pthread_create in pthread
    -- Looking for pthread_create in pthread - found
    -- Found Threads: TRUE  
    -- Found PkgConfig: /usr/bin/pkg-config (found version "0.29.1") 
    -- Found OpenEXR: /usr/include  
    -- Found FFMPEG: /usr/include/x86_64-linux-gnu (found suitable version "4.2.4-1ubuntu0.1", minimum required is "3.0") found components: avutil avcodec avformat avfilter swscale swresample 
    -- Could NOT find OpenTimelineIO (missing: OTIO_LIBRARIES OTIO_INCLUDE_DIRS OTIO_DEPS_INCLUDE_DIR) 
       OpenTimelineIO interchange will be disabled.
    -- Could NOT find GoogleCrashpad (missing: CRASHPAD_CLIENT_LIB CRASHPAD_UTIL_LIB CRASHPAD_BASE_LIB BREAKPAD_BIN_DIR CRASHPAD_BUILD_INCLUDE_DIR CRASHPAD_CLIENT_INCLUDE_DIR CRASHPAD_BASE_INCLUDE_DIR CRASHPAD_COMPAT_LIB) 
       Automatic crash reporting will be disabled.
    -- Found Git: /usr/bin/git (found version "2.25.1") 
    -- Configuring done
    -- Generating done
    -- Build files have been written to: /home/youngfrog/sources-not-for-backup/olive/build

Je pas sûr si Imath, IlmBase OpenEXR, OpenTimelineIO et GoogleCrashpad sont vraiments nécessaires. On verra bien si ça foire.
