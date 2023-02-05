library(testthat)

# this orcid has pmc, doi, and pmid values, so use for convenience
# many orcids will not have any pmid or pmc values
orcid_test = '0000-0001-5643-4068'
works_df = works_from_orcid(orcid_test)

test_that("works_from_orcid returns correct structure", {
  # get a data.frame
  expect_s3_class(works_df, 'data.frame')

  # six columns
  expect_equal(ncol(works_df),6)

  # check column names
  expect_identical(colnames(works_df),c('title','doi','pmid','pmc','put_code','orcid'))

  # at least one doi is not NA
  expect_gt(sum(!is.na(works_df$doi)),0)

  # at leasd one pmid is not NA
  expect_gt(sum(!is.na(works_df$pmid)),0)

  # at least one pmc is not NA
  expect_gt(sum(!is.na(works_df$pmc)),0)

  # no NA put_codes
  expect_equal(sum(is.na(works_df$put_code)),0)

  # double-check that return orcid matches input
  expect_equal(works_df$orcid[1], orcid_test)
})
