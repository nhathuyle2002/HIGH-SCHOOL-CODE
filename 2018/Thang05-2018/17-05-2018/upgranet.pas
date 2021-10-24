const   ginp='upgranet.inp';
        gout='upgranet.out';

var     gi,go:text;
        f:array[0..1001,0..1001] of longint;
        x,y,w:array[0..100001] of longint;
        m,n:longint;
        ans:int64;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to n do f[i,i]:=maxlongint;
        for i:=1 to m do
        begin
                readln(gi,x[i],y[i],w[i]);
                f[y[i],x[i]]:=w[i];f[x[i],y[i]]:=w[i];
        end;
end;

procedure output;
var     i,j,k:longint;
begin
        for k:=1 to n do
                for i:=1 to n do
                        for j:=1 to n do
                                f[i,j]:=max(f[i,j],min(f[i,k],f[k,j]));
        ans:=0;
        for i:=1 to m do
                if f[x[i],y[i]]>w[i] then ans:=ans+f[x[i],y[i]]-w[i];
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        output;
end.

