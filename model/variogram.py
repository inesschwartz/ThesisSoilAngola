import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from skgstat import DirectionalVariogram
import os

# =====================================
# 1. Load data
# =====================================
df = pd.read_csv('/Users/inesschwartz/Desktop/model/decluster_runs/decluster_run_001.csv')

coords = df[['X_coord', 'Y_coord']].values
values = df['log_soc_stock'].values

# =====================================
# 2. Define parameters
# =====================================
n_lags = 15
maxlag_km = 50       # max lag in km
maxlag = maxlag_km * 1000  # convert to meters if your coords are in meters
tolerance = 22.5
normalize = True
estimator = 'matheron'

# Directions (azimuths, in degrees)
dir1 = 135
dir2 = 45

# =====================================
# 3. Compute directional variograms
# =====================================
v135 = DirectionalVariogram(
    coordinates=coords,
    values=values,
    azimuth=dir1,
    n_lags=n_lags,
    maxlag=maxlag,
    tolerance=tolerance,
    normalize=normalize,
    estimator=estimator
)

v45 = DirectionalVariogram(
    coordinates=coords,
    values=values,
    azimuth=dir2,
    n_lags=n_lags,
    maxlag=maxlag,
    tolerance=tolerance,
    normalize=normalize,
    estimator=estimator
)

# =====================================
# 4. Plot results
# =====================================
plt.figure(figsize=(8,5))
plt.plot(v135.bins, v135.experimental, 'o-', label='135° direction')
plt.plot(v45.bins, v45.experimental, 's-', label='45° direction')
plt.xlabel('Lag distance (m)')
plt.ylabel('Semivariance')
plt.title('Directional Experimental Variograms')
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()
