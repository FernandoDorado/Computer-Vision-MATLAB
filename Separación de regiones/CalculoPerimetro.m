%% calculo del perímetro

% valor inicial del perímetro antes del recorrido
perim = 0;
%variable que se pone a cero cuando haya dado la vuelta completa  al contorno para así parar
seguir = 1;
visitado = zeros(M, N);
% valor inicial del punto actual
ic = iini; jc = jini;
while seguir
	%cálculo del punto vecino siguiente
	for di=-1:1
		for dj=-1:1
			%vecino considerado
			ivec = ic+di; jvec = jc+dj;
			
            % si el vecino no ha sido visitado y es del contorno
			if(visitado(ivec,jvec) < 1 && b(ivec,jvec) > 0)
				isig = ivec; jsig = jvec; % se marca como el siguiente
			end
		end
	end
	
	% se suma al perímetro el segmento actual
	perim = perim+sqrt((isig-ic)^2+(jsig-jc)^2);
    
    % se comprueba si se ha dado la vuelta
    if(isig == iini && jsig == jini)
        %se desactiva la marca que permite seguir
        seguir = 0;
    end
    
    %se actualiza la posición
    ic = isig; jc = jsig;
    
    %se actualiza la matriz de visitados
    visitado(isig, jsig) = 1;
end
          