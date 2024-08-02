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

#### JuliaCon 2023 30-minute talk

<!-- [![](https://img.youtube.com/vi/HTRhOmQIObg/0.jpg)](https://youtu.be/HTRhOmQIObg) -->
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
	+ Support for mixed, neuro-symbolic computation.

Additional packages include:
+ [*SoleDecisionTreeInterface.jl*](https://github.com/aclai-lab/SoleDecisionTreeInterface.jl), which enables the use of Sole on decision trees learned via [DecisionTree.jl](https://github.com/JuliaAI/DecisionTree.jl) (e.g., extract and evaluate rules);
+ [*ModalDecisionTrees.jl*](https://github.com/aclai-lab/ModalDecisionTrees.jl) which allows you to learn decision trees based on temporal logics on time-series datasets, and spatial logics on (small) image datasets;
+ [*ModalDecisionLists.jl*](https://github.com/aclai-lab/ModalDecisionLists.jl) which implements a sequential covering algorithm to learn decision lists;

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
