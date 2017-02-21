Hack Oregon Transportation Data Cleaning / Geocoding
================

Source data
-----------

The original source data came from the City of Portland. We received two PDFs for "grind and pave" projects, which appear to contain identical tables. We converted them manually to the CSV files here using [Tabula](http://tabula.technology/). If we receive more PDFs, Tabula has a command-line option that can be scripted from most higher-level languages, including both Python and R.

The remainder of the files were received as comma-separated-value (CSV) files. The process of uploading them to Google Drive and downloading them again converted them to Microsoft Excel(.xlsx) format. We converted them back to the CSV files here manually using LibreOffice. Again, if we receive more such files we can automate the processing.

Tidying the data
----------------

Once converted to CSV, inspection shows that the data are in multiple formats. The geocoding process requires a tidy set of inputs, so we define a tidy format and populate it with data from the files.

### Inputs

First, we import the CSV files to individual data frames.

``` r
if(!require(readr)) install.packages("readr")
```

    ## Loading required package: readr

``` r
library(readr)
Pavement_Moratorium <- read_csv(
  "/home/Projects/postgis-geocoder-test/Data/Pavement Moratorium.csv",
  col_types = cols(
    `Moratorium End Date` = col_date(format = "%m/%d/%Y"),
    OBJECTID = col_character(), 
    `Treatment Date` = col_date(format = "%m/%d/%Y")))
print(Pavement_Moratorium)
```

    ## # A tibble: 109 × 7
    ##    OBJECTID `Project#`                       Street        `From Street`
    ##       <chr>      <chr>                        <chr>                <chr>
    ## 1      1166       <NA>      Se 29Th Ave-Base Repair              Clay St
    ## 2      1171       <NA> Sw Montgomery Dr-Base Repair           Clifton St
    ## 3      1175       <NA>                  Ne 52Nd Ave         Clackamas St
    ## 4      1187       <NA>  W Burnside St Base - Repair 325' E Of Maywood Dr
    ## 5      1188       <NA>  W Burnside St Base - Repair         Macleay Blvd
    ## 6      1190       <NA>    Ne 15Th Ave Base - Repair           Hancock St
    ## 7      1191       <NA>     Ne 9Th Ave Base - Repair            Halsey St
    ## 8      1198       <NA>   Nw Glisan St - Base Repair             13Th Ave
    ## 9      1206       <NA>                Nw Thurman St            Gordon St
    ## 10     1207       <NA>                  Nw 16Th Ave              Lovejoy
    ## # ... with 99 more rows, and 3 more variables: `To Street` <chr>,
    ## #   `Treatment Date` <date>, `Moratorium End Date` <date>

``` r
Planned_Fog_Seal <- read_csv(
  "/home/Projects/postgis-geocoder-test/Data/Planned Fog Seal.csv",
  col_types = cols(
    OBJECTID = col_character()))
print(Planned_Fog_Seal)
```

    ## # A tibble: 67 × 7
    ##    OBJECTID            Street `From Street` `To Street` `Project Type`
    ##       <chr>             <chr>         <chr>       <chr>          <chr>
    ## 1      2632        Se Main St      30Th Ave    32Nd Ave       Fog Seal
    ## 2      3321      NW  24TH AVE     GLISAN ST   VAUGHN ST       Fog Seal
    ## 3      3322     NW  SAVIER ST      28TH AVE    23RD AVE       Fog Seal
    ## 4      3324     NW  QUIMBY ST      25TH AVE    23RD AVE       Fog Seal
    ## 5      3325 NW  PETTYGROVE ST      26TH AVE    23RD AVE       Fog Seal
    ## 6      3326    NW  OVERTON ST      21ST AVE    19TH AVE       Fog Seal
    ## 7      3327      NW  20TH AVE    LOVEJOY SY  RALEIGH ST       Fog Seal
    ## 8      3328      NW  17TH AVE   MARSHALL ST NORTHRUP ST       Fog Seal
    ## 9      3329    NW  JOHNSON ST      25TH AVE    23RD AVE       Fog Seal
    ## 10     3330    NW  JOHNSON ST      15TH AVE    14TH AVE       Fog Seal
    ## # ... with 57 more rows, and 2 more variables: `Proposed FY` <chr>,
    ## #   `Project#` <chr>

``` r
Planned_Paving <- read_csv(
  "/home/Projects/postgis-geocoder-test/Data/Planned Paving.csv",
  col_types = cols(OBJECTID = col_character()))
print(Planned_Paving)
```

    ## # A tibble: 25 × 6
    ##    OBJECTID `Project#`                        Street `From Street`
    ##       <chr>      <chr>                         <chr>         <chr>
    ## 1      1334     T00405               N Vancouver Ave  N Russell St
    ## 2      2166       <NA> Se Martin Luther King Jr Blvd    Se Mill St
    ## 3      2553       <NA>                   Sw 10Th Ave       Main St
    ## 4      2555       <NA>                   Nw 10Th Ave   Burnside St
    ## 5      2556       <NA>                  Nw Glisan St      11Th Ave
    ## 6      2560       <NA> Se Martin Luther King Jr Blvd Washington St
    ## 7      2561       <NA>                  Se Grand Ave     Salmon St
    ## 8      2742     T00360                   NE Couch Ct       3rd Ave
    ## 9      3034       <NA>                NW  THURMAN ST      26TH AVE
    ## 10     3035       <NA>                  NW  21ST AVE   MARSHALL ST
    ## # ... with 15 more rows, and 2 more variables: `To Street` <chr>,
    ## #   `Proposed FY` <chr>

``` r
tabula_G_P_Schedule_as_of_1_5_2017 <- read_csv(
  "/home/Projects/postgis-geocoder-test/Data/tabula-G_P Schedule as of 1-5-2017.csv",
  col_types = cols(Start = col_character()))
print(tabula_G_P_Schedule_as_of_1_5_2017)
```

    ## # A tibble: 34 × 4
    ##                                                         `Task Name`
    ##                                                               <chr>
    ## 1                                   NE 122nd Ave: Stanton to Halsey
    ## 2                           NE 102nd Ave: Burnside St to Weidler St
    ## 3                             SE 17th Ave: Andover Pl to Clatsop St
    ## 4                               SE Clinton St: 21st Ave to 26th Ave
    ## 5  SW Jefferson St: 841'W of 20th Ave (N side) to\rPark Ave (W leg)
    ## 6                              SW Morrison St: 18th Ave to 11th Ave
    ## 7                         SW Arthur St: 3rd Ave to 241'E of 1st Ave
    ## 8                               SW Caruthers St: 6th Ave to 3rd Ave
    ## 9                        SE 46th Ave: Glenwood St to Woodstock Blvd
    ## 10                           SE Sandy Blvd: Stark St to Burnside St
    ## # ... with 24 more rows, and 3 more variables: Duration <chr>,
    ## #   Start <chr>, Finish <chr>

### Column names

Note that the columns defined are different for the files. The columns we need to geocode the intersections are the `Street`, `From Street` and `To Street`. Moreover, the "Grind and Pave" data has those columns combined in a single `Task Name` column, and we want "database friendly" column names - all lower case letters with underscores instead of spaces for separators. So we use `dplyr` to make new tidy data frames and save them to new CSV files. We will tag the rows with a source file name and source file row number for traceability.

### Parsers

#### Grind and Pave

This is the most complicated parser, since the `Street`, `From Street` and `To Street` fields are all given in a single column. There are also two extraneous rows that need to be removed.

``` r
if(!require(dplyr)) install.packages("dplyr")
```

    ## Loading required package: dplyr

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(dplyr)
if(!require(tibble)) install.packages("tibble")
```

    ## Loading required package: tibble

``` r
library(tibble)
grind_and_pave <- tabula_G_P_Schedule_as_of_1_5_2017 %>%
  mutate(source_file_name = "G_P Schedule as of 1-5-2017.pdf") %>%
  rownames_to_column(var = "source_row_number") %>%
  filter(!is.na(`Task Name`), `Task Name` != "FY 17/18") %>%
  select(source_file_name, source_row_number, `Task Name`) %>%
  mutate(
    street = sub(":.*$", "", `Task Name`),
    from_street = gsub("\r", " ", `Task Name`) %>%
      sub("^.*:", "", .) %>%
      sub(" to .*$", "", .),
    to_street = gsub("\r", " ", `Task Name`) %>%
      sub("^.* to ", "", .)) %>%
  select(-`Task Name`)
```

#### Pavement moratorium

This one's easier - the only non-tidy feature is that some of the `Street` entries have a " Base-Repair" or similar tacked onto the end.

``` r
pavement_moratorium <- Pavement_Moratorium %>%
  mutate(
    source_file_name = "Pavement Moratorium.csv",
    street = sub("Base.*$", "", Street) %>% sub("-$", "", .)) %>%
  rownames_to_column(var = "source_row_number") %>%
  select(
    source_file_name, 
    source_row_number, 
    street, 
    from_street = `From Street`,
    to_street = `To Street`)
```

#### Planned fog seal

``` r
planned_fog_seal <- Planned_Fog_Seal %>%
  mutate(source_file_name = "Planned Fog Seal.csv") %>%
  rownames_to_column(var = "source_row_number") %>%
  select(
    source_file_name, 
    source_row_number, 
    street = Street, 
    from_street = `From Street`,
    to_street = `To Street`)
```

#### Planned paving

``` r
planned_paving <- Planned_Paving %>%
  mutate(source_file_name = "Planned Paving.csv") %>%
  rownames_to_column(var = "source_row_number") %>%
  select(
    source_file_name, 
    source_row_number, 
    street = Street, 
    from_street = `From Street`,
    to_street = `To Street`)
```

Combine the tidied files and ship them off to the PostGIS geocoder
------------------------------------------------------------------

``` r
tidy_geocoder_input <- bind_rows(
  grind_and_pave,
  pavement_moratorium,
  planned_fog_seal,
  planned_paving)
tidy_geocoder_input$from_street[is.na(tidy_geocoder_input$from_street)] <- ""
tidy_geocoder_input$to_street[is.na(tidy_geocoder_input$to_street)] <- ""
write_csv(tidy_geocoder_input, path = "tidy_geocoder_input.csv")
```
