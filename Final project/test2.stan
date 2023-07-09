data { 
  // Number of observations
  int<lower=0> N;  

  // Output related data
  int K;  // number of ordinal categories
  int y[N];  // ordinal outcome

  // Predictors (1-9)
  int neigh_sat[N];                         // Predictor 1 (neighborhood_satisfaction)
  int hous_sat[N];                          // Predictor 2 (housing_satisfaction)
  int com_even_avail[N];                    // Predictor 3 (community_events_availability)
  int sen_of_sec[N];                        // Predictor 4 (sense_of_security)
  real ann_hous_inc[N];                    // Predictor 5 (annual_household_income)
  int liv_with_child[N];                    // Predictor 6 (living_with_children)
  int is_disabled[N];                       // Predictor 7 (is_disabled)
}

parameters {
  ordered[K-1] c;                           // Cutpoints
  
  // Coefficients for predictors (1-9)
  ordered[10] coef_neigh_sat;               // Coefficient 1 (neighborhood_satisfaction)
  ordered[10] coef_hous_sat;                // Coefficient 2 (housing_satisfaction)
  ordered[5] coef_com_even_avail;           // Coefficient 3 (community_events_availability)
  ordered[10] coef_sen_of_sec;              // Coefficient 4 (sense_of_security)
  real coef_ann_hous_inc;                   // Coefficient 5 (annual_household_income)
  real coef_liv_with_child;                 // Coefficient 6 (living_with_children)
  real coef_is_disabled;                    // Coefficient 7 (is_disabled)
}

model {
  // Priors
  c ~ normal(0, 3);                         // Prior 0 (cutpoints)
  coef_neigh_sat ~ normal(0, 1);            // Prior 1 (neighborhood_satisfaction)
  coef_hous_sat ~ normal(0, 1);             // Prior 2 (housing_satisfaction)
  coef_com_even_avail ~ normal(0, 1);       // Prior 3 (community_events_availability)
  coef_sen_of_sec ~ normal(0, 1);           // Prior 4 (sense_of_security)
  coef_ann_hous_inc ~ normal(0, 1);         // Prior 5 (annual_household_income)
  coef_liv_with_child ~ normal(0, 1);       // Prior 6 (living_with_children)
  coef_is_disabled ~ normal(0, 1);          // Prior 7 (is_disabled)

  // likelihood
  for(n in 1:N) 
    y[n] ~ ordered_logistic(coef_neigh_sat[neigh_sat[n]] + 
                            coef_hous_sat[hous_sat[n]] +        
                            coef_com_even_avail[com_even_avail[n]] +
                            coef_sen_of_sec[sen_of_sec[n]] +
                            coef_ann_hous_inc * ann_hous_inc[n] +
                            coef_liv_with_child * liv_with_child[n] +
                            coef_is_disabled * is_disabled[n], c);
}

generated quantities{
    real happy[N];

    for (n in 1:N) {
        happy[n] = ordered_logistic_rng(coef_neigh_sat[neigh_sat[n]] + 
                            coef_hous_sat[hous_sat[n]] +        
                            coef_com_even_avail[com_even_avail[n]] +
                            coef_sen_of_sec[sen_of_sec[n]] +
                            coef_ann_hous_inc * ann_hous_inc[n] +
                            coef_liv_with_child * liv_with_child[n] +
                            coef_is_disabled * is_disabled[n], c);
    }
}