load fisheriris
X = meas(:,3:4);
Y = species;
tabulate(Y)

%% Entrenamiento del objeto naiveBayes

NBModel = fitNaiveBayes(X,Y);

%% Dibujamos los contornos
figure
gscatter(X(:,1),X(:,2),Y);
xylim = cell2mat(get(gca,{'Xlim','YLim'})); % Gets current axis limits
hold on
Params = cell2mat(NBModel.Params);
Mu = Params(2*(1:3)-1,1:2); % Extracts the means
Sigma = zeros(2,2,3);
for j = 1:3
    Sigma(:,:,j) = diag(Params(2*j,:)); % Extracts the standard deviations
    ezcontour(@(x1,x2)mvnpdf([x1,x2],Mu(j,:),Sigma(:,:,j)),...
        xylim+0.5*[-1,1,-1,1]) ...
        % Draws contours for the multivariate normal distributions
end
title('Naive Bayes Classifier -- Fisher''s Iris Data')
xlabel('Petal Length (cm)')
ylabel('Petal Width (cm)')
hold off

% Prediccion

predictLabels1 = predict(NBModel,X);
[ConfusionMat1,labels] = confusionmat(Y,predictLabels1)