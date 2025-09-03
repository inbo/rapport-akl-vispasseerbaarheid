# ---------------------------------------------------------------------------- #
#                                                                              #
#               R SCRIPT TO I M P O R T   D A T A   F R O M                    #
#                               Z E N O D O                                    #
#                                                                              #
# ---------------------------------------------------------------------------- #

# --- SECTION 1: INSTALL AND LOAD PACKAGES -------------------------------------

# Install required packages if they aren't already installed
if (!requireNamespace("archive", quietly = TRUE)) {
  install.packages("archive")
}
if (!requireNamespace("tidyverse", quietly = TRUE)) {
  install.packages("tidyverse")
}

# Load the packages into the R session
library(archive)
library(tidyverse)

if (dir.exists("data")==FALSE) {

  # --- SECTION 2: DEFINE VARIABLES AND DOWNLOAD DATA ----------------------------
  
  # URL for the Zenodo record's API endpoint
  api_url <- "https://doi.org/10.5281/zenodo.17017617"
  # Read the JSON data from the API
  record_data <- jsonlite::fromJSON(api_url)
  # Extract the files data frame
  files_df <- record_data$files
  # View the files and their download links
  print(files_df)
  
  # **IMPORTANT**: Replace the placeholder URL with the actual Zenodo download link
  # for your zipped folder. You can find this on the Zenodo record's page.
  zenodo_url <- "https://zenodo.org/api/records/15192025/files/stijnbruneel/vfcd-fish-gps-v2.0.0.zip/content"
  
  # Define the local file path where you want to save the downloaded zip file.
  # You can change this name if you like.
  dest_file <- "downloaded_data.zip"
  
  # Use the download.file() function to download the file from the Zenodo URL.
  # The 'mode = "wb"' is important for binary files like zip archives.
  download.file(zenodo_url, dest_file, mode = "wb")
  
  # --- SECTION 3: EXTRACT THE FILES ---------------------------------------------
  
  # Define the folder where the contents of the zip file will be extracted.
  # The `dir` argument will create this folder if it doesn't already exist.
  extraction_dir <- "zenodo_data"
  
  # Use the archive_extract() function to unzip the downloaded file.
  # This is a robust way to handle various archive formats.
  archive_extract(dest_file, dir = extraction_dir)
  
  # --- SECTION 4: LOAD THE DATA INTO R ------------------------------------------
  
  # List the files in the newly created directory to see what was extracted.
  extracted_files <- list.files(extraction_dir)
  print(extracted_files)
  
  # --- SECTION 5: CLEANUP (OPTIONAL) --------------------------------------------
  
  # If you want to remove the temporary downloaded zip file, you can uncomment
  # the line below. This helps keep your project directory clean.
  file.remove(dest_file)
  
  # Break the hierarchy of folders to get to the CSV files
  
  if (dir.exists("zenodo_data")) {
    extracted_zip <- list.files("zenodo_data", full.names = TRUE)
    extracted_content <- list.files(extracted_zip, full.names = TRUE)
    for (item in extracted_content) {
      file.rename(from = item, to = basename(item))
    }
    # Clean up: remove the temporary 'zenodo_files' directory
    unlink("zenodo_data", recursive = TRUE)
    message("Files moved to root directory and temporary folders cleaned up.")
  } else {message("No files to move. The specified extracted folder does not exist.")}

} else {message("Data folder already exists. No need to download and extract data.")}
