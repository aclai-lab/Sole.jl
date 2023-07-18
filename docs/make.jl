using Sole
using Documenter

DocMeta.setdocmeta!(Sole, :DocTestSetup, :(using Sole); recursive=true)

makedocs(;
    modules=[Sole],
    authors="Federico Manzella, Giovanni Pagliarini, Eduard I. Stan, Guido Sciavicco",
    repo="https://github.com/aclai-lab/Sole.jl/blob/{commit}{path}#{line}",
    sitename="Sole.jl",
    format=Documenter.HTML(;
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
    target = "build",
    branch = "gh-pages",
    versions = ["main" => "main", "stable" => "v^", "v#.#", "dev" => "dev"],
)
