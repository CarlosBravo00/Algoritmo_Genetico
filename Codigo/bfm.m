%% BENCHMARK TEST FUNCTIONS FOR OPTIMISATION METHODS
% -*- mode: matlab; coding: iso-8859-1; -*-
% Copyright (c) Jorge M. Cruz-Duarte. All rights reserved.
%
% Based in Jamil & Yang (2013), "A Literature Survey of Benchmark Functions 
%   For Global Optimization Problems".
% 
% - Run "bfm" at the command window to see all functions
% - Run "F = bfm(NoF)" to get the NoF-th function as a handle function
% - Run "[F,Details] = bfm(NoF)" to get more information about the function
%
% Enjoy it! XD bfm
%

%%
function [F, info] = bfm(functionID,vectorPoint)

switch nargin
    case 0    % Show the available functions     
        % Load list
        number_of_functions = numel(localfunctions); 
        
        % Show list
        fprintf('\nID\t%30s\tDim\tf_min=f(x*)\n','Name');
        fprintf('------------------------------------------------------------\n');
        for i = 1 : number_of_functions
            [~,l] = eval(sprintf('f%d(nan(1,10));',i));
            
            % Read dimensions
            Dim = num2str(l.MaxDimensions);
            if l.MaxDimensions == 0, Dim = 'N'; end
            
            % Read Foptimum
            if ~ischar(l.Foptimum), l.Foptimum = num2str(l.Foptimum); end
            
            % Print list
            fprintf('%2d\t%30s\t%2s\t%s\n',i,l.Name, Dim, l.Foptimum);
        end
        return;
        
    case 2
        % Check if vectorPoint is 1xN
        vectorPoint     = vectorPoint(:)';
        
        % Evaluate the function
        [F,info]        = feval(sprintf('f%d',functionID),vectorPoint);
        
    otherwise
        error('Introduce functionID and vectorPoint!');
end
end

%% Benchmark Functions:

% 1. Cosine Mixture Function                    [ok]
function [f,details]    = f1(X)
f                       = -0.1*sum(cos(5*pi*X)) + sum(X.^2);

details.Name            = 'Cosine Mixture';
details.MaxDimensions   = 0;
details.Constraints     = [-1 1];
details.Xoptimum        = 0;
details.Foptimum        = '-N/10';
details.Comments        = 'f_obj = -dim/10';
end

% 2. Bukin 2 Function                           [ok]
function [f,details]    = f2(X)
f                       = 100*(X(2)^2 + 0.01*(X(1) + 10)^2 + 1) + 0.01*(X(1) + 10)^2 - 100;

details.Name            = 'Bukin 2';
details.MaxDimensions   = 2;
details.Constraints     = [-15 -5;-3 3];
details.Xoptimum        = [-10 0]';
details.Foptimum        = 0;
details.Comments        = 'none';
end

% 3. Keane Function                             [to review]
function [f,details]    = f3(X)
f                       = -(sin(X(1) - X(2))^2)*(sin(X(1) + X(2))^2)/sqrt(X(1)^2 + X(2)^2);

details.Name            = 'Keane';
details.MaxDimensions   = 2;
details.Constraints     = [1 10];
details.Xoptimum        = [0 1.39325;1.39325 0];
details.Foptimum        = -0.673668;
details.Comments        = 'two global optimum';
end

% 4. Mishra 2 Function                          [ok]
function [f,details]    = f4(X)
N                       = numel(X);
Xn                      = N - 0.5*sum(X(1:N-1) + X(2:N));
f                       = (1 + Xn)^Xn;

details.Name            = 'Mishra 2';
details.MaxDimensions   = 0;
details.Constraints     = [0 1];
details.Xoptimum        = 1;
details.Foptimum        = 2;
details.Comments        = 'none';
end

% 5. Trigonometric 1 Function                   [ok] (?)
function [f,details] = f5(X)
N                     = length(X); I = 1:N;
Xn                    = N - sum(cos(X));
f                     = sum((Xn + I(:).*(1 - cos(X(:))) - sin(X(:))).^2);

details.Name          = 'Trigonometric 1';
details.MaxDimensions = 0;
details.Constraints   = [0 pi];
details.Xoptimum      = 0;
details.Foptimum      = 0;
details.Comments      = 'none';
end

