#cython: boundscheck=False, wraparound=False, nonecheck=False
import numpy as np
cimport numpy as np
from libc.math cimport exp, pow, abs



def RunningOptimalAverage(double[:] t_data, double[:] Flux, double[:]  Flux_err, double delta):
    """
    RunningOptimalAverage(t_data, Flux, Flux_err, delta)

    Calculate running optimal average on a fine grid.

    Parameters
    ----------
    t_data  :  float array
        Time values of data points
    Flux  : float array
        Flux data values
    Flux_err : float array
        Errors for flux data points
    delta  : float
        Window width of Gaussian memory function - controls how flexible model is


    Returns
    ----------
    t  : float array
        Time values of grid used to calculate ROA
    model : float array
        Running optimal average's calculated for each time t
    errs : float array
        Errors of running optimal average
    P : float
        Effective number of parameters for model



    """


    cdef int gridsize=1000
    cdef double[:] model = np.zeros(gridsize)
    cdef double[:] errs = np.zeros(gridsize)
    cdef double length 
    cdef double[:] t = np.zeros(gridsize)
    cdef double G, w, P, fw, c, 
    cdef double mx = -np.inf
    cdef double mn = np.inf



    #Find max and min of t_data
    for i in range(t_data.shape[0]):
        if t_data[i] < mn:
            mn = t_data[i]
        if  t_data[i] > mx:
            mx = t_data[i]
        
        

    
    length = abs(mx - mn)
    
    

    #Calculate no. of parameters
    P = 0.0
    for i in range(t_data.shape[0]):
        
        w = 0.0
        #Define Gaussian Memory Function
        for j in range(t_data.shape[0]):    
            G = exp(-0.5*(((t_data[i]-t_data[j])/delta)**2))

            #Calculate weights
            w = w + G/(Flux_err[j]**2)


        P = P + 1.0/((Flux_err[i]**2)*w)

    c = 0.0
    for i in range(gridsize):
        c = c + 1

        t[i] = mn + c*length/(gridsize)

        w = 0.0
        fw = 0.0
        #Define Gaussian Memory Function
        for j in range(t_data.shape[0]):    
            G = exp(-0.5*(((t[i]-t_data[j])/delta)**2))

            #Calculate weights
            w = w + G/(pow(Flux_err[j], 2))
            fw = fw + Flux[j]*G/(pow(Flux_err[j],2))

        #Calculate optimal average
        model[i] = fw/w
        #Calculate error
        errs[i] = pow(1.0/w, 0.5)
        

    
        
    return np.array(t), np.array(model), np.array(errs), P
    
    
    
