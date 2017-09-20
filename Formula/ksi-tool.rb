# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula

class KsiTool < Formula
  desc "CLI for Keyless Signature Infrastructure (c) Guardtime"
  homepage "https://github.com/guardtime/ksi-tool"
  url "https://github.com/guardtime/ksi-tool/archive/v2.6.1136.tar.gz"
  sha256 "915c51380c9b1217c7633d88308f7d79564d837775e88754909548e509fe2d63"
  revision 2

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "libksi" => :build


  def install
    system "autoreconf", "-if"
    system "./configure", "--prefix=#{prefix} --with-openssl=/usr/local/opt"
    # system "./rebuild.sh", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "ksi -h"
  end
end
