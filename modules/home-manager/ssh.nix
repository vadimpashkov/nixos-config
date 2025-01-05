{ username, ... }:

{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host github.com
        User git
        IdentityFile /home/${username}/.ssh/github
    '';
  };
}
