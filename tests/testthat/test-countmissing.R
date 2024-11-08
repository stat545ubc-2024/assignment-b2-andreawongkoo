test_that("Output matches direct call to dplyr with modified inputs", {
  modified_tbl <- tribble(~group, ~var1, ~var2,
                          "X", NA, 5,
                          "X", 3, NA,
                          "Y", 1, 4,
                          "Z", NA, 2)

  expect_equal(modified_tbl |> group_by(group) |>
                 summarize(across(everything(), ~sum(is.na(.x))),
                           .groups = "drop"),
               count_all_missing_by_group(modified_tbl, group)
  )

  expect_equal(modified_tbl |> group_by(group) |>
                 summarize(across(everything(), ~sum(is.na(.x))),
                           .groups = NULL),
               count_all_missing_by_group(modified_tbl, group, NULL)
  )
})

test_that("Handles invalid .groups input gracefully", {
  expect_error(
    count_all_missing_by_group(iris, Species, "invalid_option")
  )
  expect_no_error(
    count_all_missing_by_group(iris, Species, NULL)
  )
})

test_that("Handles missing values correctly with test data", {
  test_data <- tibble(
    group = c("A", "A", "B", "B", "C"),
    var1 = c(NA, 2, NA, NA, 5),
    var2 = c(1, NA, 3, NA, NA)
  )

  expected_result <- tibble(
    group = c("A", "B", "C"),
    var1 = c(1, 2, 0),
    var2 = c(1, 1, 1)
  )

  expect_equal(count_all_missing_by_group(test_data, group), expected_result)
})


test_that("Handles groups with no missing values", {
  test_data <- tibble(
    group = c("A", "B", "C"),
    var1 = c(1, 5, 3),
    var2 = c("x", "y", "z")
  )

  expected_output <- tibble(
    group = c("A", "B", "C"),
    var1 = c(0, 0, 0),
    var2 = c(0, 0, 0)
  )

  expect_equal(count_all_missing_by_group(test_data, group), expected_output)
})

test_that("Works with a data frame containing a single row", {
  single_row_data <- tibble(
    group = "B",
    var1 = NA,
    var2 = 3
  )

  expected_single_row_output <- tibble(
    group = "B",
    var1 = 1,
    var2 = 0
  )

  expect_equal(count_all_missing_by_group(single_row_data, group), expected_single_row_output)
})

test_that("Function works with empty data frame", {
  empty_df <- tibble(group = character(), var1 = numeric(), var2 = numeric())

  expect_equal(count_all_missing_by_group(empty_df, group), tibble(group = character(), var1 = numeric(), var2 = numeric()))
})


