{ pkgs, ... }:
{
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    colors = [
      "282828"
      "928374"
      "cc241d"
      "fb4934"
      "98971a"
      "b8bb26"
      "d79921"
      "fabd2f"
      "458588"
      "83a598"
      "b16286"
      "d3869b"
      "689d6a"
      "8ec07c"
      "a89984"
      "ebdbb2"
    ];
    keyMap = "us";
  };
}
