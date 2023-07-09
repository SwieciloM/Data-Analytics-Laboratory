data { 
  // Output related data
  int K;  // number of ordinal categories
  int y;  // ordinal outcome

  // Predictors (1-9)
  int neigh_sat;                    // Predictor 1 (neighborhood_satisfaction)
  int hous_sat;                     // Predictor 2 (housing_satisfaction)
  int com_even_avail;               // Predictor 3 (community_events_availability)
  int sen_of_sec;                   // Predictor 4 (sense_of_security)
  real ann_hous_inc;                // Predictor 5 (annual_household_income)
  int liv_with_child;               // Predictor 6 (living_with_children)
  int is_disabled;                  // Predictor 7 (is_disabled)
}

generated quantities{
  ordered[K-1] c;

  // Coefficients for predictors (1-9)
  ordered[10] coef_neigh_sat;                           // Coefficient 1 (neighborhood_satisfaction)
  ordered[10] coef_hous_sat;                            // Coefficient 2 (housing_satisfaction)
  ordered[5] coef_com_even_avail;                       // Coefficient 3 (community_events_availability)
  ordered[10] coef_sen_of_sec;                          // Coefficient 4 (sense_of_security)

  real coef_ann_hous_inc = normal_rng(0, 10);            // Coefficient 5 (annual_household_income)
  real coef_liv_with_child = normal_rng(0, 10);          // Coefficient 6 (living_with_children)
  real coef_is_disabled = normal_rng(0, 10);             // Coefficient 7 (is_disabled)

  for (k in 1:(K-1)) {
    c[k] = normal_rng(0, 10);                            // Cutpoints 
  }      

  for (i in 1:10) {
    coef_neigh_sat[i] = normal_rng(0, 10);
    coef_hous_sat[i] = normal_rng(0, 10); 
    coef_sen_of_sec[i] = normal_rng(0, 10);                            
  }  

  for (i in 1:5) {
    coef_com_even_avail[i] = normal_rng(0, 10);                         
  }                            

  real happy = ordered_logistic_rng(coef_neigh_sat[neigh_sat] + 
                                    coef_hous_sat[hous_sat] +        
                                    coef_com_even_avail[com_even_avail] +
                                    coef_sen_of_sec[sen_of_sec] +
                                    coef_ann_hous_inc * ann_hous_inc +
                                    coef_liv_with_child * liv_with_child +
                                    coef_is_disabled * is_disabled, c);
}