data {
    int<lower=0> N;
    int<lower=0> y[N];
    real<lower=0> miles[N];
}

parameters {
    real alpha[N];
    real <lower=0> theta;
}

model {
    alpha ~ normal(3.17, 0.25); // Logarithm of mean accidents
    theta ~ normal(0, 0.35);
    for (i in 1:N) {
        y[i] ~ poisson_log(alpha[i] + theta * miles[i]);
    }
}

generated quantities {
    int y_pred[N];
    for (i in 1:N) {
        y_pred[i] = poisson_log_rng(alpha[i] + theta * miles[i]);
    }
}