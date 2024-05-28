


// Initialize variables
getDimensions(width, height, channels, slices, frames);
roiIndices = newArray(slices); // Array to store ROI indices per frame
sliceNames = newArray(slices); // Array to store frame names
roiCountDifferences = newArray(slices - 1); // Array to store ROI count differences

// Loop through each frame
for (slice = 1; slice <= slices; slice++) {
    showStatus(slice + "/" + slices);

    Stack.setPosition(1, slice, 1); // Set position to the current frame
    sliceName = getInfo("slice.label"); // Get the frame label (name)

    sliceNames[slice - 1] = sliceName; // Store the frame name

    RoiManager.selectPosition(0, slice, 0);

    // Get the index of the last ROI for the current frame
    roiIndex = roiManager("index");
    roiIndices[slice - 1] = roiIndex; // Store index in array (0-indexed)
}

// Calculate the ROI count differences
for (slice = 1; slice < slices; slice++) {
    roiCountDifferences[slice - 1] = roiIndices[slice] - roiIndices[slice - 1];
}

// Get the count of ROIs for the last frame
totalRoiCount = roiManager("count");
roiCountDifferences[slice - 1] = totalRoiCount - roiIndices[slice - 2];

// Print the ROI counts and frame names
print("Frame Name, ROI Index, ROI Count Difference");
for (slice = 1; slice <= slices; slice++) {
    if (slice < slices) {
        print(sliceNames[slice - 1] + ", " + roiIndices[slice - 1] + ", " + roiCountDifferences[slice - 1]);
    } else {
        print(sliceNames[slice - 1] + ", " + roiIndices[slice - 1] + ", " + roiCountDifferences[slice - 1]); // Print the difference for the last frame
    }
}
