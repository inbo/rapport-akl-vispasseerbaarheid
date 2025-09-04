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
  
  # --- SECTION 2: GET THE CORRECT DOWNLOAD URL FROM API -------------------------
  
  # Zenodo record's API endpoint
  record_api_url <- "https://zenodo.org/api/records/17017617"
  
  # Use a safe way to get the data
  record_data <- jsonlite::fromJSON(record_api_url)
  
  # Find the specific file's download URL
  file_info <- record_data$files[record_data$files$key == "data and media.zip", ]
  
  # Get the URL that contains the space
  raw_url <- file_info$links$self
  
  # URL encode the space character
  zenodo_url <- URLencode(raw_url)
  
  # Print the corrected URL
  message("Found and corrected URL: ", zenodo_url)
  
  # --- SECTION 3: DOWNLOAD AND EXTRACT THE FILE ---------------------------------
  
  # Define the local file path where you want to save the downloaded zip file.
  # You can change this name if you like.
  dest_file <- "downloaded_data.zip"
  
  # Use the download.file() function to download the file from the Zenodo URL.
  # The 'mode = "wb"' is important for binary files like zip archives.
  download.file(zenodo_url, dest_file, mode = "wb")
  
  # --- SECTION 4: EXTRACT THE FILES ---------------------------------------------
  
  # Define the folder where the contents of the zip file will be extracted.
  # The `dir` argument will create this folder if it doesn't already exist.
  extraction_dir <- "zenodo_data"
  
  # Use the archive_extract() function to unzip the downloaded file.
  # This is a robust way to handle various archive formats.
  archive_extract(dest_file, dir = extraction_dir)
  
  # List the files in the newly created directory to see what was extracted.
  extracted_files <- list.files(extraction_dir)
  print(extracted_files)
  
  # --- SECTION 6: CLEANUP (OPTIONAL) --------------------------------------------
  
  # If you want to remove the temporary downloaded zip file, you can uncomment
  # the line below. This helps keep your project directory clean.
  file.remove(dest_file)
  
  # --- SECTION 7: BREAK HIERARCHY  ----------------------------------------------
  
  if (dir.exists("zenodo_data")) {
    extracted_content <- list.files("zenodo_data", full.names = TRUE)
    for (item in extracted_content) {
      file.rename(from = item, to = basename(item))
    }
    # Clean up: remove the temporary 'zenodo_files' directory
    unlink("zenodo_data", recursive = TRUE)
    message("Files moved to root directory and temporary folders cleaned up.")
  } else {message("No files to move. The specified extracted folder does not exist.")}

} else {message("Data folder already exists. No need to download and extract data.")}
