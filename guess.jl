include("loadData.jl")
include("printDigit.jl")
include("sigmoid.jl")
include("theta.jl")

testimages = DataLoading.gettestimages()
testlabels = DataLoading.gettestlabels()

if (ntoh(read(testimages, UInt32)) != 0x00000803)
  println("Invalid magic number for test images")
  quit()
end

if (ntoh(read(testlabels, UInt32)) != 0x00000801)
  println("Invalid magic number for test labels")
  quit()
end

imagescount = ntoh(read(testimages, UInt32))
labelscount = ntoh(read(testlabels, UInt32))

if (imagescount != labelscount)
  println("Number of images and labels in the files must match")
  quit()
end

rows = ntoh(read(testimages, UInt32))
columns = ntoh(read(testimages, UInt32))

println("Found $(imagescount) $(rows)x$(columns) images in the test set")

images = Array{UInt8}(imagescount, rows * columns)

for i = 1:imagescount
  images[i,:] = read(testimages, UInt8, rows * columns)
end

labels = map(label -> label == 0 ? 10 : label, read(testlabels, UInt8, labelscount))

println("Guessing...")

X = [ones(size(images, 1)) images]
all_guesses = sigmoid(X * learned_theta')
guesses_size = size(all_guesses)
max_per_example, max_indexes = findmax(all_guesses, 2)
guesses = map(x -> ind2sub(guesses_size, x)[2], max_indexes)

for i = 1:10
  printdigit(images[i,:], rows, columns)
  println("Label: $(labels[i])")
  println("Guess: $(guesses[i])")
end

correct_guesses = count(x -> x, labels .== guesses)
println("Correct guesses: $(correct_guesses) out of $(labelscount) ($(correct_guesses / labelscount * 100)%)")
