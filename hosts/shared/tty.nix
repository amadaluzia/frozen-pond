{ pkgs, ... }: {
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    colors = [
      "191724"
      "eb6f92"
      "9ccfd8"
      "f6c177"
      "31748f"
      "c4a7e7"
      "ebbcba"
      "e0def4"
      "26233a"
      "eb6f92"
      "9ccfd8"
      "f6c177"
      "31748f"
      "c4a7e7"
      "ebbcba"
      "e0def4"
    ];
    keyMap = "us";
  };
}
