{username, ...}: {
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host github.com
        HostName gihub.com
        User git
        IdentityFile /home/${username}/.ssh/github
        IdentitiesOnly yes

      Host git.skn.dev
        HostName git.skn.dev
        User git
        IdentityFile /home/${username}/.ssh/gitlub-job
        IdentitiesOnly yes
    '';
  };
}
