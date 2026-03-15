inputs: {
  device = "e3q";
  flavor = "lineageos";
  flavorVersion = "23.2";

  apps.fdroid.enable = true;
  microg.enable = true;

  source.dirs = {
    "device/samsung/e3q".src = inputs.android-device-samsung-e3q;
    "device/samsung/sm8650-common".src = inputs.android-device-samsung-sm8650-common;
    "hardware/samsung".src = inputs.android-hardware-samsung;
    "kernel/samsung/sm8650-devicetrees".src = inputs.android-kernel-samsung-sm8650-devicetrees;
    "kernel/samsung/sm8650-modules".src = inputs.android-kernel-samsung-sm8650-modules;
    "kernel/samsung/sm8650" = {
      src = inputs.android-kernel-samsung-sm8650;
      patches = [ ./patches/fix-gki-symbols-permission.patch ];
    };
    "vendor/samsung/e3q".src = inputs.proprietary-vendor-samsung-e3q;
    "vendor/samsung/sm8650-common".src = inputs.proprietary-vendor-samsung-sm8650-common;
  };

  stateVersion = "3";
}
