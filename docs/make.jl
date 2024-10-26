using Sole
using Documenter

DocMeta.setdocmeta!(Sole, :DocTestSetup, :(using Sole); recursive=true)

makedocs(;
    modules=[Sole],
    authors="Federico Manzella, Giovanni Pagliarini, Eduard I. Stan, Guido Sciavicco",
    repo=Documenter.Remotes.GitHub("aclai-lab", "Sole.jl"),
    sitename="Sole.jl",
    format=Documenter.HTML(;
        size_threshold = 4000000,
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://aclai-lab.github.io/Sole.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/aclai-lab/Sole.jl",
    devbranch = "dev",
    target = "build",
    branch = "gh-pages",
    versions = ["main" => "main", "stable" => "v^", "v#.#", "dev" => "dev"],
)
