% clear workspace
clear all; close all; clc;

% add .NET assembly
dll = [pwd, '\..\bin\Release\CycleCountLib.dll'];
NET.addAssembly(dll);

% number of test repetitions
n = 50;

% data sizes to run
history_size = 1e2:1e3:1e5;

% plot variables
y_matlab = zeros(length(history_size), 1);
y_csharp = zeros(length(history_size), 1);

% for each data array size
for k = 1:1:length(history_size)
    
    fprintf('Run %i of %i (data array size = %i)...\n', k, length(history_size), history_size(k));
    
    % timers
    matlab_elapsed = 0;
    csharp_elapsed = 0;
    
    % for each test
    for i = 1:1:n
        
        % generate random stress-time history
        history = rand(history_size(k), 1);

        % get expected (Requires Signal Processing Toolbox)
        tic;
        matlab = rainflow(history);
        matlab_elapsed = matlab_elapsed + toc;
        
        % test
        tic;
        csharp = CycleCountLib.Rainflow.Execute(history);
        csharp_elapsed = csharp_elapsed + toc;
        
        % convert data
        csharp = double(csharp);
        
        % check results
        if ~isequal(matlab(:, 1:3), csharp)
            error('Test %i of run %i failed.\n', i, k);
        else
            %fprintf('Test %i of run %i passed.\n', i, k);
        end
        
    end
    
    y_matlab(k) = 1000*matlab_elapsed/n;
    y_csharp(k) = 1000*csharp_elapsed/n; 
    
end

figure(1); hold on; grid on; legend show;
set(gca, 'FontSize', 14);
legend('Location', 'nw');
xlabel('Stress-time history array size');
ylabel('Averaged elapsed time [ms]');
title(sprintf('Averaged elapsed time (%i runs) vs. data size', n));
subtitle('Lower is better');
plot(history_size, y_matlab, '-b', 'LineWidth', 2, 'DisplayName', 'MATLAB’s implementation');
plot(history_size, y_csharp, '-r', 'LineWidth', 2, 'DisplayName', 'This C# code');
