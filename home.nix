# Home Manager configuration for user 'justin'
{ config, lib, pkgs, ... }:

{
  # Home Manager state version
  home.stateVersion = "24.11";

  # User packages
  home.packages = with pkgs; [
    # General
    neovim
    htop
    wget
    curl
    alacritty
    git
    kdePackages.dolphin
    wlsunset
    neofetch
    firefox
    obsidian

    # Audio
    easyeffects
    pavucontrol
    pamixer

    # Hyprland utilities
    wofi
    foot
    waybar
    mako
    hyprpaper
    grimblast
    swayidle
    swaylock
    light
    networkmanagerapplet
    libnotify
    brightnessctl
    nwg-look
    hyprpolkitagent

    # Development
    gcc
    sccache
    rust-bin.stable.latest.default
    docker
  ];

  # Enable Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    # Hyprland configuration with Catppuccin Mocha theme
    extraConfig = let
      colors = {
        base = "0x1e1e2e";
        mantle = "0x181825";
        crust = "0x11111b";
        surface0 = "0x313244";
        surface1 = "0x45475a";
        surface2 = "0x585b70";
        overlay0 = "0x6c7086";
        overlay1 = "0x7f849c";
        overlay2 = "0x9399b2";
        text = "0xcdd6f4";
        subtext0 = "0xa6adc8";
        subtext1 = "0xbac2de";
        rosewater = "0xf5e0dc";
        flamingo = "0xf2cdcd";
        pink = "0xf5c2e7";
        mauve = "0xcba6f7";
        red = "0xf38ba8";
        maroon = "0xeba0ac";
        peach = "0xfab387";
        yellow = "0xf9e2af";
        green = "0xa6e3a1";
        teal = "0x94e2d5";
        sky = "0x89dceb";
        sapphire = "0x74c7ec";
        blue = "0x89b4fa";
        lavender = "0xb4befe";
      };

      mainMod = "SUPER";

      # Monitor configuration
      monitorConfig = ''
        monitor=,preferred,auto,1
        monitor=eDP-1,preferred,auto,1.25
        monitor=DP-1,preferred,0x0,1
        monitor=HDMI-A-1,preferred,1920x0,1
        bindl=,switch:Lid Switch,exec,hyprctl keyword monitor "eDP-1, disable"
        bindl=,switch:off:Lid Switch,exec,hyprctl keyword monitor "eDP-1,preferred,auto,1.25"
      '';

      # Visual settings
      visualConfig = ''
        animations {
          enabled = true
          bezier = easeOut, 0.25, 1.0, 0.5, 1.0
          animation = windows, 1, 5, easeOut
          animation = windowsOut, 1, 5, easeOut
          animation = border, 1, 10, easeOut
          animation = fade, 1, 5, easeOut
          animation = workspaces, 1, 6, easeOut
        }
        general {
          border_size = 2
          border_color = ${colors.overlay0}
          active_border_color = ${colors.mauve}
          inactive_border_color = ${colors.overlay1}
          gaps_in = 4
          gaps_out = 8
          layout = dwindle
        }
        decoration {
          rounding = 6
          blur {
            enabled = true
            size = 4
            passes = 2
          }
          drop_shadow = true
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(00000088)
        }
        input {
          kb_layout = us
          follow_mouse = 1
          touchpad {
            natural_scroll = true
            tap-to-click = true
          }
          sensitivity = 0.0
        }
        dwindle {
          pseudotile = true
          preserve_split = true
          no_gaps_when_only = false
        }
      '';

      # Keybindings
      keybindingsConfig = ''
        bind = ${mainMod}, D, exec, wofi --show drun
        bind = ${mainMod}, Return, exec, foot
        bind = ${mainMod}, H, hy3:movefocus, l
        bind = ${mainMod}, L, hy3:movefocus, r
        bind = ${mainMod}, K, hy3:movefocus, u
        bind = ${mainMod}, J, hy3:movefocus, d
        bind = ${mainMod} SHIFT, H, hy3:movewindow, l
        bind = ${mainMod} SHIFT, L, hy3:movewindow, r
        bind = ${mainMod} SHIFT, K, hy3:movewindow, u
        bind = ${mainMod} SHIFT, J, hy3:movewindow, d
        bind = ${mainMod}, 1, workspace, 1
        bind = ${mainMod}, 2, workspace, 2
        bind = ${mainMod}, 3, workspace, 3
        bind = ${mainMod}, 4, workspace, 4
        bind = ${mainMod}, 5, workspace, 5
        bind = ${mainMod}, 6, workspace, 6
        bind = ${mainMod}, 7, workspace, 7
        bind = ${mainMod}, 8, workspace, 8
        bind = ${mainMod}, 9, workspace, 9
        bind = ${mainMod}, 0, workspace, 10
        bind = ${mainMod} SHIFT, 1, movetoworkspace, 1
        bind = ${mainMod} SHIFT, 2, movetoworkspace, 2
        bind = ${mainMod} SHIFT, 3, movetoworkspace, 3
        bind = ${mainMod} SHIFT, 4, movetoworkspace, 4
        bind = ${mainMod} SHIFT, 5, movetoworkspace, 5
        bind = ${mainMod} SHIFT, 6, movetoworkspace, 6
        bind = ${mainMod} SHIFT, 7, movetoworkspace, 7
        bind = ${mainMod} SHIFT, 8, movetoworkspace, 8
        bind = ${mainMod} SHIFT, 9, movetoworkspace, 9
        bind = ${mainMod} SHIFT, 0, movetoworkspace, 10
        bind = ${mainMod}, Space, togglefloating
        bind = ${mainMod}, F, fullscreen
        bind = ${mainMod}, Q, killactive
        bind = ${mainMod} SHIFT, E, exit
        bind = , XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
        bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        bind = , XF86MonBrightnessUp, exec, light -A 5
        bind = , XF86MonBrightnessDown, exec, light -U 5
        bind = , Print, exec, grimblast copy area
        bind = SHIFT, Print, exec, grimblast save area
      '';

      # Autostart applications
      autostartConfig = ''
        exec-once = nm-applet --indicator
        exec-once = mako
        exec-once = waybar
        exec-once = hyprpaper
        exec-once = fcitx5
        exec-once = wlsunset -l 35.6895 -L 139.6917
        exec-once = swayidle -w timeout 300 'swaylock -f' timeout 600 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'
      '';
    in
      monitorConfig + visualConfig + keybindingsConfig + autostartConfig;
  };

  # Mako notifications
  services.mako = {
    enable = true;
    defaultTimeout = 5000;
    borderSize = 2;
    borderRadius = 6;
    backgroundColor = "#1e1e2e";
    textColor = "#cdd6f4";
    borderColor = "#cba6f7";
    height = 100;
    width = 300;
    margin = "10";
    padding = "10";
    icons = true;
    maxIconSize = 64;
  };

  # Swaylock configuration
  programs.swaylock = {
    enable = true;
    settings = {
      color = "1e1e2e";
      bs-hl-color = "f38ba8";
      caps-lock-bs-hl-color = "f38ba8";
      caps-lock-key-hl-color = "a6e3a1";
      font = "JetBrainsMono Nerd Font";
      indicator-idle-visible = true;
      indicator-radius = 100;
      indicator-thickness = 7;
      inside-color = "1e1e2e";
      inside-clear-color = "1e1e2e";
      inside-caps-lock-color = "1e1e2e";
      inside-ver-color = "1e1e2e";
      inside-wrong-color = "1e1e2e";
      key-hl-color = "a6e3a1";
      layout-bg-color = "1e1e2e";
      line-color = "1e1e2e";
      line-clear-color = "1e1e2e";
      line-caps-lock-color = "1e1e2e";
      line-ver-color = "1e1e2e";
      line-wrong-color = "1e1e2e";
      ring-color = "cba6f7";
      ring-clear-color = "f9e2af";
      ring-caps-lock-color = "fab387";
      ring-ver-color = "89b4fa";
      ring-wrong-color = "f38ba8";
      separator-color = "1e1e2e";
      text-color = "cdd6f4";
      text-clear-color = "f9e2af";
      text-caps-lock-color = "fab387";
      text-ver-color = "89b4fa";
      text-wrong-color = "f38ba8";
    };
  };

  # Foot terminal configuration
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Hack:size=13";
        dpi-aware = "yes";
      };
      colors = {
        alpha = "0.9";
        foreground = "cdd6f4";
        background = "1e1e2e";
        regular0 = "45475a";
        regular1 = "f38ba8";
        regular2 = "a6e3a1";
        regular3 = "f9e2af";
        regular4 = "89b4fa";
        regular5 = "cba6f7";
        regular6 = "94e2d5";
        regular7 = "bac2de";
        bright0 = "585b70";
        bright1 = "f38ba8";
        bright2 = "a6e3a1";
        bright3 = "f9e2af";
        bright4 = "89b4fa";
        bright5 = "cba6f7";
        bright6 = "94e2d5";
        bright7 = "cdd6f4";
      };
    };
  };

  # Waybar configuration
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "tray" "network" "pulseaudio" "battery" "custom/power" ];
        "hyprland/workspaces" = {
          format = "{name}";
          on-click = "activate";
        };
        "clock" = {
          format = "{:%H:%M %Y-%m-%d}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        "network" = {
          format-wifi = " {essid}";
          format-ethernet = "󰈀 Connected";
          format-disconnected = "󰈂 Disconnected";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}";
        };
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 Muted";
          format-icons = {
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          on-click = "pavucontrol";
        };
        "battery" = {
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "�0��" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          states = {
            warning = 30;
            critical = 15;
          };
        };
        "custom/power" = {
          format = "⏻";
          on-click = "wlogout";
          tooltip = false;
        };
      };
    };
  };

  # Hyprpaper configuration
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/.config/hypr/wallpaper.jpg
    wallpaper = ,~/.config/hypr/wallpaper.jpg
  '';
}
