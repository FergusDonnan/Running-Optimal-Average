# Running-Optimal-Average

Usage:

t, model, errs, P = RunningOptimalAverage(t_data, Flux, Flux_err, delta)

Calculate running optimal average on a fine grid. Also returns errors and effective number of parameters.

Import using:

from ROA import RunningOptimalAverage

Parameters
----------
t_data  :  float array :
    Time values of data points
    
Flux  : float array :
    Flux data values
    
Flux_err : float array :
    Errors for flux data points
    
delta  : float :
    Window width of Gaussian memory function - controls how flexible model is


Returns
----------
t  : float array :
    Time values of grid used to calculate ROA
    
model : float array :
    Running optimal average's calculated for each time t
    
errs : float array :
    Errors of running optimal average
    
P : float :
    Effective number of parameters for model





