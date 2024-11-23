function [idx] = QRSDetectA(file, M, window_size, alpha, gamma)

S = load(file);
sig = S.val(1,:);

% plot(sig(1:5000))

%------------------------------------------------
%------Linear high-pass filtering----------------

% M-point moving average filter
maf = filter((1/M)* ones(1, M), 1, sig);

% Delay of (M+1)/2 samples
de = filter([zeros(1, (M+1)/2) 1], 1, sig);

LHPF = de - maf;


%-------------------------------------------------------
%-------------Nonlinear low-pass filtering--------------

% Squaring
LHPF_2 = LHPF.^2;

% Sliding-window summation
NLPF = filter(ones(1, window_size), 1, [LHPF_2 zeros(1, fix((window_size-1)/2))]);
NLPF = NLPF(fix((window_size-1)/2)+1:end);

%ali?
%NLPF2 = movsum(LHPF_2, window_size);


% hold on; plot(NLPF(1:5000))
%------------------------------------------------------
%-----------Decision making----------------------------
PEAK = 0;

count = 0;
for i = 1:20:length(NLPF)-29         %find first peak
    p = max(NLPF(i:i+29));
    if p> PEAK
        PEAK = p;
    elseif p<PEAK
        count = count+1;
        if count > 5
            break
        end
    end
end

idx = [];
T = alpha*gamma*PEAK;

currpeak = PEAK;
sw = false;
counter = 0;
co = 0;
for i = 1:20:length(NLPF)-29
    [p, ind] = max(NLPF(i:i+29));
    if p > T && p >= currpeak
        currpeak = p;
        currind = i+ind-1;
        sw = true;
        counter = 0;
        co = 0;
    elseif (p < 0.9*T) && sw
        PEAK = currpeak;
        currpeak = 0;
        sw = false;
        idx = [idx currind];
        T = alpha*gamma*PEAK + (1-alpha)*T;
        counter = 0;
        co = 0;
    elseif p>T && p < currpeak && sw
        counter = counter + 1;
            if counter > 4 %&& currpeak > 0.4 * PEAK
                PEAK = currpeak;
                currpeak = 0;
                sw = false;
                idx = [idx currind];
                T = alpha*gamma*PEAK + (1-alpha)*T;
                counter = 0;
                co = 0;
            end
    elseif p < T && ~sw
        co = co + 1;
        if co > 10
            T = alpha*gamma*PEAK;
            co = 0;
        end
    end
end

end