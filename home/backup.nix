{ pkgs, ... }:

let
  backupExcludes = pkgs.writeText "backup-excludes" ''
    .cache
    cache
    cacheable
    *Cache
    Crash*
    logs
    *.log
    .trash
    datareporting
    generated-sources

    .direnv
    target
    node_modules
    .stack-work
    _minted*
    _build
    venv
    .venv

    .local/share/docker
    .local/share/Trash
    .local/share/direnv
    .local/share/racket
    .local/share/virtualenv
    .local/share/cabal
    .local/state

    trash/
    Downloads/
    invian/
    stuff/iso/
    stuff/vms/*/disk.qcow2
  '';

  backupScript = pkgs.writeShellScript "backup" ''
    ${pkgs.rsync}/bin/rsync \
      --partial --verbose --human-readable \
      --archive --compress --delete --delete-excluded --force \
      --hard-links --perms --executability --times \
      --exclude-from "${backupExcludes}" \
      --rsh=ssh \
    /home/stoat/ stoat.ru:/home/stoat/backups/home
  '';

in {
  systemd.user = {
    services.backup = {
      Unit.Description = "Backup home directory";
      Service.ExecStart = backupScript;
    };
    timers.backup = {
      Unit.Description = "Backup home directory daily";
      Timer.OnCalendar = "daily";
      Install.WantedBy = [ "default.target" ];
    };
  };
}
