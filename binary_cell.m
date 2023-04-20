
clear all;
name1=['TRS0001.txt'];
for diff=[0.000001]
    cd(['Z:\yanivedery\Avioz\binary\']);
%     mkdir(['diff ',num2str(diff)]);
for perce=[0.275 0.325 0.35 0.375 0.4]%0.05 0.15 0.25

    cd(['Z:\yanivedery\Avioz\binary\diff ',num2str(diff)]);
mkdir([num2str(perce)]);
% sides=1; middl=0.1;
cd(['Z:\yanivedery\Avioz\binary\diff ',num2str(diff),'\',num2str(perce)]);
for i=1:1:100
    
    if i<10 
        name1=['TRS000',num2str(i),'.txt'];
    elseif i<100 
        name1=['TRS00',num2str(i),'.txt'];
    else i<1000 
        name1=['TRS0',num2str(i),'.txt'];
    end
try1=perce<rand(120,300);
%if middl-sides>0
try2=try1.*1;
try2(try1==0)=diff;
    mean_k_vec=log(reshape(try2,1,300*120));
k_field_vec2=mean_k_vec';
save(name1,'k_field_vec2','-ascii');
end
    end
end