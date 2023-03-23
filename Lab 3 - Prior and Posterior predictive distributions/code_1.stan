generated quantities {
    int<lower=0> N;
    int<lower=0,upper=N> y;
    real<lower=0,upper=1> p; 

    N = 50;
    p = normal_rng(0.2, 0.1);
    y = binomial_rng(N, p);
}