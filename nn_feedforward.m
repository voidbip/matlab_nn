function [response]=nn_feedforward(X,w,nn_structure)
% [response,activation]=nn_feedforward(X,w,nn_stucture)
% Get response of neural network to input X size Mx1
% w is array of weights to use.
% nn_structure. Array that lists the number of input, intermediary and output nodes. ie. [M,i1,i2,i3..,K]
% assumes network is fully connected.


    [M,N]=size(X);
    K = nn_structure(end);
    if N!=nn_structure(1)
        error("Neural network must have same number of input nodes as input values in the data");
    endif;

    L = length(nn_structure);

    response   = zeros(M,sum(nn_structure));

    ai = [0,cumsum(nn_structure)];
    ws = 0;

    l=1;

    for i=1:M
        response(i,1+ai(l):ai(l+1))=X(i,:);
    end

    for i=1:M
        ws=0;
        for l=2:L
            w_size =  (1+nn_structure(l-1))*nn_structure(l);
            %disp("Stopped in feedforward...");
            %keyboard;
            response(i,(1+ai(l)):ai(l+1)) = sigmoid(reshape(w((ws+1):(ws+(w_size))),nn_structure(l),1+nn_structure(l-1))*[1;response(i,(1+ai(l-1)):ai(l)).']);
            ws += w_size;
        end
    end

end
