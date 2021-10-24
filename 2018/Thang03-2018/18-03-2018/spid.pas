const   ginp='spid.inp';
        gout='spid.out';

var     gi,go:text;
        n,m,dem:longint;
        r:int64;
        x,y,z,t:array[0..1000001] of longint;
        d:array[0..1001] of boolean;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m,r);
        for i:=1 to n do readln(gi,x[i],y[i]);
        for i:=1 to m do readln(gi,z[i],t[i]);
end;

function kc(i,j:longint):real;
begin
        kc:=sqrt(sqr(z[i]-x[j])+sqr(t[i]-y[j]));
end;

procedure process;
var     i,j:longint;
begin
        dem:=0;
        fillchar(d,sizeof(d),false);
        for i:=1 to m do
                for j:=1 to n do
                        if (kc(i,j)<=r) and (d[j]=false) then d[j]:=true;
        for i:=1 to n do
                if d[i] then inc(dem);
end;

procedure output;
begin
        write(go,dem);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
