{ resholvePackage, installShellFiles, path, coreutils, nixUnstable }:
resholvePackage rec {
  pname = "comma";
  version = "unreleased";
  meta.mainProgram = pname;
  src = ./.;
  nativeBuildInputs = [ installShellFiles ];
  installPhase = ''
    install -D $src/comma $out/bin/comma
    substituteInPlace $out/bin/comma --replace NIXPKGS_PATH ${path}
    ln -s $out/bin/{comma,\,}
    installShellCompletion --cmd comma $src/comma-completion.bash
    installShellCompletion --cmd , $src/comma-completion.bash
  '';
  solutions.default = {
    interpreter = "none";
    scripts = [ "bin/*" "share/*/completions/*" ];
    inputs = [ coreutils nixUnstable ];
    execer = [ "cannot:${nixUnstable}/bin/nix" ];
  };
}
