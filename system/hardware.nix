{ ... }:

{
  hardware.bluetooth.enable = true;

  hardware.pulseaudio.enable = false;
  # RealTime Kit - DB hands out real time
  security.rtkit.enable = true;
  # Bluetooth support; alternative pulseaudio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  #systemd.services."battery-charge-threshold" = {
  #  wantedBy = ["multi-user.target"];
  #  startLimitBurst = 0;
  #  serviceConfig.Restart = "on-failure";

  #  script = ''
  #    echo 85 > /sys/class/power_supply/BAT0/charge_control_end_threshold
  #  '';
  #};
}
