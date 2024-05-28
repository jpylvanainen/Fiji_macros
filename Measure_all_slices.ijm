// Macro to measure intensity for all slices in a stack

// Get the number of slices in the stack
getDimensions(width, height, channels, slices, frames);


// Loop through each slice
for (i = 1; i <= nSlices; i++) {
    setSlice(i); // Set the current slice
    run("Measure"); // Measure the current slice
}
