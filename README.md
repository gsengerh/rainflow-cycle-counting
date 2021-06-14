# Rainflow Cycle Counting in C#

### By: Carlos Souto - csouto@fe.up.pt

A fast rainflow cycle counting algorithm according to
ASTM E1049-85,
*Standard Practices for Cycle Counting in Fatigue Analysis*,
ASTM International ([**DOI:** 10.1520/E1049-85R17](https://doi.org/10.1520/E1049-85R17)).

This algorithm has been **tested and validated** by generating random input data and checking its output against Matlab's implementation (``rainflow`` - requires *Signal Processing Toolbox* - [Documentation](https://www.mathworks.com/help/signal/ref/rainflow.html)).

Since Matlab can interface with a .NET Framework DLL, this code was compiled and used in Matlab for testing.
The Matlab code used for testing is also included in the distribution.

The performance of this implementation surpasses the Matlab's solution.

![untitled](https://user-images.githubusercontent.com/83190503/121896024-c2709780-cd18-11eb-81fa-e9f3d5730297.png)

## How to use in Matlab

Build the .NET Framework DLL or use the one provided (Windows only).
DLL located in ``...\CycleCountLib\bin\Release\CycleCountLib.dll``.
Usage example:

```
% path to the dll (update if needed)
dll = [pwd, '\CycleCountLib.dll'];

% add the .NET assembly
NET.addAssembly(dll);

% some random stress-time history
history = rand(1000, 1);

% call .NET dll
counts = CycleCountLib.Rainflow.Execute(history);

% convert double[][] to matlab array
counts = double(counts);

% show results
% the cycle counts are returned as a matrix:
% - column 1 are the counts
% - column 2 are the ranges
% - column 3 are the mean values
disp(counts);
```

---
<sup>
  Copyright (c) 2021, Carlos Daniel Santos Souto.
  All rights reserved.
  BSD 3-Clause License.
<sup>
