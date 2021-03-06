for _,script in ipairs(os.matchfiles("premake4/*.lua")) do
    dofile(script);
end

defaultaction "gmake"

solution "muduo"
    location "build"
    language "C++"
    configurations { "Debug", "Release" }
    targetdir "build/$(config)"
    objdir "build/obj"
    includedirs {
        "."
    }
    libdirs {
        "$(TARGETDIR)"
    }
    flags {
        "Symbols",
        "ExtraWarnings",
        --"FatalWarnings",
    }
    buildoptions {
        "-Wconversion",
        "-Wno-unused-parameter",
        "-Wold-style-cast",
        "-Woverloaded-virtual",
        "-Wpointer-arith",
        "-Wshadow",
        "-Wwrite-strings",
    }
    configuration "Debug"
        defines { "_DEBUG" }

    configuration "Release"
        defines { "NDEBUG" }
        flags { "Optimize" }
        buildoptions {
            "-finline-limit=1000",
        }
    configuration "macosx"
        libdirs {
            "/opt/local/lib",
        }
 
    include "muduo"

