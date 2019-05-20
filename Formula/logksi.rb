class Logksi < Formula
  desc "Log signature command-line tool for Keyless Signature Infrastructure (c) Guardtime"
  homepage "https://github.com/guardtime/logksi"
  url "https://github.com/guardtime/logksi/archive/v1.4.518.tar.gz"
  sha256 "dacda8803e283015adc343008605396275d657d86abd73277f540b93f08bc783"

  # Change revision if there is a need to recompile the formula 
  # and the version of the package is not changed. If version
  # changes comment 'revision' field out.
  # revision 1

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "libksi"
  depends_on "libgtrfc3161"

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
