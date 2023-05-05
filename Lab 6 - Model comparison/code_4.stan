data {
    int N;  // Number of samples
    array [N] real y;  // Measurements
}

parameters {
    real<lower=0> sigma;
    real mu;
    real<lower=0> nu;
}

model {
    target += -2*log(sigma);
    target += gamma_lpdf(nu|2,0.1);
    target += student_t_lpdf(y|nu,mu,sigma);
}

generated quantities {
    vector[N] log_lik;
    array [N] real y_hat;
    for (j in 1:N) {
        log_lik[j] = student_t_lpdf(y[j]|nu,mu,sigma);
        y_hat[j] = student_t_rng(nu,mu,sigma);
    }
}