{
  input,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.mpv;

  # Additional script for skipping openings, endings, etc.
  chapterskip =
    let
      file =
        builtins.toFile "chapterskip.lua" # lua
          ''
                    require 'mp.options'
            local opt = {
                patterns = {
                    "OP","[Oo]pening$", "[Ii]ntro",  "^[Oo]pening:", "[Oo]pening [Cc]redits",
                    "ED","[Ee]nding$", "^[Ee]nding:", "[Ee]nding [Cc]redits",
                    "[Pp]review$",
                },
            }
            read_options(opt)

            function check_chapter(_, chapter)
                if not chapter then
                    return
                end
                for _, p in pairs(opt.patterns) do
                    if string.match(chapter, p) then
                        print("Skipping chapter:", chapter)
                        mp.command("no-osd add chapter 1")
                        return
                    end
                end
            end

            mp.observe_property("chapter-metadata/by-key/title", "string", check_chapter)
          '';
    in
    # This function generates a new pkgs.mpvScripts
    pkgs.mpvScripts.buildLua {
      pname = "chapterskip";
      version = "1.0.0";
      src = file;
      unpackPhase = ":";
      scriptPath = file;
    };

in
{
  options = {
    modules.mpv.enable = lib.mkEnableOption "mpv";
  };

  config = lib.mkIf cfg.enable {
    programs.mpv = {
      enable = true;

      scripts = [
        pkgs.mpvScripts.mpris
        pkgs.mpvScripts.modernz
        pkgs.mpvScripts.thumbfast
      ]
      ++ [
        # custom scripts
        chapterskip
      ];
    };
  };
}
