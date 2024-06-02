// Requires ImageJ version 1.51a for general compatibility requirements (i.e. presence of CLAHE)
requires("1.51a");

// Version number saved in the log of the experiment
current_version_script = "v1.1";

// Initialization of file counter and index for storage
number_of_tif = 0;
file_name_index = 0;

// Directory structure
source_directory = getDirectory("Choose the directory to analyze");  // Source data loading
results_directory = getDirectory("Choose the result directory");     // Results output directory

// File listing and counting the number of compatible files available
all_files_list = getFileList(source_directory);                      // Create an array with the names of all elements in the folder
number_files = lengthOf(all_files_list);                             // Count the total number of elements in the source folder

// Loop through all files to count the number of TIFF/TIF files
for (i = 0; i < number_files; i++) {
    if (endsWith(all_files_list[i], ".dv") || endsWith(all_files_list[i], ".tif")) {
        number_of_tif = number_of_tif + 1;  // Increment the count for each TIFF/TIF file found
    }
}

// Clean exit if no compatible file is present in the location
if (number_of_tif == 0) {
    exit("Duh! This folder doesn't contain any compatible files!");
}

// Creating arrays for full and extensionless filenames
file_shortname = newArray(number_of_tif);  // Array allocation for short names
file_fullname = newArray(number_of_tif);   // Array allocation for full names

// Loop through all files to store filenames for TIFF files
for (i = 0; i < number_files; i++) {
    length_name = lengthOf(all_files_list[i]);
    if (endsWith(all_files_list[i], ".dv")) {
        file_fullname[file_name_index] = all_files_list[i];
        file_shortname[file_name_index] = substring(all_files_list[i], 0, length_name - 5);  // Store filename without extension
        file_name_index = file_name_index + 1;
    }
    if (endsWith(all_files_list[i], ".tif")) {
        file_fullname[file_name_index] = all_files_list[i];
        file_shortname[file_name_index] = substring(all_files_list[i], 0, length_name - 4);  // Store filename without extension
        file_name_index = file_name_index + 1;
    }
}

// Main analysis loop, 1 iteration per TIFF/TIF file
for (p = 0; p < number_of_tif; p++) {
    showProgress(p + 1, number_of_tif);  // Update progress bar within ImageJ status bar
    open(source_directory + file_fullname[p]);  // Load the image ranked p
    rename("Image");  // Rename the opened image to "Image"
    
    // Here you put the code you want to run
    // Do not forget to rename the windows   
    
    
    
    save(results_directory + file_fullname[p]);  // Save the results
    run("Close All");  // Close all windows
}

// End of the results saving sub-loop
// End of main analysis loop

