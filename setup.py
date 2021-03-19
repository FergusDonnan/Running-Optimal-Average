from distutils.core import setup
from Cython.Build import cythonize
import numpy

setup(
    ext_modules = cythonize("ROA.pyx", annotate=True,
        compiler_directives={'wraparound': False,
                            'nonecheck': False,
                            'cdivision': True,
                            'boundscheck':False
                            }),
    include_dirs=[numpy.get_include()]
)

