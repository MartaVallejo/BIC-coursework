% runs an entire experiment for benchmarking MY_OPTIMIZER
% on the noise-free testbed. fgeneric.m and benchmarks.m
% must be in the path of Matlab/Octave
% CAPITALIZATION indicates code adaptations to be made

clear all; close all;

addpath('PUT_PATH_TO_BBOB/matlab');  % should point to fgeneric.m etc.
datapath = 'results';  % different folder for each experiment
% opt.inputFormat = 'row';
opt.algName = 'Vector mutation';
opt.comments = 'Two types of mutations at the same time. A low noise vector is generated between [-1,1] for each tournament-selected individual, and a very low noise [-0.01,0.01] is generated for another bunch of individuals.';
maxfunevals = '10 * dim'; % 10*dim is a short test-experiment taking a few minutes 
                          % INCREMENT maxfunevals successively to larger value(s)
minfunevals = 'dim + 2';  % PUT MINIMAL SENSIBLE NUMBER OF EVALUATIONS for a restart
maxrestarts = 1e4;        % SET to zero for an entirely deterministic algorithm

dimensions = [2 5 10];  % small dimensions first, for CPU reasons
functions = benchmarks('FunctionIndices');  % or benchmarksnoisy(...)
instances = [1:15];  % 15 function instances

more off;  % in octave pagination is on by default

t0 = clock;
rand('state', sum(100 * t0));

dim_results=[];
results=[];
f_res=0;

for dim = dimensions
  for ifun = functions
    for iinstance = instances
      fgeneric('initialize', ifun, iinstance, datapath, opt); 

      % independent restarts until maxfunevals or ftarget is reached
      for restarts = 0:maxrestarts
        if restarts > 0  % write additional restarted info
          fgeneric('restart', 'independent restart')
        end
        MY_OPTIMIZER('fgeneric', dim, fgeneric('ftarget'), ...
                     eval(maxfunevals) - fgeneric('evaluations'));
        if fgeneric('fbest') < fgeneric('ftarget') || ...
           fgeneric('evaluations') + eval(minfunevals) > eval(maxfunevals)
          break;
        end  
      end

      disp(sprintf(['  f%d in %d-D, instance %d: FEs=%d with %d restarts,' ...
                    ' fbest-ftarget=%.4e, elapsed time [h]: %.2f'], ...
                   ifun, dim, iinstance, ...
                   fgeneric('evaluations'), ...
                   restarts, ...
                   fgeneric('fbest') - fgeneric('ftarget'), ...
                   etime(clock, t0)/60/60));
               
      f_res = f_res+fgeneric('fbest') - fgeneric('ftarget');

      fgeneric('finalize');
    end
    disp(['      date and time: ' num2str(clock, ' %.0f')]);
    results=[results f_res/length(instances)];
    f_res=0;
  end
  dim_results=[dim_results; results];
  results=[];
  disp(sprintf('---- dimension %d-D done ----', dim));
end

figure();
bar(dim_results(1,:))
figure();
bar(dim_results(2,:));
figure();
bar(dim_results(3,:));

