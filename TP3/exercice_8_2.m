clear;
close all;
load exercice_8;
h = figure('Position',[0,0,0.67*L,0.67*H]);
figure('Name','RMSE en fonction du nombre de composantes principales','Position',[0.67*L,0,0.33*L,0.3*L]);

% Calcul de la RMSE entre images originales et images reconstruites :
RMSE_max = 0;

% Composantes principales des donnees d'apprentissage
C = Xc*W;

X_reconstruit = repmat(individu_moyen,n,1);
for q = 1:n-1 %0:n-1
    X_reconstruit = X_reconstruit + C(:,q).*(W(:,q)');
    figure(1);
    set(h,'Name',['Utilisation des ' num2str(q) ' premieres composantes principales']);
    hold off;
    for k = 1:n
        subplot(nb_individus,nb_postures,k);
        img = reshape(X_reconstruit(k,:), nb_lignes, nb_colonnes,3);
        imagesc(img);
        hold on;
        axis image;
        axis off;
    end
    
    figure(2);
    hold on;
    RMSE = sqrt(mean(mean((X-X_reconstruit).^2)));
    RMSE_max = max(RMSE,RMSE_max);
    plot(q,RMSE,'r+','MarkerSize',8,'LineWidth',2);
    axis([0 n-1 0 1.1*RMSE_max]);
    set(gca,'FontSize',20);
    hx = xlabel('$q$','FontSize',30);
    set(hx,'Interpreter','Latex');
    ylabel('RMSE','FontSize',30);
    
    pause(0.01);
end
