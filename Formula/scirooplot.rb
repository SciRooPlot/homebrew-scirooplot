class Scirooplot < Formula
  desc "A command-line plotting app to manage and visualize scientific data."
  license "GPL-3.0-or-later"

  version "3.2.2"
  homepage "https://github.com/SciRooPlot/SciRooPlot"
  head "#{homepage}.git", branch: "master"
  url "#{homepage}/archive/refs/tags/v#{version}.tar.gz"
  sha256 "10cee4b5d11d6ab3e2b678b94100abd8df8117e8f68f7b6be534a38d23f68289"

  depends_on "cmake"
  depends_on "python"
  depends_on "pybind11"
  depends_on "fmt"
  depends_on "boost"
  depends_on "root"

  def install
    system "cmake", "-S", ".", "-B", "build",
           "-DCMAKE_BUILD_TYPE=Release",
           *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"srp", "info"
  end

  def caveats
    <<~EOS
      To activate SciRooPlot (best place it in ~/.zshrc or ~/.bashrc):

        source $(brew --prefix scirooplot)/share/scirooplot/scirooplot-env.sh
    EOS
  end
end