% 6. Schmidt Vetters Function                   [to review]
function [f,details]    = f6(X)
f                       = (1/(1 + (X(1) - X(2))^2) + sin(pi*X(2)/2 + X(3)/2) + exp(((X(1) + X(2))/X(2) - 2)^2));

details.Name            = 'Schmidt Vetters';
details.MaxDimensions   = 3;
details.Constraints     = [0 10];
details.Xoptimum        = [0.78547 0.78547 0.78547]';
details.Foptimum        = 3;
details.Comments        = 'It has bugs!';
end

% 7. Exponential Function                       [ok]
function [f,details]    = f7(X)
f                       = -exp(-0.5*sum(X.^2));

details.Name            = 'Exponential';
details.MaxDimensions   = 0;
details.Constraints     = [-1 1];
details.Xoptimum        = 0;
details.Foptimum        = -1;
details.Comments        = 'none';
end

% 8. Hosaki Function                            [ok]
function [f,details]    = f8(X)
f                       = (1 - 8*X(1) + 7*X(1)^2 - 7/3*X(1)^3 + ...
    1/4*X(1)^4)*X(2)^2*exp(-X(2));

details.Name            = 'Hosaki';
details.MaxDimensions   = 2;
details.Constraints     = [0 5;0 6];
details.Xoptimum        = [4 2]';
details.Foptimum        = -2.3458;
details.Comments        = 'none';
end

% 9. Giunta Function                            [ok]
function [f,details]    = f9(X)
f                       = 0.6 + sum(sin(16/15*X - 1) + (sin(16/15*X - 1)).^2 + 1/50*sin(4*(16/15*X - 1)));

details.Name            = 'Giunta';
details.MaxDimensions   = 0;
details.Constraints     = [-1 1];
details.Xoptimum        = [0.45834282 0.45834282]';
details.Foptimum        = 0.060447042;
details.Comments        = 'none';
end

% 10. Quadratic Function                        [ok]
function [f,details]    = f10(X)
f                       = -3803.84 - 138.08*X(1) - 232.92*X(2) + 128.08*X(1)^2 + 203.64*X(2)^2 + 182.25*X(1)*X(2);

details.Name            = 'Quadratic';
details.MaxDimensions   = 2;
details.Constraints     = [-10 10];
details.Xoptimum        = [0.19388 0.48513]';
details.Foptimum        = -3873.7243;
details.Comments        = 'none';
end

% 11. Schwefel 2                                [ok]
function [f,details]    = f11(X)
f                       = 0;
for i = 1 : numel(X)
    f = f + (sum(X(1:i)))^2; 
end

details.Name            = 'Schwefel 2';
details.MaxDimensions   = 0;
details.Constraints     = [-5 5];
details.Xoptimum        = 0;
details.Foptimum        = 0;
details.Comments        = 'none';
end

% 12. Sphere Function                           [ok]
function [f,details]    = f12(X)
f                       = sum(X.^2);

details.Name            = 'Sphere';
details.MaxDimensions   = 0;
details.Constraints     = [-10 10];
details.Xoptimum        = 0;
details.Foptimum        = 0;
details.Comments        = 'none';
end

% 13. Camel Function - Six Hump Function        [ok]
function [f,details]    = f13(X)
f                       = (4 - 2.1*X(1)^2 + X(1)^4/3)*X(1)^2 + ...
    X(1)*X(2) + (4*X(2)^2 - 4)*X(2)^2;

details.Name            = 'Six Hump Camel';
details.MaxDimensions   = 2;
details.Constraints     = [-5 5];
details.Xoptimum        = [-0.08984201368301331 0.7126564032704135;
    0.08984201368301331 -0.7126564032704135];
details.Foptimum        = -1.031628453;
details.Comments        = '2 global optimum';
end

% 14. Parsopoulos Function                      [ok]
function [f,details]    = f14(X)
f                       = cos(X(1))^2 + (sin(X(2)))^2;

details.Name            = 'Parsopoulos';
details.MaxDimensions   = 2;
details.Constraints     = [-5 5];
details.Xoptimum        = [pi/2 0];
details.Foptimum        = 0;
details.Comments        = '12 global optimum';
end

% 15. Deb 1 Function                            [ok]
function [f,details]    = f15(X)
f                       = -1/numel(X)*sum((sin(5*pi*X)).^6);

