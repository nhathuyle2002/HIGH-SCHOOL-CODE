const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n:longint;
        a:array[0..501,0..501] of int64;
        f:array[0..501,0..501] of boolean;

procedure inp;
var     i,j:longint;
begin
        for i:=1 to n do
        begin
                for j:=1 to n do
                begin
                        read(gi,a[i,j]);
                        a[i,j]:=a[i,j]+a[i-1,j]+a[i,j-1]-a[i-1,j-1];
                end;
                readln(gi);
        end;
end;

procedure D_P;
var     i,j:longint;
begin
        fillchar(f,sizeof(f),false);
        for i:=1 to n do
                for j:=1 to n do
                begin
                        if (f[i-1,j]=false) and ((a[i,j]-a[i-1,j]) mod 2=0) then f[i,j]:=true;
                        if (f[i,j-1]=false) and ((a[i,j]-a[i,j-1]) mod 2=0) then f[i,j]:=true;
                end;
end;

procedure outp;
begin
        if f[n,n] then writeln(go,'YES') else writeln(go,'NO');
end;

procedure main;
var     i,t:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,t);
        for i:=1 to t do
        begin
                readln(gi,n);
                inp;
                D_P;
                outp;
        end;
        close(gi);close(go);
end;

begin
        main;
end.
