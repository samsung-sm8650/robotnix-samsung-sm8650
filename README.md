# robotnix-samsung-sm8650
Build LineageOS for Samsung SM8650 devices using [robotnix](https://github.com/nix-community/robotnix)

## Usage
```
nix build -L git+https://codeberg.org/samsung-sm8650/robotnix-samsung-sm8650#e3q.ota
adb -d sideload result
```
