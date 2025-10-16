{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "George Kvaratskhelia";
    userEmail = "fulstaph@gmail.com";
    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      ci = "commit";
      lg = "log --oneline --graph --decorate --all";
      df = "diff";
      dc = "diff --cached";
      pl = "pull";
      ps = "push";
      rb = "rebase";
      rs = "reset";
    };

    extraConfig = {
      core.askPass = "";          # don't use askpass programs
      credential.helper = "";     # disable GUI credential helpers
    };
  };
}

