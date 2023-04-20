data {
    int N;  // Number of samples
    int K;  // Number of predictors
    array [N] real y;  // Measurements
    matrix[N,K] X;  // Design matrix
}

parameters {
    real<lower=0> sigma;
    vector[K] beta;
}

transformed parameters {
    vector [N] mu;
    mu = X*beta;
}

model {
    y ~ normal(mu, sigma);
}

generated quantities {
    vector[N] log_lik;
    array [N] real y_hat;
    for (j in 1:N) {
        log_lik[j] = normal_lpdf(y[j]|mu[j], sigma);
        y_hat[j] = normal_rng(mu[j],sigma);
    }
}