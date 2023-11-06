
function [output] = solve_F(alpha_0,beta,gama,n,Tc1,Tc2,T,PsiMax,PsiMin,dPsi)
    alpha_1 = @ (T) alpha_0 * (T-Tc1);
    alpha_2 = @ (T) alpha_0 * (T-Tc2);
    
    F_funct = @(psi1,psi2) alpha_1(T) * psi1^2 + alpha_2(T) * psi2^2 + beta*(psi1^4+psi2^4)/2 + gama*( psi2^6 ) / 3 - n * ( 2 * psi1 * psi2 );
    
    
    k = 0;
    mins = [];
    i = 0;
    Psi = PsiMin-4*dPsi:dPsi:PsiMax+4*dPsi;
    for psi_1 = Psi
        i=i+1;
        g=0;
        for psi_2 = Psi
            g=g+1;
            F(i,g) = F_funct(psi_1,psi_2);
            % FIND MINIMUM
            if i > 2 && g > 2
                if(F(i,g-1) > F(i-1,g-1) && F(i-2,g) > F(i-1,g-1) && F(i-1,g) > F(i-1,g-1) && F(i-1,g-2) > F(i-1,g-1))
                    k=k+1;
                    mins(k,:) = [Psi(i-1),Psi(g-1)];
                end                
            end
        end
    end
    
    if k == 0
        output = [0,0];
    else
        output = mins(k,:);
    end
end