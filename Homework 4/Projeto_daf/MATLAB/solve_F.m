function [output] = solve_F(alpha_0,beta,gama,v,Tc1,Tc2,T)
    alpha_1 = @ (T) alpha_0 * (T-Tc1);
    alpha_2 = @ (T) alpha_0 * (T-Tc2);

    F_funct = @(psi_1,psi_2) alpha_1(T) .* psi_1.^2 + alpha_2(T) .* psi_2.^2 + beta*(alpha_1(T).^4+alpha_2(T).^4)/2 + gama*( psi_2.^6 ) / 3 - v * ( 2 .* psi_1 .* psi_2 );
    
    
    i = 0;
    for psi_1 = 0:0.1:60
        i=i+1;
        j=0;
        for psi_2 = 0:0.1:60
            j=j+1;
            F(i,j) = F_funct(psi_1,psi_2);
        end
    end
    
    % FIND MINIMUM
    [val,idx] = min(min(F));
    [x,y] = find(F==val);

    psi = 0:0.1:60;
    output = [psi(x),psi(y)];
end