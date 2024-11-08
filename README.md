
<!-- README.md is generated from README.Rmd. Please edit that file -->

# countmissingtool

<!-- badges: start -->
<!-- badges: end -->

The goal of `countmissingtool` is to simplify the assessment of missing
data across groups. The `count_all_missing_by_group()` function counts
missing values by group across, and returns a summary table with one row
per group for quick insights.

## Installation Instructions

You can install the development version of `countmissingtool` from
[GitHub](https://github.com/) as follows:

1.  If you haven’t already, install `devtools` package:

`install.packages("devtools")`

2.  Install `countmissingtool` from Github in the R console:

`devtools::install_github("stat545ubc-2024/countmissingtool", ref = "1.0.2")`

## Example Usage

### Example 1: Count Missing Values by Group with different datasets

This example demonstrates how to count missing values in the R built-in
datasets `mtcars` and `airquality`, grouped by the `am` (transmission
type) and `Month` (month of the year) columns, respectively.

``` r
library(countmissingtool) # To load the package

# Count missing values by the `am` column in the `mtcars` dataset
count_all_missing_by_group(mtcars, am)
#> # A tibble: 2 × 11
#>      am   mpg   cyl  disp    hp  drat    wt  qsec    vs  gear  carb
#>   <dbl> <int> <int> <int> <int> <int> <int> <int> <int> <int> <int>
#> 1     0     0     0     0     0     0     0     0     0     0     0
#> 2     1     0     0     0     0     0     0     0     0     0     0
```

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

In both cases, the function will return a summary table as a tibble
(dataframe) with one row for each group (transmission type or month),
showing the count of missing values for each column in the dataset. This
helps you quickly assess missing data patterns across different groups.

### Example 2: Handle Special Grouping Options

If you’d like to keep the grouping structure in the output, you can
optionally specify the `.groups` argument. For instance, setting
`.groups = "keep"` retains the grouping structure after summarizing the
missing values.

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

This ensures that the result is still grouped by `Month`, which might be
useful if you plan to perform additional operations on the summarized
data.

There are also other possible actions available for handling grouping
detailed in the function documentation, including: `"drop_last"`,
“`drop"`, and `"rowwise"`. See the [countmissingtool.R
file](https://github.com/stat545ubc-2024/assignment-b2-andreawongkoo/tree/b5d61e016d58da9863756bf89600c5edad3cd071/R)
for more details.
