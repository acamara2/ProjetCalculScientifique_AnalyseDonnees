clear all
f=fopen('../Fortran/spectrum.txt','r');
 
% Lecture des données qui se trouvent sur 1 colonne
eigenvalues = zeros(50, 1);
i=1;
while feof(f) == 0
   eigenvalueString = fgetl(f);
   eigenvalues(i) = str2double(eigenvalueString);
   i = i+1;
end

disp(eigenvalues);
%Fermeture du fichier texte
fclose(f);

figure;
bar(eigenvalues);
title('Distribution des valeurs propres pour une matrice de type 4 de taille 50');
xlabel('Numéro de la valeur propre');
ylabel('Valeur');