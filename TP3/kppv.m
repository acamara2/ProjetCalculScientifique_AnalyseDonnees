
%--------------------------------------------------------------------------
function [individu_reconnu, reconnu]  = kppv(C_app, C_test, labelA, K, seuil)

ecarts = vecnorm(C_test - C_app, 2, 2);

%fprintf('ecart min : %f\n', min(ecarts));

[ecartsTri, indiceTri] = sort(ecarts);

labelTri = labelA(indiceTri);

labelTri = labelTri(1:K);

reconnu = (sum(ecartsTri(1:K) < seuil) > 0);

if reconnu
    labelSeuil = labelTri(ecartsTri(1:K) < seuil);
    individu_reconnu = mode(labelSeuil);
else
    individu_reconnu = 0;
end

end