details.Name            = 'Deb 1';
details.MaxDimensions   = 0;
details.Constraints     = [-1 1];
details.Xoptimum        = 0;
details.Foptimum        = -1;
details.Comments        = '5 global optimum per dimension';
end

% 16. Cross in Tray Function                    [ok]
function [f,details]    = f16(X)
f                       = -0.0001*(abs(sin(X(1))*sin(X(2))*exp(abs(100 - ...
    sqrt((X(1)^2 + X(2)^2))/pi))) + 1)^0.1;

details.Name            = 'Cross in Tray';
details.MaxDimensions   = 2;
details.Constraints     = [-15 15];
details.Xoptimum        = [1.349406685353340 1.349406608602084];
details.Foptimum        = -2.06261218;
details.Comments        = 'Its optimum value is irrational';
end

% 17. Colville Function                         [ok]
function [f,details]    = f17(X)
f                       = 100*(X(1)^2 - X(2))^2 + (X(1) - 1)^2 + ...
    (X(3) - 1)^2 + 90*(X(3)^2 - X(4))^2 + 10.1*((X(2) - 1)^2 + ...
    (X(4) - 1)^2) + 19.8*(X(2) - 1)*(X(4) - 1);

details.Name            = 'Colville';
details.MaxDimensions   = 4;
details.Constraints     = [-10 10];
details.Xoptimum        = [1 1 1 1];
details.Foptimum        = 0;
details.Comments        = 'none';
end

% 18. Needle Eye Function                       [improve]
function [f,details]    = f18(X)
centre                  = 0.0001; 
X                       = abs(X); 
N                       = numel(X); 
f                       = 0; 
fp                      = 0;
for i = 1 : N
    if  X(i) > centre
        fp = 1;
        f = f + 100 + X(i);
    else
        f = f + 1;
    end
end
if fp == 0
    f = f/N; 
end

details.Name            = 'Needle Eye';
details.MaxDimensions   = 0;
details.Constraints     = [-10 10];
details.Xoptimum        = 0;
details.Foptimum        = 1;
details.Comments        = 'multimodal';
end

% 19. Branin 1 Function                         [ok]
function [f,details]    = f19(X)
f                       = (X(2) - 1.275*(X(1)/pi)^2 + 5*X(1)/pi - 6)^2 + ...
    (10 - 5/4/pi)*cos(X(1)) + 10;

details.Name            = 'Branin 1';
details.MaxDimensions   = 2;
details.Constraints     = [-5 10; 0 15];
details.Xoptimum        = [-pi 12.275];
details.Foptimum        = 0.39788735772973816;
details.Comments        = '3 global optimum';
end

% 20. Beale Function                            [ok]
function [f,details]    = f20(X)
f                       = (1.5 - X(1) + X(1)*X(2))^2 + (2.25 - X(1) + ...
    X(1)*X(2)^2)^2 + (2.625 - X(1) + X(1)*X(2)^3)^2;

details.Name            = 'Beale';
details.MaxDimensions   = 2;
details.Constraints     = [-4.5 4.5];
details.Xoptimum        = [3 0.5];
details.Foptimum        = 0;
details.Comments        = 'none';
end

% 21. Alpine 1 Function                         [ok]
function [f,details]    = f21(X)
f                       = sum(abs(X.*sin(X) + 0.1*X));

details.Name            = 'Alpine 1';
details.MaxDimensions   = 0;
details.Constraints     = [-10 10];
details.Xoptimum        = 0;
details.Foptimum        = 0;
details.Comments        = 'none';
end

% 22. Rana Function                             [ok]
function [f,details]    = f22(X)
f                       = 0; 
N                       = numel(X);
for i = 1 : N - 1
    t1 = sqrt(norm(X(i + 1) + X(i) + 1));
    t2 = sqrt(norm(X(i + 1) - X(i) + 1));
    f = f + (X(i + 1) + 1)*cos(t2)*sin(t1) + X(i)*cos(t1)*sin(t2);
end

details.Name            = 'Rana';
details.MaxDimensions   = 0;
details.Constraints     = [-500.000001 500.000001];
details.Xoptimum        = [-500 -500];
details.Foptimum        = '-511.70430*N + 511.68714';
details.Comments        = 'none';
end

