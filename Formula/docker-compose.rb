class Trantor < Formula
  desc "Terminus Trantor CLI"
  homepage "https://www.terminus.io/"
  url "http://mxsl.oss-cn-hangzhou.aliyuncs.com/dist/trantor/trantor.0.0.1.tar.gz"
  version "0.0.1"
  sha256 "6cbd81d22ce95954366bf81c003d818b33f33929a45e65d87a61b3e560425576"

  depends_on "docker"

  def install
    # Remove windows files
    lib.install Dir["lib/*"]
    libexec.install Dir["libexec/*"]

    Pathname.glob("#{libexec}/bin/*.sh") do |path|
      script_name = path.basename
      bin_name    = path.basename ".sh"
      (bin+bin_name).write shim_script(script_name)
    end
    rm_f Dir["libexec/bin"]
  end

  test do
    system "#{bin}/trantor", "version"
  end

end
