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
    "device/samsung/sm8650-common".src = inputs.android-device-samsung-sm8650-common;
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
    "libhybris".src = inputs.lindroid-libhybris;
    "external/lxc".src = inputs.lindroid-external-lxc;
    "vendor/lindroid".src = inputs.lindroid-vendor;
    "kernel/samsung/sm8650/drivers/lindroid-drm".src = pkgs.runCommand "lindroid-drm-src" { } ''
      cp -r ${inputs.lindroid-drm-loopback}/drivers/lindroid-drm-loopback $out
    '';
    "vendor/extra".src = inputs.android-vendor-extra;
    "frameworks/base".patches = [
      ./patches/ignore-uevents-with-null-name.patch
      ./patches/0001-fwb-Screen-off-animations-1-2.patch
      ./patches/0002-Fix-crash-with-protected-content-with-ElectronBeam-S.patch
      ./patches/0005-Disable-screenshot-restrictions-and-audio-capture-blocking.patch
      ./patches/0025-Set-FakeStore-PlayStore-as-Aurora-Store-installer-pa.patch

    ];
    "kernel/configs".patches = [ ./patches/kernel-configs.patch ];
    "vendor/partner_gms".src = inputs.android-vendor-partner-gms;
    "vendor/lineage/imsstack-carrier-config-ext".src = inputs.imsstack-carrier-config-ext;
    "packages/modules/ImsMedia".src = inputs.imsmedia;
    "packages/modules/ImsStack".src = inputs.imsstack;
    "packages/apps/Updater".patches = [
      ./patches/0001-Updater-remove-battery-level-check.patch
    ];
    "packages/modules/Bluetooth".patches = [
      ./patches/0001-Bluetooth-Add-REQUEST_INSTALL_PACKAGES-permission-to.patch
      ./patches/0002-Bluetooth-Allow-sending-any-file-via-Bluetooth.patch
    ];
    "packages/apps/Bellis" = {
      src = inputs.bellis;
      patches = [
        ./patches/0001-app-Update-systemApps-to-match-LineageOS.patch
        ./patches/0001-app-Make-Aurora-Store-and-F-Droid-available-in-work-.patch
      ];
    };
    "system/sepolicy".patches = [
      ./patches/0001-private-domain-add-new-attr-for-relaxing-a-dir-init-.patch
    ];
  };

  stateVersion = "3";
}
