orcid_test = '0000-0001-5643-4068'

test_that("orcid_api returns correctly", {
  json_resp = orcid_api_call(orcid)
  expect_equal(class(json_resp),'list')
  expect_equal(names(json_resp), c("last-modified-date", "group", "path"))
})
