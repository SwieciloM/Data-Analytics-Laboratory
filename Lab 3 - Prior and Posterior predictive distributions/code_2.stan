data {
    int<lower=0> N; // Number of trials
    int<lower=0,upper=N> y; // Number of successes
}
parameters {
    real<lower=0,upper=1> p; // Prior
}
model {
    p ~ normal(0.2, 0.1); //  Prior definition
    y ~ binomial(N, p); // Binomial likelihood definition
}
generated quantities {
    int<lower=0,upper=N> y_pred;
    y_pred = binomial_rng(N, p);
}