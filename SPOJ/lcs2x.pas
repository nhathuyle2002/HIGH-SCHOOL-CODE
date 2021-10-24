const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,m:longint;
        f,a,b:array[0..1501] of longint;

procedure input;
var     i:longint;
begin
        readln(gi,m,n);
        for i:=1 to m do read(gi,a[i]);readln(gi);
        for i:=1 to n do read(gi,b[i]);readln(gi);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,j,ma,mat:longint;
begin
        fillchar(f,sizeof(f),0);
        for i:=1 to m do
        begin
                ma:=0;
                for j:=1 to n do
                begin
                        mat:=ma;
                        if 2*b[j]<=a[i] then ma:=max(ma,f[j]);
                        if b[j]=a[i] then f[j]:=max(f[j],mat+1);
                end;
        end;
end;

procedure output;
var     i,ans:longint;
begin
        ans:=0;
        for i:=1 to n do ans:=max(ans,f[i]);
        writeln(go,ans);
end;

procedure main;
var     i,t:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,t);
        for i:=1 to t do
        begin
                input;
                process;
                output;
        end;
        close(gi);close(go);
end;

begin
        main;
end.
