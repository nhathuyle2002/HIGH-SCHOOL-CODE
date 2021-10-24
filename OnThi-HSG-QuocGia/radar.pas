Const   ginp='radar.inp';
        gout='radar.out';
        oo=2*trunc(1e9);

Var     r0,dx,dy:int64;
        x,y:array[0..2] of int64;

Function Gcd(x,y:int64):int64;
Begin
        if y=0 then exit(x);
        gcd:=gcd(y,x mod y);
End;

Procedure Enter;
Var     g:int64;
Begin
        readln(x[0],y[0],r0);
        read(x[1],y[1],x[2],y[2]);
        g:=gcd(abs(x[1]-x[2]),abs(y[1]-y[2]));
        dx:=(x[1]-x[2]) div g; dy:=(y[1]-y[2]) div g;
End;

Function Dis(x1,y1,x2,y2:real):real;
Begin
        dis:=sqrt(sqr(x2-x1)+sqr(y2-y1));
End;

Procedure Process;
Var     l,r,mid,mid0,pl,pr:int64;
Begin
        l:=-oo; r:=oo;
        while l+1<r do
        begin
                mid:=(l+r) div 2;
                if dis(x[1]+l*dx,y[1]+l*dy,x[0],y[0])>=dis(x[1]+r*dx,y[1]+r*dy,x[0],y[0]) then l:=mid else r:=mid;
        end;
        if dis(x[1]+l*dx,y[1]+l*dy,x[0],y[0])<=dis(x[1]+r*dx,y[1]+r*dy,x[0],y[0]) then mid0:=l else mid0:=r;
        if dis(x[1]+mid0*dx,y[1]+mid0*dy,x[0],y[0])>r0 then
        begin
                write(0);
                exit;
        end;
        l:=mid0; r:=oo;
        while l+1<r do
        begin
                mid:=(l+r) div 2;
                if dis(x[1]+mid*dx,y[1]+mid*dy,x[0],y[0])>r0 then r:=mid else l:=mid;
        end;
        if dis(x[1]+r*dx,y[1]+r*dy,x[0],y[0])<=r0 then pr:=r else pr:=r-1;
        l:=-oo; r:=mid0;
        while l+1<r do
        begin
                mid:=(l+r) div 2;
                if dis(x[1]+mid*dx,y[1]+mid*dy,x[0],y[0])>r0 then l:=mid+1 else r:=mid;
        end;
        if dis(x[1]+l*dx,y[1]+l*dy,x[0],y[0])<=r0 then pl:=l else pl:=l+1;
        write(pr-pl+1);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
