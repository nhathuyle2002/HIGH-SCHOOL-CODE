Uses    Math;

Const   ginp='hcn.inp';
        gout='hcn.out';
        maxx=1007;
        nn=16;
        maxbit=1 shl nn-1;

Var     n,res:longint;
        a:array[0..maxx,0..maxx] of longint;
        l,r,g:array[0..maxbit] of longint;

Procedure Create;
Var     x,i,ii:longint;
Begin
        for x:=1 to maxbit-1 do
        begin
                ii:=0;
                for i:=1 to nn do
                        if x shr (i-1) and 1=0 then
                        begin
                                if l[x]=0 then l[x]:=i;
                                r[x]:=i;
                                g[x]:=max(g[x],i-ii);
                                ii:=i;
                        end;
                g[x]:=max(g[x],i-ii);
        end;
End;

Procedure Enter;
Var     i,j,xx,sum:longint;
        x,y:array[0..101] of longint;
Begin
        readln(n);
        for i:=1 to n do readln(x[i],y[i]);
        x[n+1]:=x[1]; y[n+1]:=y[1];

        for j:=0 to maxx do a[0,j]:=a[0,j] and 1;
        for i:=1 to maxx do
                for j:=0 to maxx do
                begin
                        a[i,j]:=(a[i-1,j]+a[i,j]) and 1;
                        if j mod nn=0 then sum:=0;
                        sum:=sum+a[i,j] shr (j mod nn);
                        a[i,j]:=sum;
                end;
End;

Procedure Process;
Var     i1,i2,j,jj:longint;
        b:array[0..maxx] of longint;
Begin
        res:=0;
        for i1:=1 to maxx do
        begin
                for j:=1 to (maxx+1) div nn do b[j]:=maxbit;
                jj:=0;
                for i2:=i1 to maxx do
                        for j:=1 to (maxx+1) div nn do
                        begin
                                b[j]:=b[j] and a[i2,nn*j-1];
                                if b[j]=maxbit then res:=max(res,(i2-i1+1)*(nn*j-1-jj)) else
                                begin
                                        res:=max(max(res,g[b[j]]),(i2-i1+1)*(nn*(j-1)+l[b[j]]-jj-1));
                                        jj:=nn*(j-1)+r[b[j]];
                                end;
                        end;
        end;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Create;
        Enter;
        Process;
        Close(input); Close(output);
End.
