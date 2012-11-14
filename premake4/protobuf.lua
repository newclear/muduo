
function protobufs(pat)
    local list = {}
    if type(pat) == "string" then
        list[1] = pat;
    elseif type(pat) == "table" then
        list = pat;
    end
    local proj = project();
    for _,pat in ipairs(list) do
        local protofiles = os.matchfiles(pat);
        for _,protofile in ipairs(protofiles) do
            local basename = path.getbasename(protofile);
            local sourcedir = proj.basedir.."/"..path.getdirectory(protofile);
            local sourcefile = proj.basedir.."/"..protofile;
            local targetdir = "$(OBJDIR)/proto/"..path.getdirectory(protofile);
            local targetfile = targetdir.."/"..basename..".pb.cc";
            prebuildcommands {
                "@mkdir -p "..targetdir,
                "@test "..sourcefile.." \\\n"
                .."\t\t\t -ot "..targetfile.." || \\\n"
                .."\t\t( echo protoc "..protofile.." && \\\n"
                .."\t\tprotoc --cpp_out "..targetdir.."\\\n"
                .."\t\t\t"..sourcefile.."\\\n"
                .."\t\t\t".." -I"..sourcedir.." ) \\\n"
            }
            files {
                path.join(targetdir, basename..".pb.h"),
                path.join(targetdir, basename..".pb.cc"),
            }
            includedirs { targetdir }
        end
    end
end

