class Logksi < Formula
  desc "Log signature command-line tool for Keyless Signature Infrastructure (c) Guardtime"
  homepage "https://github.com/guardtime/logksi"
  url "https://github.com/guardtime/logksi/archive/v1.2.323.tar.gz"
  sha256 "8fa5319c8e3731c6fc14b480b6c43f99a838a06fc181be0a7dbf020f2bf4899b"

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
