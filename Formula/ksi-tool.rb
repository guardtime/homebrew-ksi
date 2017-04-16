# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class KsiTool < Formula
  desc "CLI for Keyless Signature Infrastructure (c) Guardtime"
  homepage "https://github.com/guardtime/ksi-tool"
  url "https://github.com/guardtime/ksi-tool/archive/v2.4.1038.tar.gz"
  sha256 "c551b0f0b2db7b79bb756dcef56eeae4a955d259daf679523108995c417f6198"

  # depends_on "cmake" => :build
  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "libksi" => :build


  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    # Remove unrecognized options if warned by configure
    # system "cmake", ".", *std_cmake_args
    system "./rebuild.sh", "--prefix=#{prefix}"
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test ksi-tool`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
