{
  pkgs,
  outputs,
  config,
  ...
}: {
  home.packages = with pkgs; [swappy];

  home.file.".config/swappy/config".text = ''
    save_dir="${config.home.homeDirectory}/Pictures/Screenshot"
    save_filename_format=swappy-<time>.png
  '';
}
