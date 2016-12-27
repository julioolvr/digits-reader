include("sigmoid.jl")

function cost(theta, X, y, lambda)
  m = size(X, 1)
  predictions = sigmoid(X * theta)
  errors = -y .* log(predictions) - (1 - y) .* log(1 - predictions)

  1 / m * sum(errors) + lambda / 2 / m * sum(theta[2:end] .^ 2)
end

function gradient(theta, X, y, lambda)
  m = size(X, 1)
  predictions = sigmoid(X * theta)
  lambdas = lambda / m * theta[2:end]

  1 / m * sum((predictions - y) .* X, 1)' + [0;lambdas]
end
