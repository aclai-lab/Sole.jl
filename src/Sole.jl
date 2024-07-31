module Sole

using Reexport

@reexport using SoleBase

@reexport using SoleLogics
@reexport using SoleData
@reexport using SoleModels

using SoleModels: load_arff_dataset

include("datasets.jl")

# using SoleFeatures

# using SolePostHoc

end
