function [Sx, alphao, fo] =autofam(x, fs, df , dalpha)
    Np=pow2 (nextpow2 (fs/df ) ) ;
    L=Np/4;
    P=pow2 (nextpow2 (fs/dalpha/L));
    N=P*L;
    if length (x) <N
        x(N)=0;
    elseif length (x) >N
        x=x(l:N);
    end
    NN= (P-l) *L+Np;
    XX=X;
    Xx(NN)=0;
    xx=xx ( : );
    X=zeros (Np, P);
    for k=0:P-l
        X( : ,k+l) =xx(k*L+l:k*L+Np);
    end
    a=hamming (Np);
    XW=diag(a) *X;
    XW=X ;
    XFl=fft (XW);
    XFl=fftshift (XF1);
    XF1= [XF1(:,P/2+l:P) XF1(:,l:P/2) ];
    E= zeros (Np, P);
    for k=-Np/2:Np/2-l
        for m=0:P-l
            E(k+Np/2+l,m+l) =exp(-i*2*pi*k*m*L/Np);
        end
    end
    XD=XF1.*E;
    XD=conj (XD' );
    XM=zeros (P,Np^2) ;
    for k=l:Np
        for l=1:Np
            XM(:,(k-l)*Np+l)=(XD(:,k) .*conj(XD(:,1) ) );
        end
    end
    XF2=fft (XM);
    XF2=fftshift (XF2);
    XF2= [XF2(:,Np^2/2+l:Np^2 ) XF2(:,l:Np^2/2) ];
    XF2=XF2 (P/4 : 3*P/4 , : );
    M=abs (XF2);
    alphao=-l:l/N:l;
    fo=-.5:l/Np: .5;
    Sx=zeros (Np+1, 2*N+1);
    for kl=l: P/2+1
        for k2=l:Np^2
            if rem(k2,Np) ==0
                l=Np/2-l;
            else
                l=rem(k2,Np) -Np/2-1;
            end
            k=ceil (k2/Np) -Np/2-1;
            p=kl-P/4-l;
            alpha= (k-1) /Np+ (p-1) /L/P;
            f=(k+l)/2/Np;
            if alpha<-l | alpha>l
                k2=k2+l;
            elseif f<-.5 | f> .5
                k2=k2+l;
            else
                kk=1+Np*(f+.5);
                ll=1+N*(alpha+1);
                Sx(kk,ll) =M(kl,k2);
            end
        end
end
