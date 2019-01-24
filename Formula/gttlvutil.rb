class Gttlvutil < Formula
  desc "A collection of utils for working with the KSI type-length-value (TLV) encoded binary data."
  homepage "https://github.com/guardtime/gttlvutil"
  url "https://github.com/guardtime/gttlvutil/archive/v1.4.513.tar.gz"
  sha256 "1f0f4a162f664d14a90f17888c5276851059b192b402c3e277da9a3e38b88e75"

  # Change revision if there is a need to recompile the formula
  # and the version of the package is not changed. If version
  # changes comment 'revision' field out.
  # revision 1

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "openssl"

  def install
    system "autoreconf", "-if"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/gttlvdump", "-h"
  end
end
