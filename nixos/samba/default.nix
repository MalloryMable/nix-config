{ config, pkgs, ... }:

let
  vars = import ../variables.nix;
  automount_opts = [
    "x-systemd.automount" "noauto" "x-systemd.idle-timeout=0"
    "x-systemd.device-timeout=5s" "x-systemd.mount-timeout=5s" "user" "users"
    "soft" "rsize=65536" "actimeo=60" "noatime"
  ];
  # NOTE: mallory_creds becuase mallory is the smb user stored in the creds in smb-secrets
  mallory_creds = [
    "credentials=/etc/nixos/smb-secrets"
    "uid=${vars.uid}"
    "gid=${vars.gid}"
    "file_mode=0644"
    "dir_mode=0755"
  ];
in {
  # Mapping my smb mounts
  systemd.tmpfiles.rules = [
    # Type  Path                  Mode User Group Age  Argument
    # TODO: Update the mount names to be less setup specific
    "L+   /home/${vars.coreUser}/server  -    -    -     -   /mnt/omv-mallory"
    "L+   /home/${vars.coreUser}/media   -    -    -     -   /mnt/media"
  ];

  # SAMBA Server mounting logic
  fileSystems = {
    "/mnt/media" = {
      device = "//${vars.serverIp}/jellyfin";
      fsType = "cifs";
      options = automount_opts ++ mallory_creds;
    };

    "/mnt/omv-mallory" = {
      device = "//${vars.serverIp}/mallory";
      fsType = "cifs";
      options = automount_opts ++ mallory_creds;
    };
  };
}
