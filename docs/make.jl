using Sole
using Documenter

DocMeta.setdocmeta!(Sole, :DocTestSetup, :(using Sole); recursive=true)

makedocs(;
    modules=[Sole],
    authors="Eduard I. STAN, Giovanni PAGLIARINI",
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
)
