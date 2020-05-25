clear;
close all;
load donnees;
load exercice_1;
figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.6*L,0.5*H]);

% Seuil de reconnaissance a regler convenablement
s = 5;

% Pourcentage d'information 
per = 0.95;

% Tirage aleatoire d'une image de test :
individu = 3;%randi(37);
posture = 6 ;%randi(6);
chemin = './Images_Projet_2020';
fichier = [chemin '/' num2str(individu+3) '-' num2str(posture) '.jpg'];
Im=importdata(fichier);
I=rgb2gray(Im);
I=im2double(I);
image_test=I(:)';
 

% Affichage de l'image de test :
colormap gray;
imagesc(I);
axis image;
axis off;

% Nombre N de composantes principales a prendre en compte 
% [dans un second temps, N peut etre calcule pour atteindre le pourcentage
% d'information avec N valeurs propres] :
N = 8;

% N premieres composantes principales des images d'apprentissage :
C_app = Xc*W;
C_app = C_app(:,1:N);

% N premieres composantes principales de l'image de test :
individu_moyen = mean(X,1); % Calcul de l'individu moyen
image_testc = image_test - individu_moyen;    % Centrage des donnees
C_test = image_testc*W;
C_test = C_test(1:N);

% Determination de l'image d'apprentissage la plus proche (plus proche voisin) :
indice_min = 1;
valeur_min = norm(C_test - C_app(1,1:N));
for i = 2:n
    if (valeur_min > norm(C_test - C_app(i,1:N)))
        indice_min = i;
        valeur_min = norm(C_test - C_app(i,1:N));
    end
end

% Affichage du resultat :
if valeur_min < s
	individu_reconnu = numeros_individus(fix((indice_min-1)/nb_postures)+1);
    title({['Posture numero ' num2str(posture) ' de l''individu numero '...
        num2str(individu+3)];...
		['Je reconnais l''individu numero ' num2str(individu_reconnu+3)]},'FontSize',20);
else
	title({['Posture numero ' num2str(posture) ' de l''individu numero '...
        num2str(individu+3)];...
		'Je ne reconnais pas cet individu !'},'FontSize',20);
end

% Cr�ation des labels
ListeClass = 0:4;
labelX=zeros(size(X,1));
labelX(1:4) = 1;
labelX(5:8) = 2;
labelX(9:12)= 3;
labelX(13:16)= 4;
if individu == 2
    labelT = 1;
elseif individu == 4
    labelT = 2;
elseif individu == 6
    labelT = 3;
elseif individu == 37
    labelT = 4;
else 
    labelT = 0;
end
K=1;
[Partition] = kppv(C_app,C_test,labelX,K,ListeClass,labelT);


