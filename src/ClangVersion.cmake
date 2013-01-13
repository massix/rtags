macro(ClangVersion path version)
  if("${path}/include/clang/Basic/Version.inc")
    file(READ "${path}/include/clang/Basic/Version.inc" CLANG_VERSION_DATA)
    string(REGEX REPLACE ";" "\\\\;" CLANG_VERSION_DATA ${CLANG_VERSION_DATA})
    string(REGEX REPLACE "\n" ";" CLANG_VERSION_DATA ${CLANG_VERSION_DATA})
    foreach(line ${CLANG_VERSION_DATA})
      string(REGEX REPLACE "^#define CLANG_VERSION ([0-9]+\\.[0-9]+)$" "\\1" CLANG_VERSION_STRING ${line})
      if(DEFINED CLANG_VERSION_STRING)
        string(REGEX MATCH "^([0-9]+\\.[0-9]+)$" CLANG_VERSION_VALID ${CLANG_VERSION_STRING})
        if(NOT ${CLANG_VERSION_VALID} STREQUAL "")
          break()
        endif()
      endif()
    endforeach()
  endif()
  if(NOT ${CLANG_VERSION_VALID} STREQUAL "")
    set(${version} ${CLANG_VERSION_STRING})
  else()
    set(${version} "3.3")
  endif()
endmacro()