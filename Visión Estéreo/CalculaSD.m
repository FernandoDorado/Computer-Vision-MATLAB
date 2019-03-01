function sum=CalculaSD(Im1,Im2,tam,cr,cs)

sum=0;
[Nmax,Mmax]=size(Im1);
for i=cr(1) - tam(1):cr(1)+tam(1)
    for j=cr(2) - tam(2):cr(2)+tam(2)
        k= i-cr(1)+cs(1);
        l= j-cr(2)+cs(2);
        
        if (i>=1)&&(j>=1)&&(k>=1)&&(l>=1)...
                &&(i<=Nmax)&&(j<=Mmax)&&(k<=Nmax)&&(l<=Mmax)
            sum = sum+abs(Im1(i,j)-Im2(k,l));
        end
        
    end
end

