# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula

class KsiTool < Formula
  desc "CLI for Keyless Signature Infrastructure (c) Guardtime"
  homepage "https://github.com/guardtime/ksi-tool"
  url "https://github.com/guardtime/ksi-tool/archive/v2.4.1038.tar.gz"
  sha256 "c551b0f0b2db7b79bb756dcef56eeae4a955d259daf679523108995c417f6198"

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "libksi" => :build


  def install
    system "./rebuild.sh", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "ksi -h"
  end
end
