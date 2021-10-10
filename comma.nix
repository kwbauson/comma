{ resholvePackage, installShellFiles, path, coreutils, nixUnstable }:
resholvePackage rec {
  pname = "comma";
  version = "unreleased";
  meta.mainProgram = pname;
  src = ./.;
  nativeBuildInputs = [ installShellFiles ];
  installPhase = ''
    install -D $src/comma $out/bin/comma
    installShellCompletion --cmd comma $src/comma-completion.bash
    sed -i "s@\bNIXPKGS_PATH\b@${path}@g" $out/bin/comma
    sed -i "s@\bcomma\b@$out/bin/comma@g" $out/share/bash-completion/completions/comma.bash
    ln -s $out/bin/{comma,\,}
    ln -s $out/share/bash-completion/completions/{comma,\,}.bash
  '';
  solutions.default = {
    interpreter = "none";
    scripts = [ "bin/comma" "share/bash-completion/completions/comma.bash" ];
    inputs = [ coreutils nixUnstable ];
    execer = [ "cannot:${nixUnstable}/bin/nix" ];
    keep."${placeholder "out"}/bin/comma" = true;
  };
}
