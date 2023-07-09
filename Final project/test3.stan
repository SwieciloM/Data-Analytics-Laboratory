parameters {
  ordered[K-1] c;  // cutpoints
  real beta_income;   // coef income
  ordered[10] beta_satisfy;   // coef satisfaction
}
generated quantities{
    ordered[10] beta;

    for (n in 1:10) {
        beta[n] = normal_rng(0, 0.5);
    }
}