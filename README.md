# SAT-Gurobi
An Efficient Method to Transform SAT problems to Binary Integer Linear Programming Problems （Under Review)
Abstract—There exists a method to reduce a 3-SAT (Satifiability)
problem to a Subset Sum Problem (SSP) in the literature,
however, it can only be applied to small or medium size problems.
Our study is to find an efficient method to transform general
SAT problems to binary integer linear programming (BILP)
problems in larger size. Observing the feature of variable-clauses
constraints in SAT, we apply linear inequality model (LIM) to the
problem and propose a method called LIMSAT. The new method
works efficiently for very large size problems with thousands of
variables and clauses and has comparable performance against
the best solver tested by one of the hardest SAT 2016 competition
benchmarks.
keywords: SAT (Satisfiability) problems; 3SAT problems;
BILP (Binary Integer Linear programing); Reduction; Transform

Necessary environment:
1.Matlab
2.Gurobi Optimization
Running step:
1.Put data file into 'test' folder
2.Open Matlab run the file 'milp_jobNew.m'
3.The result will save current directory,if sat it will save path file into 'result' folder
