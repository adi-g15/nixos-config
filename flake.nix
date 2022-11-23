system.nixos.label = (lib.maybeEnv "NIXOS_LABEL"
(lib.concatStringsSep "-" ((lib.sort (x: y: x < y) config.system.nixos.tags) ++
                           [(lib.maybeEnv "NIXOS_LABEL_VERSION" config.system.nixos.version)
                             "g${inputs.self.shortRev}"
                           ])));

