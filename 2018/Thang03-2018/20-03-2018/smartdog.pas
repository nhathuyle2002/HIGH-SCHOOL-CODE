const   ginp='smartdog.inp';
        gout='smartdog.out';

var     gi,go:text;
        n,mkc,ans:longint;
        d:array[0..100001] of boolean;
        f,x,y,c:array[0..100001] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,mkc);
        for i:=1 to n do readln(gi,x[i],y[i],c[i]);
end;

function kc(i,j:longint):longint;
begin
        kc:=abs(x[i]-x[j])+abs(y[i]-y[j]);
end;

function max(a,b:longint):longint;
begin
        if a>b then exit(a) else exit(b);
end;

procedure process;
var     i,j:longint;
begin
        ans:=0;
        fillchar(d,sizeof(d),false);
        d[0]:=true;
        for i:=1 to n do
                begin
                        for j:=0 to i-1 do
                                if (kc(i,j)<=mkc) and (d[j]) then
                                begin
                                        d[i]:=true;
                                        f[i]:=max(f[i],f[j]+c[i]);
                                end;
                        ans:=max(ans,f[i]);
                end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.


