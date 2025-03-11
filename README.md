# DemoKin: Matrix-based Kinship Models

[![R-CMD-check](https://github.com/shajiang93/DemoKin_web/workflows/R-CMD-check/badge.svg)](https://github.com/shajiang93/DemoKin_web/actions)
[![pkgdown](https://github.com/shajiang93/DemoKin_web/workflows/pkgdown/badge.svg)](https://github.com/shajiang93/DemoKin_web/actions)

DemoKin is an R package for the demographic analysis of kinship networks using matrix-based models. It implements methods developed by Caswell and colleagues for estimating the number and age distribution of relatives under various demographic assumptions.

## Features

- Estimate kin counts and age distributions for various types of relatives
- Support for one-sex and two-sex models
- Time-invariant and time-varying approaches
- Multi-state models incorporating additional variables like parity or education
- Visualization tools for kinship networks

## Installation

You can install the development version of DemoKin from GitHub:

```r
# install.packages("remotes")
remotes::install_github("IvanWilli/DemoKin")
```

## Usage

Here's a basic example of how to use DemoKin:

```r
library(DemoKin)

# Run a one-sex time-invariant kinship model using Swedish data from 2015
kin_results <- kin(
  p = swe_px[,"2015"],        # Survival probabilities
  f = swe_asfr[,"2015"],      # Fertility rates
  time_invariant = TRUE       # Use time-invariant model
)

# Visualize the expected number of living relatives by age
kin_results$kin_summary %>%
  rename_kin() %>%
  ggplot(aes(age_focal, count_living)) +
  geom_line() +
  facet_wrap(~kin_label, scales = "free_y") +
  labs(
    title = "Expected number of living relatives by age",
    x = "Age of focal individual",
    y = "Number of relatives"
  )
```

## Documentation

For detailed documentation, please visit the [DemoKin website](https://shajiang93.github.io/DemoKin_web/).

The site includes several vignettes demonstrating different types of kinship models:

### Models stratified by age
- [One-sex time-invariant kinship model](https://shajiang93.github.io/DemoKin_web/articles/1_1_OneSex_TimeInvariant_Age.html)
- [One-sex time-varying kinship model](https://shajiang93.github.io/DemoKin_web/articles/1_2_OneSex_TimeVarying_Age.html)
- [Two-sex time-invariant kinship model](https://shajiang93.github.io/DemoKin_web/articles/1_3_TwoSex_TimeInvariant_Age.html)
- [Two-sex time-varying kinship model](https://shajiang93.github.io/DemoKin_web/articles/1_4_TwoSex_TimeVarying_Age.html)

### Models stratified by age and stage
- [One-sex time-invariant multi-state model](https://shajiang93.github.io/DemoKin_web/articles/2_1_OneSex_TimeInvariant_AgeStage.html)
- [Two-sex time-varying multi-state model](https://shajiang93.github.io/DemoKin_web/articles/2_2_TwoSex_TimeVarying_AgeStage.html)

## References

Caswell, H. (2019). The formal demography of kinship: A matrix formulation. Demographic Research, 41, 679-712.

Caswell, H. (2020). The formal demography of kinship II: Multistate models, parity, and sibship. Demographic Research, 42, 1097-1144.

Caswell, H. & Song, X. (2021). The formal demography of kinship III: Kinship dynamics with time-varying demographic rates. Demographic Research, 45, 517-546.

Caswell, H. & Song, X. (2022). The formal demography of kinship IV: Two-sex models and their approximations. Demographic Research, 47, 359-396.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
