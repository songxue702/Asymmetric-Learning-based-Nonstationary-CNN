function G = huanyuan(D,m,n,w_patch_size,l_patch_size,p,t,size_hang,size_lie)
%输入矩阵D，以及patch_size*patch_size=size（D，2),重叠率为p,size_hang=56,size_lie=8.
% D=448x2500,m=600,n=120,patch_size=50,p=40
q=w_patch_size-p;%不重叠部分为10
z=l_patch_size-t;
Y=cell(1,size_lie);
for i=1:size_lie
    X=zeros(m,l_patch_size);
    for j = 1:size_hang%56
        if j==1
            X(1:w_patch_size,:)=Re_Line(D((i-1)*size_hang+j,:),w_patch_size,l_patch_size);
        else
            x=Re_Line(D((i-1)*size_hang+j,:),w_patch_size,l_patch_size);
            c=(X((j-1)*q+1:(j-1)*q+p,:)+x(1:p,:))/2;
            X=[X(1:(j-1)*q,:);c;x(p+1:w_patch_size,:)];
        end
    end
    Y{i}=X;
end

G=zeros(m,n);
for i=1:size_lie
    if i==1
        G(:,1:l_patch_size)=Y{i};
    else
        g=(G(:,(i-1)*z+1:(i-1)*z+t)+Y{i}(:,1:t))/2;
        G=[G(:,1:(i-1)*z),g,Y{i}(:,t+1:l_patch_size)];
    end
end
end