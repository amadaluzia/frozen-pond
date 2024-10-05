{python312Packages}:
python312Packages.buildPythonApplication {
  pname = "arturs-stupid-alarm-clock";
  version = "0.1.0";
  propagatedBuildInputs = [
    python312Packages.notify-py
  ];
  src = ./.;
  postInstall = ''
    substituteInPlace $out/bin/arturs-stupid-alarm-clock.py \
      --replace-fail "icon.gif" "${./icon.gif}" \
      --replace-fail "sound.wav" "${./sound.wav}"
  '';
}
