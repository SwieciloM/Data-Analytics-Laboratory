data {
    real alpha;
    real miles;
}
generated quantities {
    real theta = fabs(normal_rng(0, 0.35));
    int y_sim = poisson_log_rng(alpha + theta * miles);
}