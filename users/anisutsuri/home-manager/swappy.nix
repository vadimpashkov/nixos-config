{
  pkgs,
  outputs,
  ...
}: {
  home.packages = with pkgs; [swappy];

  home.file.".config/swappy/config".text = ''
    save_dir="${outputs.globalConfig.dir.home}/Pictures/Screenshot"
    save_filename_format=swappy-<time>.png
  '';
}
