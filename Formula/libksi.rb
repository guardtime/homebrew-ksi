# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula

class Libksi < Formula
  desc "C SDK for Keyless Signature Infrastructure (c) Guardtime"
  homepage "https://github.com/guardtime/libksi"
  url "https://github.com/guardtime/libksi/archive/v3.12.2010.tar.gz"
  sha256 "b6d0dff13e69a9ee12ef09701c0f50d275bcb1af54e4f465248a2e3fd361930e"

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build

  def install
    system "./rebuild.sh", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "false"
  end
end
