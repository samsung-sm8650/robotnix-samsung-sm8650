inputs: { pkgs, ... }: {
  device = "e3q";
  flavor = "lineageos";
  flavorVersion = "23.2";

  envPackages = with pkgs; [ xxd ];
  envVars = {
    WITH_GMS = "true";
  };

  source.dirs = {
    "device/samsung/e3q".src = inputs.android-device-samsung-e3q;
    "device/samsung/sm8650-common" = {
      src = inputs.android-device-samsung-sm8650-common;
      patches = [ ./patches/permissive-selinux.patch ];
    };
    "hardware/samsung".src = inputs.android-hardware-samsung;
    "kernel/samsung/sm8650-devicetrees".src = inputs.android-kernel-samsung-sm8650-devicetrees;
    "kernel/samsung/sm8650-modules" = {
      src = inputs.android-kernel-samsung-sm8650-modules;
      postPatch = "chmod -R a=rwX *";
    };
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
    "frameworks/base".patches = [
      ./patches/ignore-uevents-with-null-name.patch
      ./patches/0005-Disable-screenshot-restrictions-and-audio-capture-blocking.patch
    ];
    "kernel/configs".patches = [ ./patches/kernel-configs.patch ];
    "vendor/partner_gms".src = inputs.android-vendor-partner-gms;
  };

  stateVersion = "3";
}
