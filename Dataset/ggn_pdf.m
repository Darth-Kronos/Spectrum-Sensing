% Sample data
beta_1 = ggnoise(1,1000000,1,1);
beta_2 = ggnoise(1,1000000,1,2);
x = randn(1, 1e4);
% Plot the histogram alone
% figure
% h = histogram(beta_1, 100000,'Normalization', 'probability');
% h = histogram(beta_1, 100000,'Normalization', 'probability');
% Plot the curve alone
%
% I could have retrieved values and edges from h (they are stored in the
% Values and BinEdges properties respectively) but I wanted to show how
% to get this information without actually creating a plot
[values, edges] = histcounts(beta_1, 'Normalization', 'probability');
centers = (edges(1:end-1)+edges(2:end))/2;
[values2, edges2] = histcounts(beta_2, 'Normalization', 'probability');
centers2 = (edges2(1:end-1)+edges2(2:end))/2;
figure
g1 = plot(centers, values)
set(g1,'LineWidth',2)
hold on
g2 = plot(centers2,values2)
set(g2,'LineWidth',2)
legend('Beta=1','Beta=2')
grid on

