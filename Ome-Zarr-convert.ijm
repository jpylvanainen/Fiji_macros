// ImageJ Macro to convert all images in a folder to Zarr format with user-defined chunk size
// Instructions for the user
showMessage("Chunk Size Input", "ImageJ's axis order is X,Y,C,Z,T.\n" +
                                 "The chunk size must be specified in this order.\n" +
                                 "You must skip any axis whose size is 1.\n" +
                                 "For example, a 2D time-series without channels may have a chunk size of 1024,1024,1 (X,Y,T).");
// Ask the user for the input directory containing the image files
inputDirectory = getDirectory("Choose the directory containing images to convert to Zarr");
if (inputDirectory == "") exit("No directory selected. Exiting.");
// Ask the user for the output directory
outputDirectory = getDirectory("Choose the directory to save the Zarr files");
if (outputDirectory == "") exit("No directory selected. Exiting.");
// Ask the user for the chunk size
chunkSize = getString("Enter the chunk size in the format X,Y,C,Z,T (skip any axis with size 1)", "1024,1022,500");
// Get a list of all files in the input directory
imageFiles = getFileList(inputDirectory);
nFiles = lengthOf(imageFiles);
// Loop through each file in the directory
for (f = 0; f < nFiles; f++) {
    fileName = imageFiles[f];
    // Only process image files with .tif or .tiff extensions
    if (endsWith(fileName, ".tif") || endsWith(fileName, ".tiff")) {
        inputFile = inputDirectory + fileName;
        // Remove the file extension to create the base name
        baseName = substring(fileName, 0, lastIndexOf(fileName, "."));
        print(baseName);
        // Construct the output Zarr file path
        zarrOutputFile = outputDirectory + baseName + "_gzip.zarr";
        // Run the Zarr export command
        run("HDF5/N5/Zarr/OME-NGFF ...",
            "containerroot=[" + zarrOutputFile + "] " +
            "dataset=[" + baseName + "] " +
            "storageformat=Zarr " +
            "chunksizearg=" + chunkSize + " " +
            "createpyramidifpossible=false " +
            "downsamplemethod=Sample " +
            "compressionarg=gzip " +
            "metadatastyle=OME-NGFF " +
            "nthreads=10 " +
            "overwrite=true");
    }
}