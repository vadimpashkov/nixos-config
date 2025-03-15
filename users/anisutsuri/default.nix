{
  pkgs,
  username,
  ...
}: {
  # TODO: Нужно понять, как это убрать (ибо без этого - ошибку выдает при сборке)
  programs.zsh.enable = true;

  # --- Основные настройки пользователя ---

  users.users.${username} = {
    isNormalUser = true;
    home = "/home/${username}";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      # "libvirtd" # Для виртуальной машины
    ];
  };

  # --- Часовой пояс ---

  time.timeZone = "Europe/Moscow";

  # --- Локализация (язык) системы ---

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };
  };

  # --- Экран блокировки ---

  security.pam.services.hyprlock = {};

  # --- Виртуальная машина ---

  # System Manager Tool (с ним будто libvirtd работает лучше)
  programs.dconf.enable = true;

  # TODO: Что-то из этого точно можно и нужно вынести в home-manager
  # environment.systemPackages = with pkgs; [
  #   qemu
  #   virt-manager # Графический интерфейс для управления VM
  #   virt-viewer
  #   libvirt # Демон для виртуализации
  #   spice
  #   spice-gtk
  #   win-virtio
  #   win-spice
  #   gnome.adwaita-icon-theme
  # ];

  # virtualisation = {
  #   libvirtd = {
  #     enable = true;
  #     qemu = {
  #       swtpm.enable = true;
  #       ovmf.enable = true;
  #       ovmf.packages = [pkgs.OVMFFull.fd];
  #     };
  #     # qemuVerbatimConfig = ''
  #     #   <domain>
  #     #     <features>
  #     #       <hyperv>
  #     #         <vendor_id state="on" value="kvm"/>
  #     #       </hyperv>
  #     #     </features>
  #     #   </domain>
  #     # '';
  #   };
  #   spiceUSBRedirection.enable = true;
  # };

  # services.spice-vdagentd.enable = true;

  boot = {
    kernelParams = [
      "amd_iommu=on"
      "iommu=pt"
    ];
    # kernelModules = ["vfio" "vfio-pci" "vfio_iommu_type1"];
    # extraModprobeConfig = ''
    #   options vfio-pci ids=10de:2882
    # '';
  };
}
