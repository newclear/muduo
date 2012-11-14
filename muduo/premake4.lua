newoption {
   trigger     = "with-muduo-test",
   description = "build with muduo tests."
}

project "muduo"
    kind "StaticLib"
    files {
        "**.h",
        "**.cc",
    }
    protobufs "**/*.proto"
    excludes {
        "**/tests/*",
    }
    configuration "macosx"
        excludes { "**/EPollPoller.cc" }

if _OPTIONS["with-muduo-test"] then
    local unittests = os.matchfiles("**/tests/*.cc")
    for _,unittest in ipairs(unittests) do
        project(path.getbasename(unittest))
            kind "ConsoleApp"
            files(unittest)
            links {
                "muduo",
                "boost_unit_test_framework-mt",
            }
    end
end

