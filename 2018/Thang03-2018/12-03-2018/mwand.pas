const   ginp='mwand.inp';
        gout='mwand.out';

var     gi,go:text;
        n:longint;
        a,b:array[0..100001] of longint;
        cs:array[0..100001] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);
end;

procedure swap(var x,y:longint);
var     tam:longint;
begin
        tam:=a;
        a:=b;
        b:=tam;
end;

procedure sort(l,r:longint);
var     i,j,x:longint;
begin
        i:=l;j:=r;
        x:=

procedure output;
begin
        close(gi);
        close(go);
end;

begin
        input;
        process;
        output;
end.