% 23. Bird Function                             [ok]
function [f,details]    = f23(X)
f                       = sin(X(1))*exp((1 - cos(X(2)))^2) + ...
    cos(X(2))*exp((1 - sin(X(1)))^2) + (X(1) - X(2))^2;

details.Name            = 'Bird';
details.MaxDimensions   = 2;
details.Constraints     = [-2*pi 2*pi];
details.Xoptimum        = [4.701055751981055 3.152946019601391; ...
    -1.58214217055011,-3.130246799635430];
details.Foptimum        = -106.7645367198034;
details.Comments        = '2 global optimum';
end

% 24. Step Function                             [ok]
function [f,details]    = f24(X)
f                       = sum((floor(X + 0.5)).^2);

details.Name            = 'Step';
details.MaxDimensions   = 0;
details.Constraints     = [-100 100];
details.Xoptimum        = 0;
details.Foptimum        = 0;
details.Comments        = 'none';
end

% 25. Wayburn Seader 1 Function                 [ok]
function [f,details]    = f25(X)
f                       = (X(1)^6 + X(2)^4 - 17)^2 + (2*X(1) + X(2) - 4)^2;

details.Name            = 'Wayburn Seader 1';
details.MaxDimensions   = 2;
details.Constraints     = [-5 5];
details.Xoptimum        = [1 2; 1.597 0.806];
details.Foptimum        = 0;
details.Comments        = 'none';
end

% 26. Box Betts Quadratic Sum Function
function [f,details]    = f26(X)
i                       = 1:10;
g                       = exp(-0.1*(i + 1)*X(1)) - ...
    exp(-0.1*(i + 1)*X(2)) - exp(((-0.1*(i + 1)) - exp(-i - 1))*X(3));
f                       = sum(g.^2);

details.Name            = 'Box Betts Quadratic Sum';
details.MaxDimensions   = 3;
details.Constraints     = [0.9 1.2; 9 11.2; 0.9 1.2];
details.Xoptimum        = [1 10 1];
details.Foptimum        = 0;
details.Comments        = 'none';
end

% 27. Bartels Conn Function
function [f,details]    = f27(X)
f                       = abs(X(1)^2 + X(2)^2 + X(1)*X(2)) + ...
    abs(sin(X(1))) + abs(cos(X(2)));

details.Name            = 'Bartels Conn';
details.MaxDimensions   = 2;
details.Constraints     = [-500 500];
details.Xoptimum        = 0;
details.Foptimum        = 1;
details.Comments        = 'none';
end

% 28. Cube Function                             [ok]
function [f,details]    = f28(X)
f                       = 100*(X(2) - X(1)^3)^2 + (1 - X(1))^2;

details.Name            = 'Cube';
details.MaxDimensions   = 2;
details.Constraints     = [-10 10];
details.Xoptimum        = [1 1];
details.Foptimum        = 0;
details.Comments        = 'none';
end

% 29. Ackley 1 Function                         [ok]
function [f,details]    = f29(X)
N                       = numel(X);
f                       = -20*exp(-0.02*sqrt(sum(X.^2)/N)) - ...
    exp(sum(cos(2*pi*X))/N) + 20 + exp(1);

details.Name            = 'Ackley 1';
details.MaxDimensions   = 0;
details.Constraints     = [-35 35];
details.Xoptimum        = 0;
details.Foptimum        = 0;
details.Comments        = 'none';
end

% 30. Rosenbrock Function                       [ok]
function [f,details]    = f30(X)
f                       = sum(100*(X(2:end) - X(1:end-1).^2).^2 + ...
    (X(1:end-1) - 1).^2);

details.Name            = 'Rosenbrock';
details.MaxDimensions   = 0;
details.Constraints     = [-30 30];
details.Xoptimum        = 1;
details.Foptimum        = 0;
details.Comments        = 'none';
end

% 31. Trid 6 Function                           [ok]
function [f,details]    = f31(X)
f                       = sum((X - 1).^2) - sum(X(2:end).*X(1:end-1));

details.Name            = 'Trid 6';
details.MaxDimensions   = 6;
details.Constraints     = [-20 20];
details.Xoptimum        = [6 10 12 12 10 6];
details.Foptimum        = -50;
details.Comments        = 'none';
end

