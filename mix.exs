defmodule Taskwarrior.MixProject do
  use Mix.Project

  def project do
    [
      app: :taskwarrior,
      description: description(),
      package: package(),
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    """
    Parser and manipulator of Taskwarrior data
    """
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => repo_url()}
    ]
  end

  defp repo_url do
    "https://github.com/linduxed/taskwarrior.ex"
  end

  defp deps do
    []
  end
end
