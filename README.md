
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

You can install the development version of `countmissing` from
[GitHub](https://github.com/) as follows:

1.  If you haven’t already, install `devtools` package:

`install.packages("devtools")`

2.  Install `countmissing` from GitHub:

`devtools::install_github("stat545ubc-2024/assignment-b2-andreawongkoo", ref = "0.1.0")`

## Example Usage

### Example 1: Count Missing Values in mtcars by Transmission Type

This example demonstrates how to count the missing values for each
column of the R built-in `mtcars` dataset, grouped by the `am` column,
which represents the type of transmission (automatic vs. manual).

``` r
library(countmissing)

# Count missing values by the `am` column in the `mtcars` dataset
count_all_missing_by_group(mtcars, am)
#> # A tibble: 2 × 11
#>      am   mpg   cyl  disp    hp  drat    wt  qsec    vs  gear  carb
#>   <dbl> <int> <int> <int> <int> <int> <int> <int> <int> <int> <int>
#> 1     0     0     0     0     0     0     0     0     0     0     0
#> 2     1     0     0     0     0     0     0     0     0     0     0
```

This will return a summary showing the count of missing values in each
column for each transmission type (`am`), helping you quickly assess
data quality across different groups.

### Example 2: Analyze Missing Data by Month in the airquality Dataset

You can also use the function to check missing data patterns in
different subsets of a dataset. Here, we analyze the R built-in
`airquality` dataset, grouping by the `Month` column.

``` r
# Count missing values by the `Month` column in `airquality`
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

In this case, the function will summarize the missing values for each
month, allowing you to understand potential missing data patterns over
time.

### Example 3: Handle Special Grouping Options

If you’d like to keep the grouping structure in the output, you can
specify the `.groups` argument. For instance, setting .groups = “keep”
retains the grouping structure after summarizing the missing values.

``` r
# Count missing values by `Month` and keep grouping structure
count_all_missing_by_group(airquality, Month, .groups = "keep")
#> # A tibble: 5 × 6
#> # Groups:   Month [5]
#>   Month Ozone Solar.R  Wind  Temp   Day
#>   <int> <int>   <int> <int> <int> <int>
#> 1     5     5       4     0     0     0
#> 2     6    21       0     0     0     0
#> 3     7     5       0     0     0     0
#> 4     8     5       3     0     0     0
#> 5     9     1       0     0     0     0
```

This ensures that the result is still grouped by Month, which might be
useful if you plan to perform additional operations on the summarized
data.
