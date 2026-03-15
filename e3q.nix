inputs: {
  device = "e3q";
  flavor = "lineageos";
  flavorVersion = "23.2";

  apps.fdroid.enable = true;
  microg.enable = true;

  source.dirs = {
    "device/samsung/e3q".src = inputs.android-device-samsung-e3q;
    "device/samsung/sm8650-common" = {
      src = inputs.android-device-samsung-sm8650-common;
      patches = [ ./patches/permissive-selinux.patch ];
    };
    "hardware/samsung".src = inputs.android-hardware-samsung;
    "kernel/samsung/sm8650-devicetrees".src = inputs.android-kernel-samsung-sm8650-devicetrees;
    "kernel/samsung/sm8650-modules".src = inputs.android-kernel-samsung-sm8650-modules;
    "kernel/samsung/sm8650" = {
      src = inputs.android-kernel-samsung-sm8650;
      patches = [
        ./patches/fix-gki-symbols-permission.patch
        ./patches/lindroid-kernel.patch
      ];
      postPatch = "mkdir -p drivers/lindroid-drm";
    };
    "vendor/samsung/e3q".src = inputs.proprietary-vendor-samsung-e3q;
    "vendor/samsung/sm8650-common".src = inputs.proprietary-vendor-samsung-sm8650-common;

    # Lindroid
    "libhybris".src = inputs.lindroid-libhybris;
    "external/lxc".src = inputs.lindroid-external-lxc;
    "vendor/lindroid" = {
      src = inputs.lindroid-vendor;
      patches = [ ./patches/lindroid-vendor.patch ];
    };
    "kernel/samsung/sm8650/drivers/lindroid-drm".src = inputs.lindroid-drm-loopback;
    "vendor/extra".src = ./vendor-extra;
    "frameworks/base".patches = [ ./patches/ignore-uevents-with-null-name.patch ];
    "kernel/configs".patches = [ ./patches/kernel-configs.patch ];
  };

  stateVersion = "3";
}
