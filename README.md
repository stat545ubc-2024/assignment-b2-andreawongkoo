
<!-- README.md is generated from README.Rmd. Please edit that file -->

# countmissing

<!-- badges: start -->
<!-- badges: end -->

The goal of `countmissing` is to provide a simple and effective way to
count missing values in all columns of a data frame, grouped by a
specified variable. The `count_all_missing_by_group()` function returns
a summary table with one row per group level, helping users assess
missing data patterns across grouped subsets.

## Installation

You can install the development version of countmissing from GitHub as
follows:

### Install devtools if you haven’t already

`if (!requireNamespace("devtools", quietly = TRUE)) {   install.packages("devtools") }`

### Install countmissing from GitHub

`devtools::install_github("andreawongkoo/countmissing", ref = "0.1.0")`

## Example

This is a basic example that demonstrates how to use
`count_all_missing_by_group()` to count missing values by group in the
built-in `mtcars` R dataset:

``` r
library(countmissing)

# Example: Count missing values by the `am` column in mtcars
count_all_missing_by_group(mtcars, am)
#> # A tibble: 2 × 11
#>      am   mpg   cyl  disp    hp  drat    wt  qsec    vs  gear  carb
#>   <dbl> <int> <int> <int> <int> <int> <int> <int> <int> <int> <int>
#> 1     0     0     0     0     0     0     0     0     0     0     0
#> 2     1     0     0     0     0     0     0     0     0     0     0
```

The `count_all_missing_by_group()` function makes it easy to summarize
missing values across grouped data. For instance, you can use it to
analyze missing data within specific categories, such as different
months in the in-built `airquality` R dataset:

``` r
count_all_missing_by_group(airquality, Month)
#> # A tibble: 5 × 6
#>   Month Ozone Solar.R  Wind  Temp   Day
#>   <int> <int>   <int> <int> <int> <int>
#> 1     5     5       4     0     0     0
#> 2     6    21       0     0     0     0
#> 3     7     5       0     0     0     0
#> 4     8     5       3     0     0     0
#> 5     9     1       0     0     0     0
```

What is special about using README.Rmd instead of just README.md? You
can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll need to render README.Rmd regularly to keep README.md up-to-date.
The `devtools::build_readme()` function is handy for this.

You can also embed plots, for example:

``` r
plot(pressure)
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" /> In
that case, don’t forget to commit and push the resulting figure files so
they display on GitHub and CRAN.
