function scale()

dimv=400;
omega_pe=3.99e9;
lambda_db=0.021;

for l=1:int16(dimv/2)
  scale(l)=0;
end

%scaling for velocities
for l=1:int16(dimv/2)
  scale(int16(dimv/2)+1-l)=l/(dimv/2)*omega_pe*lambda_db*8;
end

plot(scale);
end