% 32. Hansen Function
function [f,details]    = f32(X)
i                       = 0:4;
f                       = sum((i + 1).*cos(i*X(1) + i + 1))*...
    sum((i + 1).*cos((i + 2)*X(2) + i + 1));

details.Name            = 'Hansen';
details.MaxDimensions   = 2;
details.Constraints     = [-10 10];
details.Xoptimum        = [-7.589893 -7.708314];
details.Foptimum        = -2.3458;
details.Comments        = 'none';
end

% 33. Xor Function
function [f,details]    = f33(X)
f1                      = (1 + exp(-X(7)/(1 + exp(-X(1) - X(2) - X(5))) - ...
    X(8)/(1 + exp(-X(3) - X(4) - X(6))) - X(9)))^(-2);
f2                      = (1 + exp(-X(7)/(1 + exp(-X(5))) - ...
    X(8)/(1 + exp(-X(6))) - X(9)))^(-2);
f3                      = (1 - (1 + exp(-X(7)/(1 + exp(-X(1) - X(5))) - ...
    X(8)/(1 + exp(-X(6))) - X(9)))^(-1))^2;
f4                      = (1 - (1 + exp(-X(7)/(1 + exp(-X(2) - X(5))) - ...
    X(8)/(1 + exp(-X(4) - X(6))) - X(9)))^(-1))^2;
f                       = f1 + f2 + f3 + f4;

details.Name            = 'Xor';
details.MaxDimensions   = 9;
details.Constraints     = [-1 1];
details.Xoptimum        = [1 -1 1 -1 -1 1 1 -1 0.421134];
details.Foptimum        = 0.9597588	;
details.Comments        = 'none';
end

% 34. Ursem Waves Function
function [f,details]    = f34(X)
f                       = -0.9*X(1)^2 + (X(2)^2 - 4.5*X(2)^2)*X(1)*X(2) + ...
    4.7*cos(3*X(1) - X(2)^2*(2 + X(1)))*sin(2.5*pi*X(1));

details.Name            = 'Ursem Waves';
details.MaxDimensions   = 2;
details.Constraints     = [-0.9 1.2; -1.2 1.2];
details.Xoptimum        = 1.2;
details.Foptimum        = -8.5536;
details.Comments        = 'none';
end

% 35. Chichinadze Function
function [f,details]    = f35(X)
f                       = X(1)^2 - 12*X(1) + 11 + 10*cos(pi*X(1)/2) + ...
    8*sin(5*pi*X(1)/2) - (1/5)^0.5*exp(-0.5*(X(2) - 0.5)^2);

details.Name            = 'Chichinadze';
details.MaxDimensions   = 2;
details.Constraints     = [-30 30];
details.Xoptimum        = [5.90133 0.5];
details.Foptimum        = -43.3159;
details.Comments        = 'none';
end

% 36. Rastrigin Function                        [ok]
function [f,details]    = f36(X)
f                       = 10*numel(X) + sum(X.^2 - 10*cos(2*pi*X));

details.Name            = 'Rastrigin';
details.MaxDimensions   = 0;
details.Constraints     = [-5 5];
details.Xoptimum        = 0;
details.Foptimum        = 0;
details.Comments        = 'none';
end

% 37. Helical Valley Function                   [improve]
function [f,details]    = f37(X)
if X(1) >= 0
    th = atan(X(1)/X(2))/(2*pi);
else
    th = atan(X(1)/X(2) + 0.5)/(2*pi); 
end
f                       = 100*((X(2) - 10*th)^2 + ...
    (sqrt(X(1)^2 + X(2)^2) - 1)) + X(3)^2;

details.Name            = 'Helical Valley';
details.MaxDimensions   = 3;
details.Constraints     = [-10 10];
details.Xoptimum        = [1 0 0];
details.Foptimum        = 0;
details.Comments        = 'none';
end

% 38. Paviani Function
function [f,details]    = f38(X)
f                       = sum((log(X - 2)).^2 + (log(10 - X)).^2) - ...
    (prod(X))^0.2;

details.Name            = 'Paviani';
details.MaxDimensions   = 10;
details.Constraints     = [2.0001 10];
details.Xoptimum        = 9.351*[1 1 1 1 1 1 1 1 1 1];
details.Foptimum        = -45.778;
details.Comments        = 'none';
end

