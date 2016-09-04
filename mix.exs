defmodule Pkes.Mixfile do
  use Mix.Project

  def project do
    [app: :pkes,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     erlc_paths: ["test"],                # <- Erlang source files
     deps: deps]
  end

  def application do
    [applications: [:logger, :ranch],
     mod: {Pkes, []}] 
  end

  defp deps do
    [{:ranch, "~> 1.1"}]
  end
end
