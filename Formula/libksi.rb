# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula

class Libksi < Formula
  desc "C SDK for Keyless Signature Infrastructure (c) Guardtime"
  homepage "https://github.com/guardtime/libksi"
  url "https://github.com/guardtime/libksi/archive/v3.15.2306.tar.gz"
  sha256 "09a173f2101db4dc6d31e535850d6bfdeb9478bfbb96baae506c9842d24dda41"
  # revision 7

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
