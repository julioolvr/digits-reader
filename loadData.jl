module DataLoading
  import GZip
  export gettrainingexamples, gettraininglabels

  TRAINING_IMAGES_URL = "http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz"
  TRAINING_LABELS_URL = "http://yann.lecun.com/exdb/mnist/train-labels-idx1-ubyte.gz"

  function gettrainingexamples()
    readordownloadfile("./data/trainingImages", TRAINING_IMAGES_URL)
  end

  function gettraininglabels()
    readordownloadfile("./data/trainingLabels", TRAINING_LABELS_URL)
  end

  function readfile(filepath)
    GZip.open(filepath)
  end

  function readordownloadfile(filepath, url)
    try
      readfile(filepath)
    catch e
      println("Error reading file $(filepath), downloading from $(url)")

      download(url, filepath)
      readfile(filepath)
    end
  end
end
