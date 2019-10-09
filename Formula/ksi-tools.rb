class KsiTools < Formula
  desc "CLI for Keyless Signature Infrastructure (c) Guardtime"
  homepage "https://github.com/guardtime/ksi-tool"
  url "https://github.com/guardtime/ksi-tool/archive/v2.9.1374.tar.gz"
  sha256 "c804a2dfd2ce4d48dc43a90ad29b30608ba05a6d353dc39127a1c54b583e8815"

  # Change revision if there is a need to recompile the formula
  # and the version of the package is not changed. If version
  # changes comment 'revision' field out.
  # revision 1

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "libparamset"
  depends_on "libksi"

  def install
    system "autoreconf", "-if"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/ksi", "-h"
  end
end
