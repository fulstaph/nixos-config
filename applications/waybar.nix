{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    # systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 28;
        spacing = 4;
        
        modules-left = ["niri/workspaces" ]; # "wlr/taskbar"];
        modules-center = ["clock"];
        modules-right = ["pulseaudio" "network" "cpu" "memory" "battery" "niri/language" "tray"];

        "niri/language" = {
          format = "{icon} {name}";
          format-icons = {
            en = "🇬🇧";
            de = "🇩🇪";
            fr = "🇫🇷";
            es = "🇪🇸";
            it = "🇮🇹";
            ja = "🇯🇵";
            zh = "🇨🇳";
            ru = "🇷🇺";
            au = "🇦🇺";
            ge = "🇬🇪";
          };
          on-click = "niri/language-switcher";
        };
        
        # Tokyo Night color scheme
        "wlr/workspaces" = {
          active-only = false;
          format = "{name}";
          on-click = "activate";
        };
        
        clock = {
          format = "{:%H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        
        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" ""];
          };
          scroll-step = 5;
          on-click = "pavucontrol";
        };
        
        network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} ";
          format-disconnected = "Disconnected ⚠";
          tooltip-format = "{ifname} via {gwaddr}";
        };
        
        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };
        
        memory = {
          format = "{}% ";
        };
        
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = ["" "" "" "" ""];
        };
      };
    };
    
    # Tokyo Night style configuration
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "FiraCode", "JetBrains Mono";
        font-size: 12px;
        min-height: 0;
      }
      
      window#waybar {
        background: #1a1b26;
        color: #a9b1d6;
        transition-property: background-color;
        transition-duration: .5s;
      }
      
      #workspaces button {
        padding: 0 5px;
        background: transparent;
        color: #a9b1d6;
        border-top: 2px solid transparent;
      }
      
      #workspaces button.focused {
        color: #7aa2f7;
        border-top: 2px solid #7aa2f7;
      }
      
      #workspaces button.urgent {
        color: #f7768e;
      }
      
      #clock, #pulseaudio, #network, #cpu, #memory, #battery, #tray {
        padding: 0 10px;
        margin: 0 4px;
        color: #a9b1d6;
      }
      
      #clock {
        background-color: #1a1b26;
        color: #7aa2f7;
      }
      
      #pulseaudio {
        color: #e0af68;
      }
      
      #pulseaudio.muted {
        color: #f7768e;
      }
      
      #network {
        color: #9ece6a;
      }
      
      #network.disconnected {
        color: #f7768e;
      }
      
      #cpu {
        color: #bb9af7;
      }
      
      #memory {
        color: #2ac3de;
      }
      
      #battery {
        color: #9ece6a;
      }
      
      #battery.charging {
        color: #9ece6a;
      }
      
      #battery.warning:not(.charging) {
        color: #e0af68;
      }
      
      #battery.critical:not(.charging) {
        color: #f7768e;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
      
      @keyframes blink {
        to {
          background-color: #1a1b26;
          color: #a9b1d6;
        }
      }
      
      #tray {
        background-color: #1a1b26;
      }
      
      #taskbar button {
        padding: 0 5px;
        background: transparent;
        color: #a9b1d6;
      }
      
      #taskbar button.active {
        background-color: #1a1b26;
        color: #7aa2f7;
      }
    '';
  };
}