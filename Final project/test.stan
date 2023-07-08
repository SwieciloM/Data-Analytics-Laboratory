data {
  int<lower=2> K;  // number of ordinal categories
  int<lower=0> N;  // number of observations
  int<lower=1> J;  // number of predictors
  int<lower=1,upper=K> y[N];  // ordinal outcome
  matrix[N,J] X;  // predictors
}
parameters {
  ordered[K-1] c;  // cutpoints
  vector[J] beta;  // coefficients for predictors
}
model {
  // priors
  c ~ normal(0, 1);
  beta ~ normal(0, 1);

  // likelihood
  for(n in 1:N) 
    y[n] ~ ordered_logistic(X[n] * beta, c);
}
generated quantities{
    real happy[N];
    for (i in 1:N) {
        happy[i] = ordered_logistic_rng(X[i] * beta, c);
    }
}