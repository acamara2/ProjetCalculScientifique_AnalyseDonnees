clear variables;close all;clc;

%% Creation de 100 individus de R2 pour montrer comment s'effectue le changement de repere via l'ACP
nb_indiv = 100;

% Creation d'un nuage de points de R2:
% On cree separement les coordonnees des abscisses et des ordonnees, afin 
% d'avoir un nuage plus etendu dans une dimension que dans l'autre
X1 = randn(nb_indiv,1);
X2 = 5*randn(nb_indiv,1); 
X = [X1 X2];

% On decale le nuage de point. Puisqu'il s'agit de deux lois normales 
% centrees reduites, l'individu moyen est a peu pres nul. Il correspond 
% donc a peu pres a l'origine du repere canonique. On veut pouvoir 
% visualiser le changement de repere, donc on decale le nuage de points
X = X + 5*ones(nb_indiv,2);

% on va faire "tourner" le nuage, pour que les axes de la base trouvee via
% l'ACP ne soient pas confondus avec ceux de la base canonique.
angle = pi/6; 
R = [cos(angle) -sin(angle); sin(angle) cos(angle)]; 
X = X*R; 

%  On affiche le nuage de points dans le repere canonique
figure(1),clf, axis equal, % axis equal : permet d'avoir la meme taille
% des axes pour les abscisses et les ordonnees.
p1 = plot(X(:,1),X(:,2),'r+',0, 0,'mo',...
    [0 5],[0 0],'k--',...
    [0 0],[0 5],'b--','linewidth',2);grid on;% stocker le graphe dans p1 
% permet de generer simplement une legende prenant en compte tous les 
% affichages de la figure

% l'ACP correspond a un changement de repere de l'espace des donnees : le 
% centre du repere devient l'individu moyen, les vecteurs de la base 
% maximisent la dispersion et ne sont pas correles

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULER LA MATRICE DE VARIANCE/COVARIANCE DU TABLEAU DES DONNEES X ET
% LES AXES PRINCIPAUX. REORDONNER CES AXES PAR ORDRE DECROISSANT DU
% CONTRASTE QU'ILS FOURNISSENT
% (cf - TP1 RVB)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mX = mean(X,1);
X_centre = X - mX;
sigma = 1/size(X,1) * (X_centre')*X_centre;

% Calcul des valeurs propres et des vecteurs principaux
[axes,lambda] = eig(sigma);

[~, indices] = sort(diag(lambda),'descend');
axesTri = axes(:,indices);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER LE NOUVEAU REPERE DEFINI PAR LES AXES PRINCIPAUX ET L'ELEMENT 
% MOYEN SUR LA FIGURE (1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1), hold on, axis equal % axis equal : permet d'avoir la meme taille
% des axes pour les abscisses et les ordonnees. Sans cela, il est impossible
% de voir que les deux axes principaux sont orthogonaux
p2 = plot(mX(1), mX(2),'ko',...
    [mX(1) mX(1)+5*axesTri(1,1)],[mX(2) mX(2)+5*axesTri(2,1)],'g--',...
    [mX(1) mX(1)+5*axesTri(1,2)],[mX(2) mX(2)+5*axesTri(2,2)],'m--','linewidth',2);grid on;

title('Changement de repere : repere canonique VS repere principal')
legend([p1;p2],'nuage de points','origine','premier axe canonique','deuxieme axe canonique',...
    'individu moyen','premier axe principal','deuxieme axe principal');



%% Creation de 100 individus de R10 pour montrer l'interet de projeter 
%  sur les composantes principales plutot que sur n'importe quel axe

% Creation d'un echantillon d'individus beaucoup plus disperse sur ses
% deux dernieres variables que sur les autres
X1 =  8*randn(nb_indiv,1);
X2 = 10*randn(nb_indiv,1);
X = randn(nb_indiv,8); 
X = [X,X1,X2];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULER LA MATRICE DE VARIANCE/COVARIANCE DU TABLEAU DES DONNEES X ET
% LES AXES PRINCIPAUX. REORDONNER CES AXES PAR ORDRE DECROISSANT DU
% CONTRASTE QU'ILS FOURNISSENT.
% CALCULER LA MATRICE C DE L'ECHANTILLON X DANS CE NOUVEAU REPERE [i.e. LA 
% PROJECTION DES LIGNES DU TABLEAU CENTRE XC DANS LA NOUVELLE BASE] :
% CHAQUE COLONNE DE C CORRESPOND A CE QUE L'ON APPELLE UNE COMPOSANTE
% PRINCIPALE DE X
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mX = mean(X,1);
X_centre = X - mX;
sigma = 1/size(X,1) * (X_centre')*X_centre;

% Calcul des valeurs propres et des vecteurs principaux
[axes,lambda] = eig(sigma);

[~, indices] = sort(diag(lambda),'descend');
axesTri = axes(:,indices);

C = X_centre*axesTri;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SUR UNE MEME FIGURE, AFFICHER EN ROUGE LA PROJECTION DES INDIVIDUS DE XC
% SUR LES DEUX PREMIERS AXES DE LA BASE CANONIQUE [i.e. EN UTILISANT POUR 
% CHAQUE IND. SES COEFFICIENTS DANS LES DEUX PREMIERES COLONNES DE XC], 
% PUIS EN BLEU LA PROJECTION DE CES INDIVIDUS SUR LES DEUX PREMIERS AXES
% PRINCIPAUX [i.e. EN UTILISANT POUR CHAQUE IND. SES COEFFICIENTS DANS LES
% DEUX PREMIERES COLONNES DE C]
%
% QUESTION 3 RAPPORT :
% QUE REMARQUEZ-VOUS ? (A EXPLIQUER DANS LE RAPPORT)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
% NB : ATTENTION A BIEN AFFICHER LA PROJECTION DES INDIVIDUS DE XC (ET NON
% DE X) SUR LES DEUX PREMIERS AXES CANONIQUES. SINON LES DEUX NUAGES DE
% POINTS NE SERONT PAS CENTRES SUR LE MEME POINT ET IL SERA PLUS DUR D'EN
% TIRER DES CONSEQUENCES
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%


figure(2), hold on, axis equal
plot(X_centre(:,1),X_centre(:,2),'r+',...
    C(:,1),C(:,2),'b+','linewidth',2);grid on;

title('Projections sur axes canoniques VS axes principaux')
legend('projection des individus de XC sur les deux premiers axes de la base canonique',...
    'projection des individus de XC sur les deux premiers axes principaux');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULER L'INFORMATION -- i.e. LA PROPORTION DE CONTRASTE -- CONTENUE 
% DANS LES DEUX PREMIERES COMPOSANTES PRINCIPALES POUR L'ECHANTILLON X, VIA
% LES ELEMENTS SPECTRAUX DE LA MATRICE DE VARIANCE/COVARIANCE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[lambdaTri, ~] = sort(diag(lambda), 'descend');
somme = sum(diag(lambda).^2);
info_axe_1 = lambdaTri(1)^2/somme;
info_axe_2 = lambdaTri(2)^2/somme;
info_axe_3 = info_axe_1 + info_axe_2;
fprintf('Pourcentage d info sur la premiere composante principale = %.3f\n',info_axe_1);
fprintf('Pourcentage d info sur la deuxieme composante principale = %.3f\n',info_axe_2);
fprintf('Pourcentage d info sur les deux premieres composantes    = %.3f\n',info_axe_3);