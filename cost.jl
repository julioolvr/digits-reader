include("sigmoid.jl")

function cost(theta, X, y, lambda)
  m = size(X, 1)
  predictions = sigmoid(X * theta)
  errors = -y .* log(predictions) - (1 - y) .* log(1 - predictions)

  1 / m * sum(errors) + lambda / 2 / m * sum(theta[2:end] .^ 2)
end
