{ ... }:

{
    services.openssh = {
        enable = true;
        forwardX11 = true;
        ports = [2002];
        settings = {
            PermitRootLogin = "no";
            PasswordAuthentication = true;
        };
    }
}

# ex: tabstop=4 shiftwidth=4 expandtab
