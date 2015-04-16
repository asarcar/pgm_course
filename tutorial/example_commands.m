% general features
load('featuresX.dat')
load('priceY.dat')
featuresX
priceY
A = [1 2; 3 4; 5 6]
B = A([1 3],:) % get 1 and 3 row, all columns
A(:,2) = [10;11;12] % assign 10, 11, 12 to 2nd column
A = [A [100; 101; 102]] % append another column to A
A = [A; [7 13 103]]
C = [A  A] % concatenate two matrices side by side
D = [A; A] % concatenate two matrices to and bottom
C = A .*2 % element wise operation
D = log(A) % function applied to each element
C = A * A'
D = A + ones(size(A))
A(:)' % put all elements of A, put in column vector, and transpose
[val ind] = max(A, [], 2) % val, ind: vectors of max of each row
C = A < 3
D = magic(3)
prod(sum(D,1) == sum(D, 2))
prod(sum(sum(D.*eye(3))) == sum(sum(D.*flipud(eye(3)))))
save x.mat featuresX 
save x.txt featuresX -ascii
delete x.mat
delete x.txt
clear A
who
whos

% plot data
% figure(1); figure(2): multiple figure windows
subplot(1,2,1) % divide to 1x2 figure subplots, context set to 1st figure
t=[0:0.01:1]
y1 = sin(2*pi*4*t)
plot(t, y1)
xlabel('time')
ylable('value')
legend('sin')
title('sin-plot')
axis([0.0 1.0 -1 1])
hold on
subplot(1,2,2)
y2 = cos(2*pi*4*t)
plot(t, y2, 'r')
xlabel('time')
ylable('value')
legend('cos')
title('cos-plot')
axis([0.0 1.0 -1 1])
print 'myPlot.png' -dpng % save figure in file myPlot.png png format 
imagesc(magic(5))
close % close current figure

% control structures
indices=[1:1:10]
v = zeros(length(indices), 1)
for i=indices,
    v(i) = 2^i;
end;
i=1;
while i <= length(indices),
    v(i) = 100;
    if i == 6,
        v(i) = v(i) * 2;
    elseif i > 7,
	break;
    else
	v(i) = v(i) + 1;
    end;
    i = i + 1;
end;

% functions 
function [s,c] = squareAndCube(x)
s = x^2; 
c = x^3;
end;

[z1 z2] = squareAndCube(3);

% Vectorization: Make the octave code run faster
% Submission Tips
