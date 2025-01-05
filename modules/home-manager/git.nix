{
  programs.git = {
    enable = true;
    userName = "Vadim Pashkov";
    userEmail = "vadimpashkov.job@gmail.com";
    aliases = {
      save = "!git add -A && git commit -m 'SAVEPOINT'";
      wip = "commit -am 'WIP' --no-verify";
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      core.editor = "nvim";
    };
  };
}
