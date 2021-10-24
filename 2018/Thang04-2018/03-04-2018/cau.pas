const   ginp='bridges.inp';
        gout='bridges.out';

var     gi,go:text;
        n,m,ans:longint;
        x,y:array[0..5000100] of longint;
        pa:array[0..1000100] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to m do readln(gi,x[i],y[i]);
end;

function root(a:longint):longint;
begin
        while a<>pa[a] do a:=pa[a];
        exit(a);
end;

procedure process;
var     i,x0,y0,dem:longint;
begin
        if n=1 then exit;
        for i:=1 to n do pa[i]:=i;
        dem:=0;
        for i:=1 to m do
        begin
                x0:=root(x[i]);
                y0:=root(y[i]);
                if x0<>y0 then
                begin
                        pa[y0]:=x0;
                        pa[y[i]]:=x0;
                        inc(dem);
                end;
                if dem=n-1 then
                begin
                        ans:=i;
                        exit;
                end;
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
