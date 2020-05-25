function  per = perNComposante(valeur_propres,N)
  per = sum(valeur_propres(1:N))/sum(valeur_propres);
end