{ pkgs, ... }:

{
  networking.networkmanager.enable = true;
  networking.hostName = "stoat";

  # Blocks incoming connections and other unexpected packages
  networking.firewall = {
    allowedTCPPorts = [ 1234 ];
    logReversePathDrops = true;
    # Enable setting up WireGuard via NetworkManager
    extraCommands = ''
      ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51830 -j RETURN
      ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51830 -j RETURN
    '';
    extraStopCommands = ''
      ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51830 -j RETURN || true
      ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51830 -j RETURN || true
    '';
  };

  # Fix connection to UniversityStudent
  systemd.services.wpa_supplicant.environment.OPENSSL_CONF =
    pkgs.writeText "openssl.cnf" ''
      openssl_conf = openssl_init
      [openssl_init]
      ssl_conf = ssl_sect
      [ssl_sect]
      system_default = system_default_sect
      [system_default_sect]
      Options = UnsafeLegacyRenegotiation
      [system_default_sect]
      CipherString = Default:@SECLEVEL=0
    '';
}
