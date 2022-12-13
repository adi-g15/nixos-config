{ config, ... }:

{
  # @idea: https://www.linkedin.com/posts/sarthak-dalabehera_ip-networking-activity-7007611168034881537-gFY5
  # @ref: https://unix.stackexchange.com/a/412447
  environment.etc."sysctl.d/disabled-icmp.conf".text = ''
    net.ipv4.icmp_echo_ignore_all = 1
    net.ipv6.icmp.echo_ignore_all = 1
  '';
}
