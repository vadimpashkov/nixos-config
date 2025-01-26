{
  programs.kitty = {
    enable = true;

    settings = {
      allow_remote_control = "socket-only";
      listen_on = "unix:/tmp/kitty";

      cursor_trail = 3;
      cursor_trail_decay = "0.1 0.4";
    };
  };
}
