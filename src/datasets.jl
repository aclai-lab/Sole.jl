using DataFrames
using CategoricalArrays
using CSV
using OrderedCollections

"""
Dumb utility function to preprocess input data:
    * remove duplicated rows
    * remove rows with missing values
"""
function preprocess_inputdata(
    X::AbstractDataFrame,
    y;
    remove_duplicate_rows = false
)
    if remove_duplicate_rows
        allunique(X) && return (X, y)
        nonunique_ind = nonunique(X)
        Xy = hcat( X[findall((!).(nonunique_ind)), :],
                   y[findall((!).(nonunique_ind))]
        ) |> dropmissing
    else
        Xy = hcat(X[:, :], y[:]) |> dropmissing
    end
    return Xy[:, 1:(end-1)], Xy[:, end]
end

module_dir = @__DIR__

datasets_info = [

    (name_str = "biopsy.csv",
        name_symbol = :B,
        target_c = :Class,
        to_exclude = [:Class, :ID]),

    (name_str = "ionosphere.csv",
        name_symbol = :I,
        target_c = :Class,
        to_exclude = [:Class]),

    (name_str = "mobile-price.csv",
        name_symbol = :M,
        target_c = :price_range,
        to_exclude = [:price_range]),

    (name_str = "yeast.csv",
        name_symbol = :Y,
        target_c = :localization_site,
        to_exclude = [:localization_site, :Sequence_Name]),

    (name_str = "abalone.csv",
        name_symbol = :A,
        target_c = :Rings,
        to_exclude = [:Rings]),
]

function subset_datasets(keys = [:B, :I, :M, :Y, :A])
    map(di -> begin
        datatable = CSV.read((joinpath(module_dir, "src", "datasets", di.name_str)), DataFrame)
        y = datatable[:, di.target_c] |> CategoricalArray
        X = DataFrames.select(datatable, Not(di.to_exclude));

            X, y = preprocess_inputdata(X,y)
            (di.name_symbol => (X, y))

    end, filter(di->di.name_symbol in keys, datasets_info)) |> OrderedDict
end
