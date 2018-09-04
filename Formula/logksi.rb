class Logksi < Formula
  desc "Log signature command-line tool for Keyless Signature Infrastructure (c) Guardtime"
  homepage "https://github.com/guardtime/logksi"
  url "https://github.com/guardtime/logksi/archive/v1.3.396.tar.gz"
  sha256 "864fe38c1377b5f74da6795fc41f7aacdae8429d50be8cac5e97b768c85874e2"

  # Change revision if there is a need to recompile the formula 
  # and the version of the package is not changed. If version
  # changes comment 'revision' field out.
  # revision 1

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "libksi"

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
