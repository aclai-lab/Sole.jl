using Sole
using Documenter
using SoleBase
using SoleLogics
using SoleData
using SoleData
using SoleModels

DocMeta.setdocmeta!(Sole, :DocTestSetup, :(using Sole); recursive=true)
DocMeta.setdocmeta!(SoleBase, :DocTestSetup, :(using SoleBase); recursive=true)
DocMeta.setdocmeta!(SoleLogics, :DocTestSetup, :(using SoleLogics); recursive=true)
DocMeta.setdocmeta!(SoleData, :DocTestSetup, :(using SoleData); recursive=true)
DocMeta.setdocmeta!(SoleModels, :DocTestSetup, :(using SoleModels); recursive=true)

makedocs(;
    modules=[SoleBase, SoleLogics, SoleData, SoleData.DimensionalDatasets, SoleModels],
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
    target = "build",
    branch = "gh-pages",
    versions = ["main" => "main", "stable" => "v^", "v#.#", "dev" => "dev"],
)
