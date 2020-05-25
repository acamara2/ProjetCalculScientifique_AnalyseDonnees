clear;
close all;
load donnees;
load exercice_8;
figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.6*L,0.5*H]);

% Seuil de reconnaissance a regler convenablement
s = 20;

% Pourcentage d'information 
per = 0.95;

% Tirage aleatoire d'une image de test :
individu = randi(37);
posture = randi(6);
chemin = './Images_Projet_2020';
fichier = [chemin '/' num2str(individu+3) '-' num2str(posture) '.jpg'];
Im=importdata(fichier);
I=im2double(Im);
image_test=I(:)';
 

% Affichage de l'image de test :

imagesc(I);
axis image;
axis off;

% Nombre N de composantes principales a prendre en compte 
% [dans un second temps, N peut etre calcule pour atteindre le pourcentage
% d'information avec N valeurs propres] :
N = 8;

% Nombre K de voisins a prendre en compte pour le kppv
K = 3;

% N premieres composantes principales des images d'apprentissage :
C_app = Xc*W;
C_app = C_app(:,1:N);

% N premieres composantes principales de l'image de test :
individu_moyen = mean(X,1); % Calcul de l'individu moyen
image_testc = image_test - individu_moyen;    % Centrage des donnees
C_test = image_testc*W;
C_test = C_test(1:N);

% Determination de l'image d'apprentissage la plus proche (plus proche voisin) :
labelA = repmat(numeros_individus,nb_postures,1);
labelA = labelA(:)';
[individu_reconnu, reconnu] = kppv(C_app, C_test, labelA, K, s);

% Affichage du resultat :
if reconnu
    title({['Posture numero ' num2str(posture) ' de l''individu numero '...
        num2str(individu+3)];...
		['Je reconnais l''individu numero ' num2str(individu_reconnu+3)]},'FontSize',20);
else
	title({['Posture numero ' num2str(posture) ' de l''individu numero '...
        num2str(individu+3)];...
		'Je ne reconnais pas cet individu !'},'FontSize',20);
end
