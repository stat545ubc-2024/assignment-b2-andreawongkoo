test_that("Output matches direct call to dplyr", {
  # Creates a test tibble with some NA values
  modified_tbl <- tibble::tribble(~group, ~var1, ~var2,
                                  "X", NA, 5,
                                  "X", 3, NA,
                                  "Y", 1, 4,
                                  "Z", NA, 2)
  
  # Tests if our function matches dplyr's direct output with .groups = "drop"
  expect_equal(modified_tbl |> dplyr::group_by(group) |>
                 dplyr::summarize(dplyr::across(everything(), ~sum(is.na(.x))),
                                  .groups = "drop"),
               count_all_missing_by_group(modified_tbl, group)
  )
  
  # Tests if our function matches dplyr's direct output with .groups = NULL
  expect_equal(modified_tbl |> dplyr::group_by(group) |>
                 dplyr::summarize(dplyr::across(everything(), ~sum(is.na(.x))),
                                  .groups = NULL),
               count_all_missing_by_group(modified_tbl, group, NULL)
  )
})

test_that("Handles invalid .groups input gracefully", {
  # Checks if the function throws an error for invalid .groups option
  expect_error(
    count_all_missing_by_group(iris, Species, "invalid_option")
  )
  # Checks if the function doesn't throw an error for NULL .groups option
  expect_no_error(
    count_all_missing_by_group(iris, Species, NULL)
  )
})

test_that("Handles missing values correctly with test data", {
  # Creates a test dataset (as tibble) with missing values
  test_data <- tibble::tibble(
    group = c("A", "A", "B", "B", "C"),
    var1 = c(NA, 2, NA, NA, 5),
    var2 = c(1, NA, 3, NA, NA)
  )
  
  # Defines the expected result
  expected_result <- tibble::tibble(
    group = c("A", "B", "C"),
    var1 = c(1, 2, 0),
    var2 = c(1, 1, 1)
  )
  
  # Tests if the function produces the expected result
  expect_equal(count_all_missing_by_group(test_data, group), expected_result)
})

test_that("Handles groups with no missing values", {
  # Creates a test dataset (as tibble) with no missing values
  test_data <- tibble::tibble(
    group = c("A", "B", "C"),
    var1 = c(1, 5, 3),
    var2 = c("x", "y", "z")
  )
  
  # Defines the expected output
  expected_output <- tibble::tibble(
    group = c("A", "B", "C"),
    var1 = c(0, 0, 0),
    var2 = c(0, 0, 0)
  )
  
  # Tests if the function correctly handles data with no missing values
  expect_equal(count_all_missing_by_group(test_data, group), expected_output)
})

test_that("Works with a data frame containing a single row", {
  # Creates a test dataset (as tibble) with a single row
  single_row_data <- tibble::tibble(
    group = "B",
    var1 = NA,
    var2 = 3
  )
  
  # Defines the expected output for single row data
  expected_single_row_output <- tibble::tibble(
    group = "B",
    var1 = 1,
    var2 = 0
  )
  
  # Tests if the function works correctly with a single row
  expect_equal(count_all_missing_by_group(single_row_data, group), expected_single_row_output)
})

test_that("Function works with empty data frame", {
  # Creates an empty data frame (as tibble)
  empty_df <- tibble::tibble(group = character(), var1 = numeric(), var2 = numeric())
  
  # Tests if the function handles an empty data frame correctly
  expect_equal(count_all_missing_by_group(empty_df, group), tibble::tibble(group = character(), var1 = numeric(), var2 = numeric()))
})