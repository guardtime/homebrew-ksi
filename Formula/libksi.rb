# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula

class Libksi < Formula
  desc "C SDK for Keyless Signature Infrastructure (c) Guardtime"
  homepage "https://github.com/guardtime/libksi"
  url "https://github.com/guardtime/libksi/archive/v3.13.2043.tar.gz"
  sha256 "2d51458a5429e6e3d7bec539282a7e58f90b6ef19c63df775f1ec6fa2e5914c8"

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build

  def install
    system "autoreconf", "-if"
    system "./configure", "--prefix=#{prefix}"
    # system "./rebuild.sh", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "false"
  end
end
