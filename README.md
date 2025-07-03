# One-Parameter Credit Risk Model

This repository provides an implementation and exploration of the model presented in the paper [*A One-Parameter Representation of Credit Risk and Transition Matrices*](https://www.z-riskengine.com/media/hqtnwlmb/a-one-parameter-representation-of-credit-risk-and-transition-matrices.pdf) by Belkin, Suchower, and Forest. The model introduces a systematic credit factor `Z` that captures the dynamics of credit rating transitions using a single parameter.

## Overview

Traditional credit risk models often rely on complex multi-factor systems to estimate rating migrations and default probabilities. This repository **one-factor model** where:

- Creditworthiness changes are modeled as a standard normal variable `X`
- `X` is decomposed into:
  - An **idiosyncratic component** `Y` (borrower-specific)
  - A **systematic component** `Z` (shared across borrowers)
- Transition matrices are derived by "binning" values of `X` based on historical transition probabilities

This approach allows for:
- Conditional transition matrices given a value of `Z`
- Stress testing and scenario analysis by varying `Z`

## Resources

The Credit-Metrics-Resources.xlsx provides several of the transition matrices discussed in the paper as well as an excel implementation of the model.

The Credit-Metrics-Rscript provides a R implementation of the model.

# References

Belkin, B., Suchower, S., & Forest, L. (1998). [A One-Parameter Representation of Credit Risk and Transition Matrices.](https://www.z-riskengine.com/media/hqtnwlmb/a-one-parameter-representation-of-credit-risk-and-transition-matrices.pdf)