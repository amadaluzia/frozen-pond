{ python3Packages }:
python3Packages.buildPythonApplication {
  pname = "fzuplock.py";
  version = "0.1.0";
  propagatedBuildInputs = [
    python3Packages.pyfzf
    python3Packages.pyfiglet
  ];
  src = ./.;
}
