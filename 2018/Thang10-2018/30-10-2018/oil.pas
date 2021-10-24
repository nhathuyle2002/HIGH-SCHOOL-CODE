Uses    Math;

Const   ginp='oil.inp';
        gout='oil.out';
        maxn=1010;

Var     m,n,k,res:longint;
        s,cl,rd:array[0..maxn,0..maxn] of longint;
        f:array[0..maxn,0..maxn,1..4] of longint;

Function Get(i,j:longint):longint;
Begin
        get:=s[i,j]-s[i-k,j]-s[i,j-k]+s[i-k,j-k];
End;

Function Max3(x,y,z:longint):longint;
Begin
        max3:=x;
        if y>max3 then max3:=y;
        if z>max3 then max3:=z;
End;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(m,n,k);
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        read(s[i,j]);
                        s[i,j]:=s[i,j]+s[i-1,j]+s[i,j-1]-s[i-1,j-1];
                end;
                readln;
        end;
End;

Procedure Init;
Var     i,j,kk:longint;
Begin
        for i:=k to m do
                for j:=k to n do
                        f[i,j,1]:=max3(get(i,j),f[i-1,j,1],f[i,j-1,1]);
        for i:=k to m do
                for j:=n-k+1 downto 1 do
                        f[i,j,2]:=max3(get(i,j+k-1),f[i-1,j,2],f[i,j+1,2]);
        for i:=m-k+1 downto 1 do
                for j:=n-k+1 downto 1 do
                        f[i,j,3]:=max3(get(i+k-1,j+k-1),f[i+1,j,3],f[i,j+1,3]);
        for i:=m-k+1 downto 1 do
                for j:=k to n do
                        f[i,j,4]:=max3(get(i+k-1,j),f[i+1,j,4],f[i,j-1,4]);
        for i:=k to m do
                for j:=k to n do
                begin
                        rd[i-k+1,i]:=max(rd[i-k+1,i],get(i,j));
                        cl[j-k+1,j]:=max(cl[j-k+1,j],get(i,j));
                end;
        for kk:=k+1 to m do
                for i:=1 to m-kk+1 do
                begin
                        j:=i+kk-1;
                        rd[i,j]:=max(rd[i,j-1],rd[i+1,j]);
                end;
        for kk:=k+1 to n do
                for i:=1 to n-kk+1 do
                begin
                        j:=i+kk-1;
                        cl[i,j]:=max(cl[i,j-1],cl[i+1,j]);
                end;
End;

Procedure Process;
Var     i,j:longint;
Begin
        res:=0;
        for i:=k to m do
                for j:=i+k to m-k do
                        res:=max(res,rd[1,i]+rd[i+1,j]+rd[j+1,m]);
        for i:=k to n do
                for j:=i+k to n-k do
                        res:=max(res,cl[1,i]+cl[i+1,j]+cl[j+1,n]);
        for i:=k to m-k do
                for j:=k to n-k do
                        res:=max3(res,max(f[i,j,1]+f[i,j+1,2]+rd[i+1,m],
                                        f[i,j+1,2]+f[i+1,j+1,3]+cl[1,j]),
                                      max(f[i+1,j+1,3]+f[i+1,j,4]+rd[1,i],
                                        f[i+1,j,4]+f[i,j,1]+cl[j+1,n]));
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Init;
        Process;
        Close(input); Close(output);
End.
