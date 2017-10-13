class Logksi < Formula
  desc "Log signature command-line tool for Keyless Signature Infrastructure (c) Guardtime"
  homepage "https://github.com/guardtime/logksi"
  url "https://github.com/guardtime/logksi/archive/v1.1.258.tar.gz"
  sha256 "767ade65eebb78e7875a81aa146770a364beff93925d5a50e9999325210e27bf"

  # Change revision if there is a need to recompile the formula 
  # and the version of the package is not changed. If version
  # changes comment 'revision' field out.
  # revision 1

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
    system "#{bin}/logksi", "-h"
  end
end
