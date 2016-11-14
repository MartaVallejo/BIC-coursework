% Here is defined the function the ANN has to approximate.

function y = func(x)
    y=5*(sinc(x(1,:))+sinc(x(2,:)));
end