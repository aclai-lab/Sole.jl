# *Sole.jl* – Long live transparent modeling!
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

These levels of **transparency** (or *interpretability*) are generally not available with standard machine learning methods, thus, as AI permeates more and more aspects of our lives, symbolic learning is becoming increasingly popular. In spite of this, implementations of symbolic algorithms (e.g, extraction of decision trees or rules) are mostly scattered across different languages and machine learning frameworks.

*Enough with this!* The lesser and lesser minoritarian theory of symbolic learning deserves a programming framework of its own!

## *Sole.jl*

*Sole.jl* is a collection of Julia packages for symbolic learning and reasoning; *Sole.jl* covers **a relatively wide range of functionality** that is of interest for the symbolic community, but it also fills some gaps with a few functionalities for standard machine learning pipelines (e.g., feature selection on multimodal (un)structured data). At the time of writing, the framework comprehends the following packages:
+ [*SoleLogics.jl*](https://github.com/aclai-lab/SoleLogics.jl) lays the **logical foundations** for symbolic learning. It provides a useful codebase for [*computational logic*](https://en.wikipedia.org/wiki/Computational_logic), which features easy manipulation of:
	+ Propositional and (multi)modal logics (propositions, logical constants, alphabet, grammars, fuzzy algebras);
	+ [Logical formulas](https://en.wikipedia.org/wiki/Well-formed_formula) (random generation, parsing, minimization);
	+ [Logical interpretations](https://en.wikipedia.org/wiki/Interpretation_(logic)) (or models, e.g., [Kripke structures](https://en.wikipedia.org/wiki/Kripke_structure_(model_checking)));
	+ Algorithms for [model checking](https://en.wikipedia.org/wiki/Model_checking) (that is, checking that a formula is satisfied by an interpretation).
+ [*SoleData.jl*](https://github.com/aclai-lab/SoleData.jl) provides a **data layer** built on top of DataFrames.jl/Tables.jl. Its codebase is machine learning oriented and allows to:
	+ Instantiate and manipulate [*multimodal*](https://en.wikipedia.org/wiki/Multimodal_learning) datasets for (un)supervised machine learning;
	+ Deal with [*(un)structured* data](https://en.wikipedia.org/wiki/Unstructured_data) (e.g., graphs, images, time-series, etc.);
	+ Describe datasets via basic statistical measures;
	+ Save to/load from *npy/npz* format, as well as a custom CSV-based format (with interesting features such as *lazy loading* of datasets);
	+ Perform basic data processing operations (e.g., windowing, moving average, etc.).
+ [*SoleFeatures.jl*](https://github.com/aclai-lab/SoleFeatures.jl) provides tools for filter-based **feature selection** on [*(un)structured* data](https://en.wikipedia.org/wiki/Unstructured_data). At this time, the package provides:
	+ 3 native feature selection methods, plus a wrapper around python implementations from *scikit-learn* and *scikit-feature*;
	+ Generalized feature selection methods that also apply to dimensional data (e.g., images or time-series), via a step of window-based flattening;
	+ Specific methods for time-series feature selection, based on [Catch22.jl](https://github.com/brendanjohnharris/Catch22.jl/);
	+ An easily extendible codebase, with abstraction layers similar to those of *scikit-learn*.
+ [*SoleModels.jl*](https://github.com/aclai-lab/SoleModels.jl) defines the building blocks of **symbolic modeling and learning**. It is the core of the framework, and it features:
	+ Definitions for symbolic models (decision trees/forests, rules, etc.);
	+ Optimized data structures, useful when learning models from datasets;
	+ Support for mixed, neuro-symbolic computation.
+ [*SolePostHoc.jl*](https://github.com/aclai-lab/SolePostHoc.jl) provides some tools for **analyzing and post-processing the learned symbolic models**. It features:
	+ Tools for inspecting and simplifying the models;
	+ Rule extraction from decision forests;
	+ Feature importance estimation.

Altogether, *Sole.jl* makes for a powerful tool built with an eye to **formal correctness**, and is of use for both machine learning practitioners and computational logicians.

**Q:** Ok, so what symbolic learning methods do you people provide?
**A:** At the moment, [*ModalDecisionTrees.jl*](https://github.com/giopaglia/ModalDecisionTrees.jl) is the only package compatible with Sole.jl, and it provides novel decision tree algorithms based on multimodal temporal and spatial logics for time-series and image classification. Checkout the related [talk at JuliaCon22](https://live.juliacon.org/talk/RQP9TG).

**Q:** Why the name?
**A:** *Sole* stands for SymbOlic LEarning; it also means "sun" in Italian, a hint to the enlightening power of transparent modeling.

## About

The package is developed by the [ACLAI Lab](https://aclai.unife.it/en/) @ University of Ferrara.

Long live transparent modeling!
