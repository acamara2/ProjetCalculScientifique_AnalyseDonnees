clear;
close all;
load donnees;
load exercice_1;
figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.6*L,0.5*H]);

nb_individus = 37;

% Seuil de reconnaissance
s = 20;

% Tirage aleatoire d'une image de test :
chemin = './Images_Projet_2020';

% Calcul de l'individu moyen
individu_moyen = mean(X,1);

% Nombre N de composantes principales a prendre en compte
N = 8;

% Nombre K de voisins a prendre en compte pour le kppv
K = 5;

% N premieres composantes principales des images d'apprentissage :
C_app = Xc*W;
C_app = C_app(:,1:N);

nb_individus_tot = 37;
nb_postures_tot = 6;
nb_tests = nb_individus_tot*nb_postures_tot; % Nombre de tests à effectuer
individus_tests = zeros(nb_tests,1);         % Numéros des individus testés
individus_predis = zeros(nb_tests,1);        % Numéros des individus prédis

for i=1:nb_tests
    % Choix de l'individu et de la posture
    individus_tests(i) = 1 + mod(i,37);
    posture = randi(6);
    
    % Import de l'image
    fichier = [chemin '/' num2str(individus_tests(i)+3) '-' num2str(posture) '.jpg'];
    Im=importdata(fichier);
    I=rgb2gray(Im);
    I=im2double(I);
    image_test=I(:)';

    % CalN premieres composantes principales de l'image de test
    image_testc = image_test - individu_moyen;    % Centrage des donnees
    C_test = image_testc*W;
    C_test = C_test(1:N);

    % Determination de l'image d'apprentissage la plus proche (plus proche voisin) :
    labelA = repmat(numeros_individus,nb_postures,1);
    labelA = labelA(:)';
    [individus_predis(i), reconnu] = kppv(C_app, C_test, labelA, K, s);
end


% Afficher la matrice de confusion
mat_confusion = confusionchart(individus_tests,individus_predis);
mat_confusion = mat_confusion.NormalizedValues;
nb_essais =  sum(mat_confusion, 'all');
nb_succes = sum(diag(mat_confusion), 'all');
err = nb_succes/nb_essais*100;
fprintf("Pourcentage de réussite = %2.2f%%\n",err);