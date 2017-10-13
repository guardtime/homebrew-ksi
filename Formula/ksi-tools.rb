class KsiTools < Formula
  desc "CLI for Keyless Signature Infrastructure (c) Guardtime"
  homepage "https://github.com/guardtime/ksi-tool"
  url "https://github.com/guardtime/ksi-tool/archive/v2.7.1200.tar.gz"
  sha256 "544bb2569752ac09e41e827e7412f9d612ae57f895d06e29bd0f056ce08fc3ec"

  # Change revision if there is a need to recompile the formula
  # and the version of the package is not changed. If version
  # changes comment 'revision' field out.
  revision 3

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "libksi" => :run

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
