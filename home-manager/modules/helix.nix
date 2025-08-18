{
  input,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.helix;
in
{
  options = {
    modules.helix.enable = lib.mkEnableOption "helix";
  };

  config = lib.mkIf cfg.enable {
    programs.helix = {
      enable = true;
      defaultEditor = true;

      settings = {
        # Theming
        theme = "rose_pine";

        # General settings
        editor = {
          line-number = "relative"; # show relative number
          bufferline = "multiple"; # when to show open buffers [never, always, multiple]
          cursorline = false; # highlight the line of the cursor
          color-modes = false; # colored bottom modal line
          end-of-line-diagnostics = "hint"; # errors under the line
          completion-timeout = 5; # make the lsp a lil faster
          completion-trigger-len = 1; # fast autocomplete
          completion-replace = true; # replace the whole word
          idle-timeout = 10; # make everything a lil faster
          auto-info = true; # i dont need the popups

          # the best shell
          shell = [
            "nu"
            "--stdin"
            "-c"
          ];

          # Uncomment if you want no line numbers
          # gutters = [
          #   "diagnostics"
          #   "diff"
          # ];

          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "block";
          };

          lsp.snippets = true;

          inline-diagnostics = {
            # add lines to view indentations
            cursor-line = "error";
          };

          statusline = {
            left = [
              "mode"
              "spinner"
              "version-control"
              "file-name"
            ];
            right = [
              "diagnostics"
              "selections"
              "position"
              "file-encoding"
              "file-line-ending"
              "version-control"
              "separator"
              "file-type"
            ];
          };
        };

        # Keybindings
        keys.normal = {
          esc = [
            "collapse_selection"
            "keep_primary_selection"
          ]; # enable escaping from all states
          C-s = ":w"; # save ctrl + s
          C-f = [
            "goto_next_function"
            "flip_selections"
            "collapse_selection"
          ]; # go next function
          C-S-f = [
            "goto_prev_function"
            "collapse_selection"
          ]; # go prev function
          S-x = "@gsvgl<esc>"; # select line without spaces
          C-t = ":toggle lsp.display-inlay-hints"; # toggle lsp type hints

          # move between panes with ctrl + hjkl
          C-l = "@<C-w>l";
          C-h = "@<C-w>h";
          C-j = "@<C-w>j";
          C-k = "@<C-w>k";

          # switch buffers with shift + h/l
          S-h = "@gp";
          S-l = "@gn";

          # Yazi integration
          C-y = [
            ":sh rm -f /tmp/files2open"
            ":set mouse false"
            ":insert-output yazi \"%{buffer_name}\" --chooser-file=/tmp/files2open"
            ":redraw"
            ":set mouse true"
            ":open /tmp/files2open"
            "select_all"
            "split_selection_on_newline"
            "goto_file"
            ":buffer-close! /tmp/files2open"
          ];

        };
      };

      # languages.toml
      languages.language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
        }
        {
          name = "zig";
          auto-format = true;
          scope = "source.zig";
          injection-regex = "zig";
          file-types = [
            "zig"
            "zon"
          ];
          roots = [ "build.zig" ];
          comment-tokens = [
            "//"
            "///"
            "//!"
          ];
          language-servers = [ "zls" ];
          indent = {
            tab-width = 4;
            unit = "    ";
          };
          formatter = {
            command = "zig";
            args = [
              "fmt"
              "--stdin"
            ];
          };
        }
      ]; # languages.toml
    }; # helix
  };
}
