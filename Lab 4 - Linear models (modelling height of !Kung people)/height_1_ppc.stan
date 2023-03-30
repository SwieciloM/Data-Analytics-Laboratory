generated quantities {
    real <lower=0> mu = normal_rng(170, 10);
    real <lower=0> sigma = normal_rng(10, 2);;
    real <lower=0> y = normal_rng(mu, sigma);
}
