{ inputs }: let
  fonts = _final: prev: {
    nerdfonts-symbols = (prev.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; });
  };
  xonsh = final: prev: {
    myxonsh = (prev.xonsh.override { extraPackages = ps: [
      (ps.buildPythonPackage rec {
        name = "xontrib-sh";
        version = "0.3.1";

        src = final.fetchFromGitHub {
         owner = "anki-code";
         repo = name;
         rev = version;
         sha256 = "sha256-KL/AxcsvjxqxvjDlf1axitgME3T+iyuW6OFb1foRzN8=";
        };
      })
      (ps.buildPythonPackage rec {
        name = "xontrib-sh";
        version = "0.3.1";

        src = final.fetchFromGitHub {
         owner = "anki-code";
         repo = name;
         rev = version;
         sha256 = "sha256-KL/AxcsvjxqxvjDlf1axitgME3T+iyuW6OFb1foRzN8=";
        };
      })
      (ps.buildPythonPackage rec {
        name = "xontrib-fish-completer";
        version = "0.0.1";

        src = final.fetchFromGitHub {
         owner = "xonsh";
         repo = name;
         rev = version;
         sha256 = "sha256-PhhdZ3iLPDEIG9uDeR5ctJ9zz2+YORHBhbsiLrJckyA=";
        };

        prePatch = ''
          final.lib.substituteInPlace pyproject.toml --replace '"xonsh>=0.12.5"' ""
        '';
        patchPhase = "sed -i -e 's/^dependencies.*$/dependencies = []/' pyproject.toml";
        doCheck = false;
      })
      (ps.buildPythonPackage rec {
        name = "xonsh-direnv";
        version = "1.6.1";

        src = final.fetchFromGitHub {
         owner = "74th";
         repo = name;
         rev = version;
         sha256 = "sha256-979y+jUKZkdIyXx4q0f92jX/crFr9LDrA/5hfXm1CpU=";
        };
      })
    ]; });
  };
in [
  fonts
  xonsh
]
