clear all;

% c = imread('5part_per_bin.png');
% 
% figure; image(c)
% axis image

%%
% Let's extract a rectangle in the blue (3rd) plane, and binarize the
% image for levels < 80 (white pixels are logical 'true'):
cc=0;
% i = c(1:533, 1:583, 3);
for varval=[0.1 1:1:7] %[0.5 1.5 1.9]%[0.1 0.2 0.3 0.4] %[0.1 1:1:5] %
% for varval=[0.3 1 3]
    cc=cc+1;
    count=0;
    if 0.1<varval & varval<0.4
        temp3=(['Z:\avioz\binary\diff 0.001\',num2str(varval)]);
    elseif varval<6
        temp3=(['Z:\avioz\preferential flow bifurcations2\Head 100\Var ',num2str(varval)]);
    else
        temp3=(['Z:\yanivedery\Avioz\Head 100\Var ',num2str(varval)]);
%         temp3=(['Z:\yanivedery\Avioz\binary\diff 0.001\',num2str(varval)]);
%          temp3=(['Z:\yanivedery\Avioz\power law\',num2str(varval)]);
    end
    cd(temp3);
% cd(['Z:\avioz\preferential flow bifurcations2\Head 100\Var ',num2str(varval)]);
% cd(['Z:\Verify no kinz 002\no kinz 002\120X300\',num2str(varval)]);
% load([num2str(varval),' Particle_fd.mat']); 
for ii=1:1:99
    if exist([num2str(ii),' part_per_bin.dat']) + exist([num2str(ii),' BTC.dat'])>2
bi1=importdata([num2str(ii),' part_per_bin.dat']);
K_val=importdata([num2str(ii),' K_field_test.dat']);
% K_val_var(ii)=var(reshape(K_val,1,120*300));
% bi1_var(ii)=var(reshape(bi1,1,120*300));

if sum(sum(bi1))>0
bi2=zeros(120);
% bi3=bi2+bi1(:,300-240+1:300-120);
bi2=bi2+bi1(:,300-119:end);
% bi2=bi1;
bi = (bi2>10);
    count=count+1;

    K_val_var(count)=var(reshape(K_val,1,120*300));
bi1_var(count)=var(reshape(bi1,1,120*300));
% figure;
% imagesc(bi)
% colormap gray
% axis image

%%
% figure (120+cc); hold on;
cd(['E:\OneDrive - Technion\סטודנטים\פרויקטנטים\אביעוז דגן\fractal dimension codes\boxcount']);
[n,r] = boxcount(bi,'slope');
[D] = hausDim( bi );
[fd2]=FractalDimension(bi);
% cd(['Z:\Verify no kinz 002\no kinz 002\120X300\',num2str(varval)]);
% cd(['Z:\avioz\preferential flow bifurcations2\Head 100\Var ',num2str(varval)]);
cd(temp3);

%%
% The boxcount shows that the local exponent is approximately constant for
% less than one decade, in the range 8 < R < 128 (the 'exact' value of Df
% depends on the threshold, 80 gray levels here):

df = -diff(log(n))./diff(log(r));
if count==1 df_all=df;
else df_all(count, :)=df; end
mean_fd(count)=mean(df(4:end-1));
% disp(['Fractal dimension, Df = ' num2str(mean(df(4:end-1))) ' +/- ' num2str(std(df(4:end-1)))]);
clear('n','r')
void_frac2(count)=sum(sum(bi1>0))/(120*300);
void_frac(count)=sum(sum(bi>0))/(120*120);
% 
btc=importdata([num2str(ii),' BTC.dat']);
% if varval <0.4 tort_vec=btc(:,end).*btc(:,end-2);
% else tort_vec=btc(:,end); end
tort_vec=btc(:,end).*btc(:,end-2);

loc=find(tort_vec>0);
mean_PP_tot(count)=mean(tort_vec(loc)./60);
std_PP_tot(count)=std(tort_vec./60);
% pp_tryout=importdata([num2str(ii),' path_ways.dat']);
% [a1 b1]=size(pp_tryout); 
% vec_pp_tryout=reshape(pp_tryout',1, a1*b1);
% loc=find(vec_pp_tryout==300);
% tort_vec=vec_pp_tryout(loc(1:end-1)+2);
% tort_vec2=tort_vec(find(tort_vec<300));
% if ii==1
% pp_vec_total= [tort_vec2];
% else
% pp_vec_total= [pp_vec_total tort_vec2];
% end
% mean_PP_tot(ii)=mean(tort_vec2./60);
% std_PP_tot(ii)=std(tort_vec2./60);

all(count,1)=mean_fd(count);
all(count,2)=mean_PP_tot(count);
all(count,3)=void_frac2(count);
all(count,4)=fd2;
all(count,5)=D;


% figure(5); hist(pp_vec./60,1000)
% title(['Torturosity Hist Mean = ',num2str(mean_PP_tot(j)),' STD = ',num2str(std_PP_tot(j))]);
% %F5(j)=getframe(gcf);
% close (figure(5));


end
end
end
if count>0
%     cd(['Z:\yanivedery\Avioz\binary\diff 0.001\']);
% save([ 'Particle_fd_huss ',num2str(varval),'.mat'],'all');
clear df;

%  saveas(gcf,[num2str(varval),'mean_fd.fig']);
%     saveas(gcf,[num2str(varval),'mean_fd.png']);
%     close(figure(120+cc));
end
% disp(['Fractal dimension, Df = ' num2str(mean(mean_fd)) ' +/- ' num2str(std(mean_fd))]);
loc=find(mean_PP_tot>0);
mean_tort(cc)=mean(mean_PP_tot(loc));
mean_void(cc)=mean(void_frac);
mean_void2(cc)=mean(void_frac2);
mean_D(cc)=mean(all(1:count,5));
mean_fd2(cc)=mean(all(count,4));
mean_fractal(cc)=mean(mean_fd);

mean_K_val_var(cc)=mean(K_val_var);
mean_bil_var(cc)=mean(bi1_var);
% 
% mean_all(varval,1)=mean_fd(count);
% mean_all(varval,2)=mean_PP_tot(ii);
% mean_all(varval,3)=void_frac(count);
% mean_all(varval,4)=mean_fd(count);
% mean_all(varval,5)=D;

end
%
% for varval=1:1:5 %[0.3 1 3]
%  cd(['Z:\avioz\preferential flow bifurcations2\Head 100\Var ',num2str(varval)]);
%  load([num2str(varval),' Particle_fd_huss.mat']);
%   
% mean_tort(varval)=mean(all(:,2));
% mean_void(varval)=mean(all(:,3));
% mean_D(varval)=mean(all(:,5));
% mean_fractal(varval)=mean(all(:,1));
 save(['All_mean_fd_tort_void_bound10.mat'],'mean_tort','mean_void','mean_D','mean_fractal','mean_fd2');
% end

%%
 x_temp1=[0.1 1:7] %[0.1 0.2 0.3 0.4];% 0.1 1:5 % [0.5 1.5 1.9]
 figure (10);
                 [hAx,hLine1,hLine2]=plotyy(x_temp1,mean_tort,x_temp1,mean_D);
                 ylabel(hAx(1),'Tortourosity') % left y-axis 
                ylabel(hAx(2),'Huss Dim') % right y-axis
                
                hLine1.MarkerEdgeColor = 'b';
                hLine2.MarkerEdgeColor = 'r';
                 set(hAx(2) ,'FontSize',16);
                 hLine1.Marker  = 'O';
                hLine2.Marker  = 'O';
%             set(gca, 'XTickLabel',{'Var 0.1','Var 1','Var 2','Var 3','Var 4','Var 5'})
%             x_temp1=[0.1 1:5];
            figure(10); hold on;
            
            
             void=1-mean_void;
%  x_temp1=[0.1 0.2 0.3 0.5];% 0.1 1:5
 figure (11);
                 [hAx,hLine1,hLine2]=plotyy(x_temp1,mean_tort,x_temp1,void);
                 ylabel(hAx(1),'Tortourosity') % left y-axis 
                ylabel(hAx(2),'Void fraction') % right y-axis
                
                hLine1.MarkerEdgeColor = 'b';
                hLine2.MarkerEdgeColor = 'r';
                 set(hAx(2) ,'FontSize',16);
                 hLine1.Marker  = 'O';
                hLine2.Marker  = 'O';
%             set(gca, 'XTickLabel',{'Var 0.1','Var 1','Var 2','Var 3','Var 4','Var 5'})
%             x_temp1=[0.1 1:5];
            figure(10); hold on;
       y_tort=mean_tort;
       y_huss=mean_D;
       y_void1=1-mean_void;
              y_void2=1-mean_void2;