include("loadData.jl")
include("printDigit.jl")

trainingexamples = DataLoading.gettrainingexamples()
traininglabels = DataLoading.gettraininglabels()

if (ntoh(read(trainingexamples, UInt32)) != 0x00000803)
  println("Invalid magic number for training examples")
  quit()
end

if (ntoh(read(traininglabels, UInt32)) != 0x00000801)
  println("Invalid magic number for training labels")
  quit()
end

imagescount = ntoh(read(trainingexamples, UInt32))
labelscount = ntoh(read(traininglabels, UInt32))

if (imagescount != labelscount)
  println("Number of images and labels in the files must match")
  quit()
end

rows = ntoh(read(trainingexamples, UInt32))
columns = ntoh(read(trainingexamples, UInt32))

println("Found $(imagescount) $(rows)x$(columns) images in the training set")

images = Array{UInt8}(imagescount, rows * columns)

for i = 1:imagescount
  images[i,:] = read(trainingexamples, UInt8, rows * columns)
end

labels = read(traininglabels, UInt8, labelscount)

for digit in 1:10
  println("Label: $(labels[digit])")
  printdigit(images[digit,:], rows, columns)
end
