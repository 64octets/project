function out=diffusion(L,input,iterations)


%Constants
timestep=.1; %Larger timesteps may result in instability.  
%Smaller timesteps may produce no effects

%Inputs
[a b]=size(input);
if b > a %Error catch for column/row vector
    input=input';
end
%input=input(:); %Error catch for column/row vector
minInput=min(min(input));
maxInput=max(max(input));

%Iterate
out=input;
for k=1:iterations
    out = out - timestep*L*out;
end

%Renormalize
out=out-min(min(out))+minInput;
out=out*maxInput./max(max(out));
