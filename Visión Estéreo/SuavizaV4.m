function [ g ] = SuavizaV4( f )

g=f;
h = double( f);
M=size(f,1);
N=size(f,2);
for i=2:M-1
    for j=2:N-1
        g( i,j) = uint8( (...
        h( i-1, j) + h( i , j-1)  + h( i , j+1) + h( i+1, j) )/4 );
    
    end
end


end