% 39. Powell 4 Function
function [f,details]    = f39(X)
f                       = (X(3) + 10*X(1))^2 + 5*(X(2) - X(4))^2 + ...
    (X(1) - 2*X(2))^4 + 10*(X(3) - X(4))^4;

details.Name            = 'Powell 4';
details.MaxDimensions   = 4;
details.Constraints     = [-4 5];
details.Xoptimum        = 0;
details.Foptimum        = 0;
details.Comments        = 'none';
end

% 40. Weierstrass Function
function [f,details]    = f40(X)
k                       = 0 : 20; 
a                       = 0.5; 
b                       = 3; 
N                       = numel(X); 
f                       = 0;
for i = 1 : N
    f                   = f + sum(a.^k.*cos(2*pi*b.^k*(X(i) + 0.5))) - ...
        N*sum(a.^k.*cos(pi*b.^k));
end

details.Name            = 'Weierstrass';
details.MaxDimensions   = 0;
details.Constraints     = [-0.5 0.5];
details.Xoptimum        = 0;
details.Foptimum        = 4;
details.Comments        = 'none';
end

% 41. Watson Function                           [ok]
function [f,details]    = f41(X)
if size(X,1) ~= 1
    X                   = X'; 
end
f                       = X(1)^2; 
j1                      = 0 : 4; 
j2                      = 0 : 5;
for i = 0 : 29
    a                   = i/29;
    f                   = f + (sum((j1 - 1).*a.^(j1).*X(j1 + 1)) - ...
        (sum(a.^(j2).*X(j2 + 1)))^2 - 1)^2;
end

details.Name            = 'Watson';
details.MaxDimensions   = 6;
details.Constraints     = [-5 5];
details.Xoptimum        = [-0.0158 1.012 1.260 -1.513 0.9928];
details.Foptimum        = 0.002288;
details.Comments        = 'none';
end

% 42. Drop Wave Function                        [ok]
function [f,details]    = f42(X)
f1                      = sum(X.^2);
f                       = -(1 + cos(12*sqrt(f1)))/(2 + 0.5*f1);

details.Name            = 'Drop Wave';
details.MaxDimensions   = 0;
details.Constraints     = [-5.12 5.12];
details.Xoptimum        = 0;
details.Foptimum        = -1;
details.Comments        = 'none';
end


% 43. deVilliers Glasser 1 Function
function [f,details]    = f43(X)
i                       = 1 : 24;
ti                      = 0.1*(i - 1);
yi                      = 60.137*1.371.^ti.*sin(3.112*ti + 1.761);
f                       = sum((X(1)*X(2).^ti.*sin(X(3)*ti + X(4)) - yi).^2);

details.Name            = 'deVilliers Glasser 1';
details.MaxDimensions   = 4;
details.Constraints     = [1 100];
details.Xoptimum        = [60.137 1.371 3.112 1.761];
details.Foptimum        = 0;
details.Comments        = 'none';
end

% 44. Stochastic Function                       [ok]
function [f,details]    = f44(X)
N                       = numel(X); 
i                       = ones(size(X)); 
i(:)                    = (1 : N);
eps_                    = rand(size(X));
f                       = sum(eps_.*abs(X - 1./i));

details.Name            = 'Stochastic';
details.MaxDimensions   = 0;
details.Constraints     = [-5 5];
details.Xoptimum        = nan;
details.Foptimum        = 0;
details.Comments        = 'Xoptimum = 1/N';
end

% 45. Gulf Research Problem function
function [f,details]    = f45(X)
i                       = 1 : 99;
ui                      = 25 + (-50*log(0.01*i)).^(1/1.5);
f                       = sum((exp((-(ui - X(2)).^X(3))/X(1)) - 0.01*i).^2);

details.Name            = 'Gulf Research Problem';
details.MaxDimensions   = 3;
details.Constraints     = [0 5];
details.Xoptimum        = [50 25 1.5];
details.Foptimum        = 0;
details.Comments        = 'none';
end

% 46. Salomon Function
function [f,details]    = f46(X)
f1                      = sqrt(sum(X.^2));
f                       = 1 - cos(2*pi*f1) + 0.1*f1;

details.Name            = 'Salomon';
details.MaxDimensions   = 0;
details.Constraints     = [-100 100];
details.Xoptimum        = 0;
details.Foptimum        = 0;
details.Comments        = 'none';
end

