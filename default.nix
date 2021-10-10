{ pkgs ? let
    lock = builtins.fromJSON (builtins.readFile ./flake.lock);
    nixpkgs = with lock.nodes.nixpkgs.locked; builtins.fetchTarball {
      url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
      sha256 = narHash;
    };
  in
  import nixpkgs { }
}:
pkgs.callPackage ./comma.nix { }
