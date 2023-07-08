data {                     
    real<lower=0> age;
    real<lower=0> income;
    real<lower=0> place_satisfaction;
}

generated quantities {
    // Unknown coefs
    real years_in_somerville_coef = normal_rng(1, 0.1); // 
    real age_coef = uniform_rng(0.5, 0.12);
    real income_coef = normal_rng(2.0, 0.2);
    real place_satisfaction_coef = normal_rng(3, 0.25);
    real sigma = fabs(normal_rng(0, 1));

    real weighted_mean = (years_in_somerville*years_in_somerville_coef+age*age_coef+income*income_coef+place_satisfaction*place_satisfaction_coef)/(years_in_somerville_coef+age_coef+income_coef+place_satisfaction_coef)
    int<lower=0,upper=N> happy_pred;
    happy_pred = normal_rng(weighted_mean, sigma);
}