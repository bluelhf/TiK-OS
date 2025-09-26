{ pkgs, ... }:
{
  raspberry-pi-nix = {
    board = "bcm2711";
    libcamera-overlay.enable = false;
    serial-console.enable = false;
  };

  sdImage.compressImage = false;

  zramSwap.enable = true;

  systemd.services.gatus-heartbeat = {
    script = ''
      set -eu
      ${pkgs.curl}/bin/curl -X POST -H "Authorization: Bearer $TOKEN" "$ENDPOINT"
    '';

    environment = {
      ENDPOINT = "https://status.tietokilta.fi/api/v1/endpoints/_guild-room-infoscreen/external?success=true";
      TOKEN = "VRXibHcAAE0p6R" + "UbPy84f4KrWlwJvtZr";
    };

    serviceConfig = {
      DynamicUser = true;
      User = "gatus-heartbeat";
      Type = "oneshot";
    };
    startAt = "*:0/1";
  };
}
