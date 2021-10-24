const   ginp='xepviec.inp';
        gout='xepviec.out';

var     gi,go:text;
        n,mint,maxt:longint;
        t,d,c:array[0..1001] of longint;
        f:array[0..10001,0..10001] of longint;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        mint:=10001;
        maxt:=0;
        readln(gi,n);
        for i:=1 to n do
        begin
                readln(gi,t[i],d[i],c[i]);
                mint:=min(mint,d[i]);
                maxt:=max(maxt,c[i]);
        end;
end;

procedure process;
var     i,j,kc,k:longint;
begin
        for i:=1 to n do
                for j:=d[i] to c[i]-t[i] do f[j,j+t[i]]:=1;
        for kc:=1 to maxt-mint do
                for i:=mint to maxt-kc do
                begin
                        j:=i+kc;
                        for k:=i+1 to j-1 do f[i,j]:=max(f[i,j],f[i,k]+f[k,j]);
                end;
end;

procedure output;
begin
        write(go,f[mint,maxt]);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.














