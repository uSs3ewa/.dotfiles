{ pkgs, config, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      bell = {
        animation = "Ease";
        color = "#1c1c1c";
        duration = 400;
      };
      colors = {
        cursor = {
          text = "#e0def4";
          cursor = "#db7093";
        };
        normal = {
          black = "#393552";
          red = "#eb6f92";
          green = "#3e8fb0";
          yellow = "#f6c177";
          blue = "#9ccfd8";
          magenta = "#c4a7e7";
          cyan = "#ea9a97";
          white = "#e0def4";
        };
        primary = {
          foreground = "#e0def4";
          background = "#232136";
          dim_foreground = "#908caa";
          bright_foreground = "#e0def4";
        };
        vi_mode_cursor = {
          text = "#e0def4";
          cursor = "#56526e";
        };
        search.matches = {
          foreground = "#908caa";
          background = "#393552";
        };
        search.focused_match = {
          foreground = "#232136";
          background = "#ea9a97";
        };
        hints.start = {
          foreground = "#908caa";
          background = "#2a273f";
        };
        hints.end = {
          foreground = "#6e6a86";
          background = "#2a273f";
        };
        line_indicator = {
          foreground = "None";
          background = "None";
        };
        footer_bar = {
          foreground = "#e0def4";
          background = "#2a273f";
        };
        selection = {
          text = "#e0def4";
          background = "#44415a";
        };
        bright = {
          black = "#5c5c61";
          red = "#ec3a37";
          green = "#3e8fb0";
          yellow = "#f6c177";
          blue = "#9ccfd8";
          magenta = "#c4a7e7";
          cyan = "#ea9a97";
          white = "#e0def4";
        };
        dim = {
          black = "#6e6a86";
          red = "#eb6f92";
          green = "#3e8fb0";
          yellow = "#f6c177";
          blue = "#9ccfd8";
          magenta = "#c4a7e7";
          cyan = "#ea9a97";
          white = "#e0def4";
        };
      };
      cursor = {
        blink_interval = 500;
        blink_timeout = 0;
        thickness = 0.15;
        style = {
          blinking = "Always";
          shape = "Beam";
        };
      };
      font = {
        size = 10;
        glyph_offset = {
          x = 0;
          y = 2;
        };
        normal.family = "JetBrains Mono";
        offset = {
          x = 0;
          y = 4;
        };
      };
      mouse.hide_when_typing = true;
      shell.program = "tmux";
      window = {
        dynamic_padding = true;
        opacity = 0.95;
        blur = true;
        dimensions = {
          columns = 130;
          lines = 30;
        };
        padding = {
          x = 0;
          y = 0;
        };
      };
      keyboard.bindings = [
        {
          action = "ToggleFullScreen";
          key = "F11";
          mods = "Shift|Control";
        }
      ];
    };
  };
}
