generated quantities{
    ordered[10] beta;

    for (n in 1:10) {
        beta[n] = normal_rng(0, 0.5);
    }
}