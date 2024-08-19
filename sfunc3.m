function myFunction_sfun(block)
    setup(block);
end

function setup(block)
    % Register number of input and output ports
    block.NumInputPorts  = 1;
    block.NumOutputPorts = 4;

    % Set up input port
    block.InputPort(1).Dimensions       = 1;
    block.InputPort(1).DirectFeedthrough = true;
    block.InputPort(1).SamplingMode      = 'sample';

    % Set up output ports
    for i = 1:4
        block.OutputPort(i).DimensionsMode = 'Fixed';
        block.OutputPort(i).SamplingMode = 'sample';
    end

    % Set sample time
    block.SampleTimes = [-1, 0];

    % Register functions for initialization and output
    block.RegBlockMethod('InitializeConditions', @InitializeConditions);
    block.RegBlockMethod('Outputs', @Outputs);
end

function InitializeConditions(block)
    % Initialize the S-function block
end

function Outputs(block)
    % Calculate the outputs of the S-function block

    % Get the input value
    x = block.InputPort(1).Data;

    % Call the external C function and get the output values
    [a, b, c, d] = myFunction(x);

    % Set the output values
    block.OutputPort(1).Data = a;
    block.OutputPort(2).Data = b;
    block.OutputPort(3).Data = c;
    block.OutputPort(4).Data = d;
end

function [a, b, c, d] = myFunction(x)
    % The logic from your C code
    if(x < 0.006)
        a = 0;
        b = 0;
        c = 0;
        d = 0;
    elseif(x >= 0.006 && x < 0.012)
        a = 1;
        b = 0;
        c = 0;
        d = 0;
    elseif(x >= 0.012 && x < 0.018)
        a = 1;
        b = 1;
        c = 0;
        d = 0;
    elseif(x >= 0.018 && x < 0.024)
        a = 1;
        b = 1;
        c = 1;
        d = 0;
    else
        a = 1;
        b = 1;
        c = 1;
        d = 1;
    end
end
