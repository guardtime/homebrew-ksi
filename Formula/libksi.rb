class Libksi < Formula
  desc "C SDK for Keyless Signature Infrastructure (c) Guardtime"
  homepage "https://github.com/guardtime/libksi"
  url "https://github.com/guardtime/libksi/archive/v3.15.2306.tar.gz"
  sha256 "09a173f2101db4dc6d31e535850d6bfdeb9478bfbb96baae506c9842d24dda41"

  # Change revision if there is a need to recompile the formula
  # and the version of the package is not changed. If version
  # changes comment 'revision' field out.
  revision 3

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
    (testpath/"test.c").write <<-EOS.undent
      #include <ksi/ksi.h>
      #include <assert.h>
      int main()
      {
        KSI_CTX *ksi = NULL;
        assert(KSI_CTX_new(&ksi) == KSI_OK);
        KSI_CTX_free(ksi);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}",
                   "-lksi", "-o", "test"
    system "./test"
  end
end
