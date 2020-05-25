% version am�lior�e de la m�thode de l'espace invariant (v1)
% avec utilisation de la projection de Raleigh-Ritz 

% Donn�es
% A          : matrice dont on cherche des couples propres
% m          : taille maximale de l'espace invariant que l'on va utiliser
% percentage : pourcentage de la trace recherch�
% eps        : seuil pour d�terminer si un vecteur de l'espace invariant a converg�
% maxit      : nombre maximum d'it�ration de la m�thode

% R�sultats
% W : vecteur contenant les valeurs propres (ordre d�croissant)
% V : matrice des vecteurs propres correspondant
% n_ev : nombre de valeurs propres calcul�es
% it : nombre d'it�rations de la m�thode
% flag : indicateur sur la terminaison de l'algorithme
    %  flag = 0  : on converge en ayant atteint le pourcentage de la trace recherch�
    %  flag = 1  : on converge en ayant atteint la taille maximale de l'espace
    %  flag = -3 : on n'a pas converg� en maxit it�rations

function [ W, V, n_ev, it, flag ] = subspace_iter_v3( A, m, percentage, nb_prod, eps, maxit )


    % calcul de la norme de A (pour le crit�re de convergence d'un vecteur (gamma))
    normA = norm(A, 'fro');

    % trace de A
    traceA = trace(A);

    % valeur correspondnat au pourcentage de la trace � atteindre
    vtrace = percentage*traceA;

    n = size(A,1);
    W = zeros(n,1);

    % num�ro de l'it�ration courante
    k = 0;
    % somme courante des valeurs propres
    eigsum = 0.0;
    % nombre de vecteurs ayant converg�s
    nb_c = 0;

    % indicateur de la convergence
    conv = 0;

    % on g�n�re un ensemble initial de m vecteurs orthogonaux
    Vr = randn(n, m);
    Vr = mgs(Vr);

    % rappel : conv = (eigsum >= trace) | (nb_c == m)
    while (~conv & k < maxit),
        
        k = k+1;
        %% Y <- A^p*V
        for i = 1:nb_prod
            Vr(:, nb_c+1:end) = A*Vr(:, nb_c+1:end);
        end
        %% orthogonalisation
        Vr = mgs_block(Vr, nb_c);
        
        %% Projection de Rayleigh-Ritz
        [Wr, Vr] = rayleigh_ritz_projection(A, Vr);
        
        %% Quels vecteurs ont converg� � cette it�ration
        analyse_cvg_finie = 0;
        % nombre de vecteurs ayant converg� � cette it�ration
        nbc_k = 0;
        % nb_c est le dernier vecteur � avoir converg� � l'it�ration pr�c�dente
        i = nb_c + 1;
        
        while(~analyse_cvg_finie),
            % tous les vecteurs de notre sous-espace ont converg�
            % on a fini (sans avoir obtenu le pourcentage)
            if(i > m)
                analyse_cvg_finie = 1;
            else
                % est-ce que le vecteur i a converg�
                
                % calcul de la norme du r�sidu
                aux = A*Vr(:,i) - Wr(i)*Vr(:,i);
                res = sqrt(aux'*aux);
                
                if(res >= eps*normA)
                    % le vecteur i n'a pas converg�,
                    % on sait que les vecteurs suivants n'auront pas converg� non plus
                    % => it�ration finie
                    analyse_cvg_finie = 1;
                else
                    % le_vecteur i a converg�
                    % un de plus
                    nbc_k = nbc_k + 1;
                    % on le stocke ainsi que sa valeur propre
                    W(i) = Wr(i);
                    
                    % on met � jour la somme des valeurs propres
                    eigsum = eigsum + W(i);
                    
                    % si cette valeur propre permet d'atteindre le pourcentage
                    % on a fini
                    if(eigsum >= vtrace)
                        analyse_cvg_finie = 1;
                    else
                        % on passe au vecteur suivant
                        i = i + 1;
                    end
                end
            end
        end
        
        % on met � jour le nombre de vecteurs ayant converg�s
        nb_c = nb_c + nbc_k;
        
        % on a converg� dans l'un de ces deux cas
        conv = (nb_c == m) | (eigsum >= vtrace);
        
    end
    
    if(conv)
        % mise � jour des r�sultats
        n_ev = nb_c;
        V = Vr(:, 1:n_ev);
        W = W(1:n_ev);
        it = k;
    else
        % on n'a pas converg�
        W = zeros(1,1);
        V = zeros(1,1);
        n_ev = 0;
        it = k;
    end

    % on indique comment on a fini
    if(eigsum >= vtrace)
        flag = 0;
    else if (n_ev == m)
            flag = 1;
        else
            flag = -3;
        end
    end

end