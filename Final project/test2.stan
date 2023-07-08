data { 
  int<lower=0> N;  // number of observations

  // Output
  int K;  // number of ordinal categories
  int y[N];  // ordinal outcome

  // Income
  real income[N]; // predictor 1

  // Somersvile satisfaction
  int satisfaction[N];  // predictor 2

  // children
  int child[N];  // predictor 3
}
parameters {
  ordered[K-1] c;  // cutpoints
  real beta_income;   // coef income
  ordered[10] beta_satisfy;   // coef satisfaction
  //vector[10] beta_satisfy;
  real beta_child;   // coef child
}
model {
  // priors
  c ~ normal(0, 3);
  beta_income ~ normal(0, 1);
  beta_satisfy ~ normal(0, 1);
  beta_child ~ normal(0, 1);


  // likelihood
  for(n in 1:N) 
    y[n] ~ ordered_logistic(income[n] * beta_income + beta_satisfy[satisfaction[n]] + beta_child * child[n], c);
}
generated quantities{
    real happy[N];

    for (n in 1:N) {
        happy[n] = ordered_logistic_rng(income[n] * beta_income + beta_satisfy[satisfaction[n]] + beta_child * child[n], c);
    }
}