----------------------------------------------------------------------------------------
-- The present Macaulay2 file contains complementary material                         --
-- to the paper "Inverting catalecticants of ternary quartics"                        --
-- by Laura Brustenga i Moncusí, Elisa Cazzador and Roser Homs                        --
--                                                                                    --
-- Complementary material for the computation of the ML-degree of the                 --
-- linear concentration model represented by catalecticant matrices in Section 4      --
----------------------------------------------------------------------------------------

restart
loadPackage "CatalecticantMatrices" 
-- The package CatalecticantMatrices.m2 is required for the following function:
-- genericCatalecticantMatrix

----------------------------------------------------------------------------------------
-- SETUP COMPUTATIONS: CATALECTICANT MATRICES                                         --
----------------------------------------------------------------------------------------

-- Choose space of catalecticants of (n+1)-ary forms of degree 2k
-- n=1 and k=2 corresponds to catalecticants associated with binary quartics Cat(2,2)
n = 1  
k = 2 

-- Build generic catalecticant matrix in in P^N, namely PCat(k,n+1) 
N = binomial(n+2*k,2*k)-1;                  -- projective dimension of catalecticant space
R = QQ[x_0..x_N];                           -- ring of catalecticant matrices
cat = genericCatalecticantMatrix(k,n,R)     -- catalecticant matrix
m = binomial(k+n,k)                         -- size of catalecticant matrix


----------------------------------------------------------------------------------------
-- WARNING ON THE COMPUTATIONS                                                        --
----------------------------------------------------------------------------------------
-- We ensure that code below provides the ML-degree of LSSMs of catalecticant matrices 
-- associated to binary quartics, sextics and octics (i.e. n=1, k=2,3,4).
-- For ternary quartics, in all the attempts we have done in several servers, 
-- the code has crashed because of the high cost of the saturation step.
--
-- However, in the non-open source software Magma, the same procedure provided 
-- a successful answer: the ML-degree of the model represented by Cat(2,3) is 36
-- with probability 1. 
-- Computations were repeated several times, with a duration of 4-5 days.

----------------------------------------------------------------------------------------
-- ML-DEGREE OF MODELS REPRESENTED BY CATALECTICANT MATRICES                          --
----------------------------------------------------------------------------------------

--m random data vectors
X=random(QQ^m,QQ^m);              
--sample covariance matrix, assuming centered Gaussian model
S=(1/m)*X*transpose(X);
--ideal generated by the score equations of the log-likelihood function of the model
--up to vanishing of the determinant of the generic catalecticant matrix
I=ideal{jacobian(matrix{{det(cat)}})-det(cat)*jacobian(matrix{{trace(S*cat)}})};
--zero-dimensional ideal generated by the score equations of the log-likelihood function of the model
J=saturate(I,det cat);
--ML-degree: number of complex solutions to the score equations (all have multiplicity 1 for general data vectors)
degree J

