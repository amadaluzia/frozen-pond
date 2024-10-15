{
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation {
  pname = "touhou-cursors";
  version = "0.1.0";
  src = fetchFromGitHub {
    owner = "mabequinho";
    repo = "touhou-cursors";
    rev = "main";
    hash = "sha256-XYmEpRkvZK7O9F7s3nKFA9rd7xO0ECEWlVyUb8/whq4=";
  };
  installPhase = ''
    mkdir -p $out/share/icons
    cp -r */ $out/share/icons
  '';
}
