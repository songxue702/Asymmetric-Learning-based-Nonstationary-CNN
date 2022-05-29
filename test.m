format compact;
addpath(fullfile('utilities'));
useGPU = 0;
load('./model/model.mat');
net.layers = net.layers(1:end-2);
net = vl_simplenn_tidy(net);
if useGPU
    net = vl_simplenn_move(net, 'gpu') ;
end
global index;
for i=1:size(inputs,4)
    index = i;
    if useGPU
        input = gpuArray(inputs(:,:,:,i));
    end  
    res = vl_simplenn(net,input,[],[],'conserveMemory',true,'mode','test'); 
    output = res(end).x;
    if useGPU
    output = gather(output);
    input  = gather(input);
    end  

    outputs1(i,:)=Re_Line(output*A(i),1,6000);
end

oo=huanyuan(outputs1,500,60,100,60,90,50,41,1);

t1=1:1:500;
figure(1);
for i=1:60
    plot(im(:,i)+i,t1,'k')
    hold on; 
end
axis([0 61 1 500])
hold off;
hh=gca;
set(gca,'Ydir','revers','xtick',-0:10:60) 
xlabel({'Trace Number' ,'(a)'}),ylabel('Traveltime(ms)');

figure(2);
for i=1:60
    plot(tSN(:,i)+i,t1,'k')
    hold on; 
end
axis([0 61 1 500])
hold off;
hh=gca;
set(gca,'Ydir','revers','xtick',-0:10:60) 
xlabel({'Trace Number' ,'(b)'}),ylabel('Traveltime(ms)');

figure(3);
for i=1:60
    plot(oo(:,i)+i,t1,'k')
    hold on; 
end
axis([0 61 1 500])
hold off;
hh=gca;
set(gca,'Ydir','revers','xtick',-0:10:60) 
xlabel({'Trace Number' ,'(c)'}),ylabel('Traveltime(ms)');

cha=oo-im;
figure(4);
for i=1:60
    plot(cha(:,i)+i,t1,'k')
    hold on; 
end
axis([0 61 1 500])
hold off;
hh=gca;
set(gca,'Ydir','revers','xtick',-0:10:60) 
xlabel({'Trace Number' ,'(d)'}),ylabel('Traveltime(ms)');


SNR(im,tSN)
SNR(im,oo)



