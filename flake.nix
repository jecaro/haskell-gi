{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
      nixpkgsFor = forAllSystems (system: import nixpkgs {
        inherit system;
      });
    in
    {
      devShell = forAllSystems (system:
        let pkgs = nixpkgsFor.${system};
        in
        pkgs.mkShell {
          buildInputs = [
            pkgs.cairo
            pkgs.cfitsio
            pkgs.cgif
            pkgs.clutter
            pkgs.cogl
            pkgs.elfutils
            pkgs.fftw
            pkgs.ghcid
            pkgs.gobject-introspection
            pkgs.graphene
            pkgs.gst_all_1.gst-devtools
            pkgs.gst_all_1.gst-editing-services
            pkgs.gtk-layer-shell
            pkgs.gtk3
            pkgs.gtksourceview3
            pkgs.ibus
            pkgs.json-glib
            pkgs.libayatana-appindicator
            pkgs.libarchive
            pkgs.libdatrie
            pkgs.libepoxy
            pkgs.libexif
            pkgs.libgcrypt
            pkgs.libgit2-glib
            pkgs.libgpg-error
            pkgs.libhwy
            pkgs.libimagequant
            pkgs.libnotify
            pkgs.libpsl
            pkgs.librsvg
            pkgs.libsecret
            pkgs.libselinux
            pkgs.libsepol
            pkgs.libsoup
            pkgs.libspng
            pkgs.libstartup_notification
            pkgs.libsysprof-capture
            pkgs.libthai
            pkgs.libunwind
            pkgs.libwebp
            pkgs.libwnck
            pkgs.libxkbcommon
            pkgs.libxml2
            pkgs.matio
            pkgs.openexr
            pkgs.orc
            pkgs.ostree
            pkgs.pango
            pkgs.pcre
            pkgs.pcre2
            pkgs.pkg-config
            pkgs.poppler_gi
            pkgs.python3
            pkgs.sqlite
            pkgs.util-linux
            pkgs.vips
            pkgs.vte
            pkgs.webkitgtk
            pkgs.xorg.libXdmcp
            pkgs.xorg.libXres
            pkgs.xorg.libXtst
            (pkgs.haskellPackages.ghcWithPackages (pkgs_: with pkgs_;
            [
              sdl2
              aeson-pretty
              cabal-doctest
              cabal-install
              gi-girepository
              haskell-language-server
              hlint
              hsc2hs
              implicit-hie
              pretty-show
              xdg-basedir
              xml-conduit
              streaming-commons
              conduit-extra
              search-algorithms
            ]))
          ];
        });
    };
}
