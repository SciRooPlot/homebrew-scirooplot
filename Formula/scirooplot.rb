class Scirooplot < Formula
  desc "A command-line plotting app to manage and visualize scientific data."
  license "GPL-3.0-or-later"

  version "3.2.3"
  homepage "https://github.com/SciRooPlot/SciRooPlot"
  head "#{homepage}.git", branch: "master"
  url "#{homepage}/archive/refs/tags/v#{version}.tar.gz"
  sha256 "4b83b7c99bda5352cd4f02745ea21a587c6bab9bb7e6333ac621f7af5869ab9f"

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
