{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    robotnix.url = "github:ungeskriptet/robotnix/lineage-update";

    android-device-samsung-e3q = {
      url = "github:Exynoobs/android_device_samsung_e3q/lineage-23.2";
      flake = false;
    };
    android-device-samsung-sm8650-common = {
      url = "github:Exynoobs/android_device_samsung_sm8650-common/lineage-23.2";
      flake = false;
    };
    android-kernel-samsung-sm8650 = {
      url = "github:Exynoobs/android_kernel_samsung_sm8650/lineage-23.2";
      flake = false;
    };
    android-kernel-samsung-sm8650-modules = {
      url = "github:Exynoobs/android_kernel_samsung_sm8650-modules/lineage-23.2";
      flake = false;
    };
    android-kernel-samsung-sm8650-devicetrees = {
      url = "github:Exynoobs/android_kernel_samsung_sm8650-devicetrees/lineage-23.2";
      flake = false;
    };
    android-hardware-samsung = {
      url = "github:Exynoobs/android_hardware_samsung/lineage-23.2-openeuicc";
      flake = false;
    };
    android-device-samsung-slsi-sepolicy = {
      url = "github:LineageOS/android_device_samsung_slsi_sepolicy/lineage-23.2";
      flake = false;
    };
    proprietary-vendor-samsung-e3q = {
      url = "git+https://codeberg.org/samsung-sm8650/proprietary_vendor_samsung_e3q?ref=lineage-23.2";
      flake = false;
    };
    proprietary-vendor-samsung-sm8650-common = {
      url = "git+https://codeberg.org/samsung-sm8650/proprietary_vendor_samsung_sm8650-common?ref=lineage-23.2";
      flake = false;
    };
    lindroid-external-lxc = {
      url = "github:Linux-on-droid/external_lxc/lindroid-21";
      flake = false;
    };
    lindroid-libhybris = {
      url = "github:Linux-on-droid/libhybris/lindroid-21";
      flake = false;
    };
    lindroid-drm-loopback = {
      url = "github:Linux-on-droid/lindroid-drm-loopback/master";
      flake = false;
    };
    lindroid-vendor = {
      url = "github:Linux-on-droid/vendor_lindroid/lindroid-22.1";
      flake = false;
    };
    android-vendor-partner-gms = {
      url = "git+https://gitlab.com/itsvixano-dev/android/lineageos-personal/android_vendor_partner_gms.git?ref=main";
      flake = false;
    };
    bellis = {
      url = "github:CalyxOS/platform_packages_apps_Bellis/android16-qpr2";
      flake = false;
    };
    imsmedia = {
      url = "github:krazey/ImsMedia/main";
      flake = false;
    };
    imsstack = {
      url = "github:krazey/ImsStack/main";
      flake = false;
    };
    imsstack-carrier-config-ext = {
      url = "github:krazey/imsstack-carrier-config-ext/main";
      flake = false;
    };
    android-vendor-extra = {
      url = "https://codeberg.org/ungeskriptet/android_vendor_extra/archive/master.tar.gz";
      flake = false;
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      robotnix,
      ...
    }@inputs:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
      ];
    in
    {
      e3q = robotnix.lib.robotnixSystem (import ./e3q.nix inputs);
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
    };
}
