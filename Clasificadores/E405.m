load fisheriris
X = meas(:,3:4);
Y = species;
tabulate(Y)

%% Entrenamiento del objeto naiveBayes

Md1 = fitcnb(X,Y);
Mdl = fitcnb(X,Y,...
    'ClassNames',{'setosa','versicolor','virginica'})
%% Dibujamos los contornos
% figure
% gscatter(X(:,1),X(:,2),Y);
% xylim = cell2mat(get(gca,{'Xlim','YLim'})); % Gets current axis limits
% hold on
% Params = cell2mat(NBModel.Params);
% Mu = Params(2*(1:3)-1,1:2); % Extracts the means
% Sigma = zeros(2,2,3);
% for j = 1:3
%     Sigma(:,:,j) = diag(Params(2*j,:)); % Extracts the standard deviations
%     ezcontour(@(x1,x2)mvnpdf([x1,x2],Mu(j,:),Sigma(:,:,j)),...
%         xylim+0.5*[-1,1,-1,1]) ...
%         % Draws contours for the multivariate normal distributions
% end
% title('Naive Bayes Classifier -- Fisher''s Iris Data')
% xlabel('Petal Length (cm)')
% ylabel('Petal Width (cm)')
% hold off
% 
% % Prediccion
% 
% predictLabels1 = predict(NBModel,X);
% [ConfusionMat1,labels] = confusionmat(Y,predictLabels1)

figure
gscatter(X(:,1),X(:,2),Y);
h = gca;
cxlim = h.XLim;
cylim = h.YLim;
hold on
Params = cell2mat(Mdl.DistributionParameters); 
Mu = Params(2*(1:3)-1,1:2); % Extract the means
Sigma = zeros(2,2,3);
for j = 1:3
    Sigma(:,:,j) = diag(Params(2*j,:)).^2; % Create diagonal covariance matrix
    xlim = Mu(j,1) + 4*[1 -1]*sqrt(Sigma(1,1,j));
    ylim = Mu(j,2) + 4*[1 -1]*sqrt(Sigma(2,2,j));
    ezcontour(@(x1,x2)mvnpdf([x1,x2],Mu(j,:),Sigma(:,:,j)),[xlim ylim])
        % Draw contours for the multivariate normal distributions 
end
h.XLim = cxlim;
h.YLim = cylim;
title('Naive Bayes Classifier -- Fisher''s Iris Data')
xlabel('Petal Length (cm)')
ylabel('Petal Width (cm)')
hold off