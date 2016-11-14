function xbest = MY_OPTIMIZER(FUN, DIM, ftarget, maxfunevals)
% MY_OPTIMIZER(FUN, DIM, ftarget, maxfunevals)
% samples new points uniformly randomly in [-5,5]^DIM
% and evaluates them on FUN until ftarget of maxfunevals
% is reached, or until 1e8 * DIM fevals are conducted.

maxfunevals = min(1e8 * DIM, maxfunevals);
popsize = min(maxfunevals, 200);
fbest = inf;
xpop = 10 * rand(DIM, popsize) - 5;      % initial population

nb_iterations = 100;
nb_mutations = ceil(popsize/5);
tournament_size = floor(2*popsize/5);

for iter = 1:nb_iterations
    
    %% Mutation low noise vector
    % Tournament selection
    indexes=randi(popsize,1,tournament_size);
    new_pop = xpop(:,indexes);
    
    % Mutation
    new_pop = new_pop + 0.5*(2*rand(DIM,tournament_size)-1);
    
    % Mix populations and sort individuals
    xpop = [xpop,new_pop];
    [fvalues, idx] = sort(feval(FUN, xpop)); % evaluate
    
    % keep popsize best individuals
    xpop = xpop(:,idx);
    
    %% Mutation very low noise vector
    % Tournament selection
    indexes=randi(popsize,1,tournament_size);
    new_pop = xpop(:,indexes);
    
    % Mutation
    new_pop = new_pop + 0.01*(2*rand(DIM,tournament_size)-1);
    
    % Mix populations and sort individuals
    xpop = [xpop,new_pop];
    [fvalues, idx] = sort(feval(FUN, xpop)); % evaluate
    
    % keep popsize best individuals
    xpop = xpop(:,idx);
    
    %% Stores best individual
    
    if fbest > fvalues(1)                    % stores best individual
        fbest = fvalues(1);
        xbest = xpop(:,idx(1));
    end
    
    if feval(FUN, 'fbest') < ftarget         % COCO-task achieved
        break;                                 % (works also for noisy functions)
    end
end


