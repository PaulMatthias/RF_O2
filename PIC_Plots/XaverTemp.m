function XaverTemp(folder,Te,ind1,ind2,nof)

% path=['../' folder '/out/'];
path=folder;
load([path 'M' num2str(nof) '.mat'])

X=M.Tex{ind1}(:,1); % x-domain

Tex_aver=zeros(length(X),1);
Tey_aver=Tex_aver;
Tez_aver=Tex_aver;

r=length(ind1:ind2);

for k=ind1:ind2
   
%     Tex{k}=load([path Tex_files(k).name]);
%     Tey{k}=load([path Tey_files(k).name]);
%     Tez{k}=load([path Tez_files(k).name]);

    Tex_aver=Tex_aver + M.Tex{k}(:,2);
    Tey_aver=Tey_aver + M.Tey{k}(:,2);
    Tez_aver=Tez_aver + M.Tez{k}(:,2);
end

Tex_aver=Te/0.16*Tex_aver/r;
Tey_aver=Te/0.16*Tey_aver/r;
Tez_aver=Te/0.16*Tez_aver/r;


figure
plot(X,Tex_aver,'b')
hold on
plot(X,Tey_aver,'r')
plot(X,Tez_aver,'k')
hold off
grid on
ylabel('temp. [eV]')
title('electron temperature')

end
