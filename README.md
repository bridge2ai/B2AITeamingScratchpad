
<!-- README.md is generated from README.Rmd. Please edit that file -->

# B2AITeamingScratchpad

<!-- badges: start -->
<!-- badges: end -->

## Installation

You can install the development version of B2AITeamingScratchpad like
so:

``` r
library(remotes)
remotes::install_github('bridge2ai/B2AITeamingScratchpad')
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(B2AITeamingScratchpad)
```

### Fetch all publications by orcid

``` r
orcid_example = '0000-0002-8991-6458'
works_df = works_from_orcid(orcid_example)
```

The result is a data.frame with some minimal information about each
publication.

``` r
colnames(works_df)
#> [1] "title"    "doi"      "pmid"     "pmc"      "put_code" "orcid"
dim(works_df)
#> [1] 98  6
head(works_df)
#>                                                                                                                              title
#> 1 GenomicSuperSignature facilitates interpretation of RNA-seq experiments through robust, efficient comparison to public databases
#> 2       HGNChelper: identification and correction of invalid gene symbols for human and mouse [version 2; peer review: 3 approved]
#> 3                                                                                 Ten simple rules for large-scale data processing
#> 4            GenomicSuperSignature: interpretation of RNA-seq experiments through robust, efficient comparison to public databases
#> 5                                            HGNChelper: identification and correction of invalid gene symbols for human and mouse
#> 6                                            HGNChelper: identification and correction of invalid gene symbols for human and mouse
#>                              doi pmid  pmc  put_code               orcid
#> 1     10.1038/s41467-022-31411-3 <NA> <NA> 115044512 0000-0002-8991-6458
#> 2 10.12688/f1000research.28033.2 <NA> <NA>  85614478 0000-0002-8991-6458
#> 3   10.1371/journal.pcbi.1009757 <NA> <NA> 107995204 0000-0002-8991-6458
#> 4      10.1101/2021.05.26.445900 <NA> <NA>  94544767 0000-0002-8991-6458
#> 5 10.12688/f1000research.28033.1 <NA> <NA>  85615672 0000-0002-8991-6458
#> 6      10.1101/2020.09.16.300632 <NA> <NA>  83594630 0000-0002-8991-6458
```

### Fetch details about one of the publications

``` r
work_details = orcid_work_detail(orcid_example, works_df$put_code[6])
dplyr::glimpse(work_details)
#> Rows: 1
#> Columns: 13
#> $ orcid          <chr> "0000-0002-8991-6458"
#> $ put_code       <int> 83594630
#> $ created_at     <dttm> 2020-11-17 11:45:46
#> $ updated_at     <dttm> 2022-05-31 08:33:36
#> $ citation_type  <chr> "bibtex"
#> $ citation_value <chr> "@article{Oh_2020,\n\tdoi = {10.1101/2020.09.16.300632}…
#> $ work_type      <chr> "other"
#> $ contributors   <lgl> NA
#> $ url            <chr> "https://doi.org/10.1101/2020.09.16.300632"
#> $ doi            <chr> "10.1101/2020.09.16.300632"
#> $ pmid           <lgl> NA
#> $ pmc            <lgl> NA
#> $ abstract       <lgl> NA
```

## Bridge2AI Expertise analysis

See the [vignettes directory](vignettes).

## The Bridge2AI Program

The NIH Common Fund’s Bridge to Artificial Intelligence (Bridge2AI)
program will propel biomedical research forward by setting the stage for
widespread adoption of artificial intelligence (AI) that tackles complex
biomedical challenges beyond human intuition. A key step in this process
is generating new “flagship” data sets and best practices for machine
learning analysis. Machine learning is a type of Artificial Intelligence
(AI) that provides machines (like computers) the ability to
automatically learn and improve from experience, without being
explicitly programmed. The biomedical research community generates a
wealth of data, but most of these data are not suitable for machine
learning because they are incomplete. By bringing technological and
biomedical experts together with social scientists and humanists, the
Bridge2AI program will help bring solutions to this deficit by:

- Generating new flagship biomedical and behavioral data sets that are
  ethically sourced, trustworthy, well-defined, and accessible
- Developing software and standards to unify data attributes across
  multiple data sources and across data types
- Creating automated tools to accelerate the creation of FAIR (Findable,
  Accessible, Interoperable, and Reusable) and ethically sourced data
  sets
- Providing resources to disseminate data, ethical principles, tools,
  and best practices
- Creating training materials and activities for workforce development
  that bridges the AI, biomedical, and behavioral research communities
