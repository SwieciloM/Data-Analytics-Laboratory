data {
    int<lower=0> N; // Number of samples
    real<lower=0> heights[N];
}
parameters {
    real<lower=0> mu;
    real<lower=0> sigma;
}
model {
    // Priors
    mu ~ normal(150, 10);
    sigma ~ normal(5, 2);
    // Likelihood
    heights ~ normal(mu, sigma);
}
generated quantities {
    real height_sim = normal_rng(mu, sigma);
}