% 47. Griewank Function
function [f,details]    = f47(X)
i                       = 1 : numel(X);
f                       = sum(X.^2)/4000 - prod(cos(X./sqrt(i))) + 1;

details.Name            = 'Griewank';
details.MaxDimensions   = 0;
details.Constraints     = [-50 50];
details.Xoptimum        = 0;
details.Foptimum        = 0;
details.Comments        = 'none';
end

% 48. Whitley Function
function [f,details]    = f48(X)
f                       = 0; 
N                       = numel(X);
for i = 1 : N
    f                   = f + sum((100*(X(i)^2 - X).^2 + ...
        (1 - X).^2).^2/4000 - cos(100*(X(i)^2 - X).^2 + (1 - X).^2 + 1));
end
details.Name            = 'Whitley';
details.MaxDimensions   = 0;
details.Constraints     = [-10.24 10.24];
details.Xoptimum        = 1;
details.Foptimum        = 0;
details.Comments        = 'none';
end

% 49. Damavandi Function
function [f,details]    = f49(X)
f                       = (1 - abs((sin(pi*(X(1) - 2))*sin(pi*(X(2) - 2)))...
    /(pi^2*(X(1) - 2)*(X(2) - 2)))^5)*(2 + (X(1) - 7)^2 + 2*(X(2) - 7)^2);

details.Name            = 'Damavandi';
details.MaxDimensions   = 2;
details.Constraints     = [0 14];
details.Xoptimum        = 2;
details.Foptimum        = 0;
details.Comments        = 'none';
end

% 50. deVilliers Glasser 2 Function
function [f,details]    = f50(X)
i                       = (1 : 24); 
ti                      = 0.1*(i - 1);
yi                      = 53.81*(1.27.^ti).*tanh(3.012*ti + ...
    sin(2.13*ti)).*cos(exp(0.507).*ti);
f                       = sum((X(1)*(X(2).^ti).*tanh(X(3).*...
    ti + sin(X(4).*ti)).*cos(ti.*exp(X(5))) - yi).^2);

details.Name            = 'deVilliers Glasser 2';
details.MaxDimensions   = 5;
details.Constraints     = [1 6];
details.Xoptimum        = [53.81 1.27 3.012 2.13 0.507];
details.Foptimum        = 0;
details.Comments        = 'none';
end

% 51. 2n minima
function [f,details]    = f51(X)
f                       = sum(X.^4 - 16*X.^2 + 5*X);
details.Name            = 'Second minima';
details.MaxDimensions   = 0;
details.Constraints     = [-5 5];
details.Xoptimum        = -2.9;
details.Foptimum        = 0;
details.Comments        = 'none';
end


% ------------------------- Test
function [f,details]    = f52(X)
A                       = 2;
N                       = numel(X);
idx                     = 1 : N;
f                       = sum((X-idx*A).^2); % Sweeps columns and sum

details.Name            = 'Shifted Jong (A=2)';
details.MaxDimensions   = 0;
%     details.Constraints   = [-5 5].*idx';
details.Constraints     = [-5 5]*N;
details.Xoptimum        = nan;
details.Foptimum        = 0;
%     details.Comments      = 'Optimum is shifted by A units on each dimension';
details.Comments        = 'Xoptimum = 2*(1:N)';
end

% %% Functions with multiple test functions
% % -Rosenbrock + Jong 
% function [f,details]    = f1001(X)
% fIDs = [30 12 36];
% nbIDs = length(fIDs);
% 
% f = 0; 
% for idx = 1 : nbIDs
%     [fTest, detailsTest] = bfm(fIDs(idx),X);
%    f = f + fTest;
%    detailsTest.f = fTest;
%    if idx == 1
%        details = repmat(detailsTest,1,nbIDs);
%    else
%        details(idx) = detailsTest;
%    end
% end
% 
% % details.Name            = 'Function block 1';
% % details.MaxDimensions   = 0;
% % %     details.Constraints   = [-5 5].*idx';
% % details.Constraints     = [-5 5]*N;
% % details.Xoptimum        = nan;
% % details.Foptimum        = 0;
% % %     details.Comments      = 'Optimum is shifted by A units on each dimension';
% % details.Comments        = 'Xoptimum = 2*(1:N)';
% end