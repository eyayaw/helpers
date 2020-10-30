#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]

NumericVector compute_balance(NumericVector x, double budget){
  int n = x.size();
  NumericVector balance(n); 
  for (int i=0; i<n; ++i) {
    balance[i] = budget-x[i];
    budget = balance[i];
  }
  return balance; 
}
// [[Rcpp::export]]
double meanC(NumericVector x) {
  int n = x.size();
  double y = 0;
  
  for(int i = 0; i < n; ++i) {
    y += x[i] / n;
  }
  return y;
}
// [[Rcpp::export]]
NumericVector cumsumC(NumericVector x) {
  int n = x.size();
  NumericVector out(n);
  
  out[0] = x[0];
  for(int i = 1; i < n; ++i) {
    out[i] = out[i - 1] + x[i];
  }
  return out;
}