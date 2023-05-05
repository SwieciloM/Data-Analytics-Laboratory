data {
    int<lower=1> N;  // Number of samples
}

generated quantities {
    matrix[N,3] X;

    vector [N] zeros = rep_vector(0,N);

    for (j in 1:3) {
        X[:,j]=to_vector(normal_rng(zeros,1));
    }

    vector [3] beta;
    beta = [2, 1, 0.5]';

    array [N] real y;
    y = normal_rng(X*beta,1);
}