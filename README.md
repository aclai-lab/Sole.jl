<div align="center"><a href="https://github.com/aclai-lab/Sole.jl"><img src="logo.png" alt="" title="This package is part of Sole.jl" width="200"></a></div>

# Sole.jl – Long live transparent modeling!
#### A framework for symbolic, transparent, and interpretable machine learning!

<!-- 
TODO:
[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://aclai-lab.github.io/Sole.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://aclai-lab.github.io/Sole.jl/dev)
 -->
<!-- [![Build Status](https://api.cirrus-ci.com/github/aclai-lab/Sole.jl.svg?branch=master)](https://cirrus-ci.com/github/aclai-lab/Sole.jl)
[![Coverage](https://codecov.io/gh/aclai-lab/Sole.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/aclai-lab/Sole.jl)
[![Coverage](https://coveralls.io/repos/github/aclai-lab/Sole.jl/badge.svg?branch=master)](https://coveralls.io/github/aclai-lab/Sole.jl?branch=master)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle) -->
<!-- [![ColPrac: Contributor's Guide on Collaborative Practices for Community Packages](https://img.shields.io/badge/ColPrac-Contributor's%20Guide-blueviolet)](https://github.com/SciML/ColPrac) -->



## Manifesto

Symbolic learning is machine learning based on symbolic logic. Its peculiarity lies in the fact that the learned models enclose an **explicit knowledge representation**, which offers many opportunities:
- Verifying that the model's thought process is adequate for a given task;
- Learning of new insights by simple inspection of the model;
- Manual refinement of the model at a later time.

These levels of **transparency** (or *interpretability*) are generally not available with standard machine learning methods, thus, as AI permeates more and more aspects of our lives, symbolic learning is becoming increasingly popular. In spite of this, implementations of symbolic algorithms (e.g., extraction of decision trees or rules) are mostly scattered across different languages and machine learning frameworks.

*Enough with this!* The lesser and lesser minoritarian theory of symbolic learning deserves a programming framework of its own!

#### JuliaCon2024 8-minute talk
<div align="center">
<a target="_blank" href="https://youtu.be/pfejOC_T5cQ">
  <img src="https://img.youtube.com/vi/pfejOC_T5cQ/0.jpg">
</a>
</div>

#### JuliaCon2023 30-minute talk
<div align="center">
<a target="_blank" href="https://youtu.be/HTRhOmQIObg">
  <img src="https://img.youtube.com/vi/HTRhOmQIObg/0.jpg">
</a>
</div>

## The Sole.jl framework

*Sole* is a collection of Julia packages for symbolic learning and reasoning.
Although at an embryonic stage, *Sole.jl* covers a range of functionality that is of interest for the symbolic community, but it also fills some gaps with a few functionalities for standard machine learning pipelines. At the time of writing, the framework comprehends the three core packages:
+ [*SoleLogics.jl*](https://github.com/aclai-lab/SoleLogics.jl) provides the **logical layer** for symbolic learning. It provides a useful codebase for [*computational logic*](https://en.wikipedia.org/wiki/Computational_logic), which features easy manipulation of:
	+ Propositional and (multi)modal logics (atoms, logical constants, alphabet, grammars, fuzzy algebras);
	+ [Logical formulas](https://en.wikipedia.org/wiki/Well-formed_formula) (random generation, parsing, minimization);
	+ [Logical interpretations](https://en.wikipedia.org/wiki/Interpretation_(logic)) (or models, e.g., [Kripke structures](https://en.wikipedia.org/wiki/Kripke_structure_(model_checking)));
	+ Algorithms for [model checking](https://en.wikipedia.org/wiki/Model_checking) (that is, checking that a formula is satisfied by an interpretation).
+ [*SoleData.jl*](https://github.com/aclai-lab/SoleData.jl) provides the **data layer** for representing *logisets*, that is, the logical counterpart to machine learning datasets:
 	+ Optimized data structures, useful when learning models from datasets;
        + Support for [multimodal data](https://en.wikipedia.org/wiki/Multimodal_learning).
+ [*SoleModels.jl*](https://github.com/aclai-lab/SoleModels.jl) defines the building blocks of **symbolic modeling**, featuring:
	+ Definitions for (logic-agnostic) symbolic models (mainly, decision rules/lists/trees/forests);
  + Basic rule extraction, evaluation and ispection algorithms;
  + Conversion from [DecisionTree.jl](https://github.com/JuliaAI/DecisionTree.jl) and [XGBoost.jl](https://github.com/dmlc/XGBoost.jl/);
	+ Support for mixed, neuro-symbolic computation.

Additional packages include:
+ [*ModalDecisionTrees.jl*](https://github.com/aclai-lab/ModalDecisionTrees.jl) which allows you to learn decision trees based on temporal logics on time-series datasets, and spatial logics on (small) image datasets;
+ [*ModalDecisionLists.jl*](https://github.com/aclai-lab/ModalDecisionLists.jl) which implements a sequential covering algorithm to learn decision lists;


## A first use case: inspecting decision trees

Ever wondered what to do with a trained [DecisionTree](https://github.com/JuliaAI/DecisionTree.jl)? Convert it to [Sole](https://github.com/aclai-lab/Sole.jl), and inspect its knowledge in terms of logical formulas!
- Evaluate them in terms of
  + accuracy (e.g., confidence, lift),
  + relevance (e.g., support),
  + interpretability (e.g., syntax height, number of atoms);
- Modify them;
- Merge them.

<!-- Note: this is a newly developed package; its potential is still unknown. -->

## Usage

### Converting to a Sole model

```julia
using MLJ
using MLJDecisionTreeInterface
using DataFrames
using Sole

X, y = @load_iris
X = DataFrame(X)

train, test = partition(eachindex(y), 0.8, shuffle=true);
X_train, y_train = X[train, :], y[train];
X_test, y_test = X[test, :], y[test];

# Train a model
learned_dt_tree = begin
  Tree = MLJ.@load DecisionTreeClassifier pkg=DecisionTree
  model = Tree(max_depth=-1, )
  mach = machine(model, X_train, y_train)
  fit!(mach)
  fitted_params(mach).tree
end

# Convert to Sole model
sole_dt = solemodel(learned_dt_tree)
```

### Model inspection & rule study


```julia-repl
julia> # Make test instances flow into the model, so that test metrics can, then, be computed.
       apply!(sole_dt, X_test, y_test);

julia> # Print Sole model
       printmodel(sole_dt; show_metrics = true);
▣ V4 < 0.8
├✔ setosa : (ninstances = 7, ncovered = 7, confidence = 1.0, lift = 1.0)
└✘ V3 < 4.95
 ├✔ V4 < 1.65
 │├✔ versicolor : (ninstances = 10, ncovered = 10, confidence = 1.0, lift = 1.0)
 │└✘ V2 < 3.1
 │ ├✔ virginica : (ninstances = 2, ncovered = 2, confidence = 1.0, lift = 1.0)
 │ └✘ versicolor : (ninstances = 0, ncovered = 0, confidence = NaN, lift = NaN)
 └✘ V3 < 5.05
  ├✔ V1 < 6.5
  │├✔ virginica : (ninstances = 0, ncovered = 0, confidence = NaN, lift = NaN)
  │└✘ versicolor : (ninstances = 0, ncovered = 0, confidence = NaN, lift = NaN)
  └✘ virginica : (ninstances = 11, ncovered = 11, confidence = 0.91, lift = 1.0)

julia> # Extract rules that are at least as good as a random baseline model
       interesting_rules = listrules(sole_dt, min_lift = 1.0, min_ninstances = 0);

julia> printmodel.(interesting_rules; show_metrics = true);
▣ (V4 < 0.8) ∧ (⊤)  ↣  setosa : (ninstances = 30, ncovered = 7, coverage = 0.23, confidence = 1.0, natoms = 1, lift = 4.29)
▣ (¬(V4 < 0.8)) ∧ (V3 < 4.95) ∧ (V4 < 1.65) ∧ (⊤)  ↣  versicolor : (ninstances = 30, ncovered = 10, coverage = 0.33, confidence = 1.0, natoms = 3, lift = 2.73)
▣ (¬(V4 < 0.8)) ∧ (V3 < 4.95) ∧ (¬(V4 < 1.65)) ∧ (V2 < 3.1) ∧ (⊤)  ↣  virginica : (ninstances = 30, ncovered = 2, coverage = 0.07, confidence = 1.0, natoms = 4, lift = 2.5)
▣ (¬(V4 < 0.8)) ∧ (¬(V3 < 4.95)) ∧ (¬(V3 < 5.05)) ∧ (⊤)  ↣  virginica : (ninstances = 30, ncovered = 11, coverage = 0.37, confidence = 0.91, natoms = 3, lift = 2.27)

julia> # Simplify rules while extracting and prettify result
       interesting_rules = listrules(sole_dt, min_lift = 1.0, min_ninstances = 0, normalize = true);

julia> printmodel.(interesting_rules; show_metrics = true, syntaxstring_kwargs = (; threshold_digits = 2));
▣ V4 < 0.8  ↣  setosa : (ninstances = 30, ncovered = 7, coverage = 0.23, confidence = 1.0, natoms = 1, lift = 4.29)
▣ (V4 ∈ [0.8,1.65)) ∧ (V3 < 4.95)  ↣  versicolor : (ninstances = 30, ncovered = 10, coverage = 0.33, confidence = 1.0, natoms = 2, lift = 2.73)
▣ (V4 ≥ 1.65) ∧ (V3 < 4.95) ∧ (V2 < 3.1)  ↣  virginica : (ninstances = 30, ncovered = 2, coverage = 0.07, confidence = 1.0, natoms = 3, lift = 2.5)
▣ (V4 ≥ 0.8) ∧ (V3 ≥ 5.05)  ↣  virginica : (ninstances = 30, ncovered = 11, coverage = 0.37, confidence = 0.91, natoms = 2, lift = 2.27)

julia> # Directly access rule metrics
       readmetrics.(listrules(sole_dt; min_lift=1.0, min_ninstances = 0))
4-element Vector{NamedTuple{(:ninstances, :ncovered, :coverage, :confidence, :natoms, :lift), Tuple{Int64, Int64, Float64, Float64, Int64, Float64}}}:
 (ninstances = 30, ncovered = 7, coverage = 0.23333333333333334, confidence = 1.0, natoms = 1, lift = 4.285714285714286)
 (ninstances = 30, ncovered = 10, coverage = 0.3333333333333333, confidence = 1.0, natoms = 3, lift = 2.7272727272727275)
 (ninstances = 30, ncovered = 2, coverage = 0.06666666666666667, confidence = 1.0, natoms = 4, lift = 2.5)
 (ninstances = 30, ncovered = 11, coverage = 0.36666666666666664, confidence = 0.9090909090909091, natoms = 3, lift = 2.2727272727272725)

julia> # Show rules with an additional metric (syntax height of the rule's antecedent)
       printmodel.(sort(interesting_rules, by = readmetrics); show_metrics = (; round_digits = nothing, additional_metrics = (; height = r->SoleLogics.height(antecedent(r)))));

▣ (V4 ≥ 1.65) ∧ (V3 < 4.95) ∧ (V2 < 3.1)  ↣  virginica : (ninstances = 30, ncovered = 2, coverage = 0.06666666666666667, confidence = 1.0, height = 2, lift = 2.5)
▣ V4 < 0.8  ↣  setosa : (ninstances = 30, ncovered = 7, coverage = 0.23333333333333334, confidence = 1.0, height = 0, lift = 4.285714285714286)
▣ (V4 ∈ [0.8,1.65)) ∧ (V3 < 4.95)  ↣  versicolor : (ninstances = 30, ncovered = 10, coverage = 0.3333333333333333, confidence = 1.0, height = 1, lift = 2.7272727272727275)
▣ (V4 ≥ 0.8) ∧ (V3 ≥ 5.05)  ↣  virginica : (ninstances = 30, ncovered = 11, coverage = 0.36666666666666664, confidence = 0.9090909090909091, height = 1, lift = 2.2727272727272725)

julia> # Pretty table of rules and their metrics
       metricstable(interesting_rules; metrics_kwargs = (; round_digits = nothing, additional_metrics = (; height = r->SoleLogics.height(antecedent(r)))))
┌────────────────────────────────────────┬────────────┬────────────┬──────────┬───────────┬────────────┬────────┬─────────┐
│                             Antecedent │ Consequent │ ninstances │ ncovered │  coverage │ confidence │ height │    lift │
├────────────────────────────────────────┼────────────┼────────────┼──────────┼───────────┼────────────┼────────┼─────────┤
│                               V4 < 0.8 │     setosa │         30 │        7 │  0.233333 │        1.0 │      0 │ 4.28571 │
│        (V4 ∈ [0.8,1.65)) ∧ (V3 < 4.95) │ versicolor │         30 │       10 │  0.333333 │        1.0 │      1 │ 2.72727 │
│ (V4 ≥ 1.65) ∧ (V3 < 4.95) ∧ (V2 < 3.1) │  virginica │         30 │        2 │ 0.0666667 │        1.0 │      2 │     2.5 │
│               (V4 ≥ 0.8) ∧ (V3 ≥ 5.05) │  virginica │         30 │       11 │  0.366667 │   0.909091 │      1 │ 2.27273 │
└────────────────────────────────────────┴────────────┴────────────┴──────────┴───────────┴────────────┴────────┴─────────┘
```

## Want to know more?
The formal foundations of the framework are given in [giopaglia](https://github.com/giopaglia/)'s PhD thesis:
[*Modal Symbolic Learning: from theory to practice*, G. Pagliarini (2024)](https://scholar.google.com/citations?view_op=view_citation&hl=en&user=FRo4yrcAAAAJ&citation_for_view=FRo4yrcAAAAJ:LkGwnXOMwfcC)

Additionally, there's a [10-hour PhD course on YouTube](https://www.youtube.com/playlist?list=PLyuPAlvJWIqLvYpGhenzXCA1JMW2HQwBv), as well as [material](https://github.com/aclai-lab/modal-symbolic-learning-course/) for it (including Jupyter Notebooks displaying symbolic AI workflows with Sole).

<!--
+ [*SoleFeatures.jl*](https://github.com/aclai-lab/SoleFeatures.jl) provides tools for filter-based **feature selection** on [*(un)structured* data](https://en.wikipedia.org/wiki/Unstructured_data). At this time, the package provides:
	+ 3 native feature selection methods, plus a wrapper around python implementations from *scikit-learn* and *scikit-feature*;
	+ Generalized feature selection methods that also apply to dimensional data (e.g., images or time-series), via a step of window-based flattening;
	+ Specific methods for time-series feature selection, based on [Catch22.jl](https://github.com/brendanjohnharris/Catch22.jl/);
	+ An easily extendible codebase, with abstraction layers similar to those of *scikit-learn*.
+ [*SolePostHoc.jl*](https://github.com/aclai-lab/SolePostHoc.jl) provides some tools for **analyzing and post-processing the learned symbolic models**. It features:
	+ Tools for inspecting and simplifying the models;
	+ Rule extraction from decision forests;
	+ Feature importance estimation.
  (e.g., feature selection on multimodal (un)structured data)
-->

<!-- Altogether, *Sole.jl* makes for a novel tool built with an eye to **formal correctness**, and is of use for both machine learning practitioners and computational logicians. -->

<!-- Link to https://github.com/Julia-XAI/ExplainableAI.jl -->

<!--
**Q:** Ok, so what symbolic learning methods do you people provide?
**A:** At the moment, [*ModalDecisionTrees.jl*](https://github.com/aclai-lab/ModalDecisionTrees.jl) is the only package compatible with Sole.jl, and it provides novel decision tree algorithms based on modal temporal and spatial logics for time-series and image classification. Checkout the related [talk at JuliaCon22](https://live.juliacon.org/talk/RQP9TG).

**Q:** Why the name?
**A:** *Sole* stands for SymbOlic LEarning; it also means "sun" in Italian, a hint to the enlightening power of transparent modeling.
-->

<!-- ![](Sole%20code%20organization.png "Code organization")
<p align="center">
  <img src="Sole%20code%20organization.png" alt="Code organization">
</p>
 -->

<!--
## Want to contribute?

Read these first:
* [Blue Code Style](https://github.com/invenia/BlueStyle);
* [ColPrac: Contributor's Guide on Collaborative Practices for Community Packages](https://github.com/SciML/ColPrac).
 -->

## About

The package is developed and maintained by the [ACLAI Lab](https://aclai.unife.it/en/) @ University of Ferrara.

Long live transparent modeling!
