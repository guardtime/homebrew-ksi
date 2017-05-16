# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula

class KsiTool < Formula
  desc "CLI for Keyless Signature Infrastructure (c) Guardtime"
  homepage "https://github.com/guardtime/ksi-tool"
  url "https://github.com/guardtime/ksi-tool/archive/v2.5.1125.tar.gz"
  sha256 "679fcd81783f5fdff2786c4a3b75fdd9071c5f9dba2d75da9eed3ece5bd60ccd"
  # revision 2

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "libksi" => :build


  def install
    system "autoreconf", "-if"
    system "./configure", "--prefix=#{prefix}"
    # system "./rebuild.sh", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "ksi -h"
  end
end
