{
  lib,
  stdenv,
  fetchurl,
  libX11,
  imake,
  gccmakedep,
}:

stdenv.mkDerivation rec {
  pname = "xskat";
  version = "4.0";

  nativeBuildInputs = [ gccmakedep ];
  buildInputs = [
    libX11
    imake
  ];

  src = fetchurl {
    url = "https://web.archive.org/web/20220331112433if_/https://www.xskat.de/xskat-${version}.tar.gz";
    sha256 = "8ba52797ccbd131dce69b96288f525b0d55dee5de4008733f7a5a51deb831c10";
  };

  env.NIX_CFLAGS_COMPILE = "-Wno-implicit-int";

  preInstall = ''
    sed -i Makefile \
      -e "s|.* BINDIR .*|   BINDIR = $out/bin|" \
      -e "s|.* MANPATH .*|  MANPATH = $out/man|"
  '';

  installTargets = [
    "install"
    "install.man"
  ];

  meta = with lib; {
    description = "Famous german card game";
    mainProgram = "xskat";
    platforms = platforms.unix;
    license = licenses.xskat;
    longDescription = "Play the german card game Skat against the AI or over IRC.";
    homepage = "https://web.archive.org/web/20221003060115/https://www.xskat.de/xskat.html";
  };
}
