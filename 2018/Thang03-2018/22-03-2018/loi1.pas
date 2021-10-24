const   ginp='onecbl.inp';
        gout='onecbl.out';

var     gi,go:text;
        n,m,dem:longint;
        x,y:array[0..30001] of longint;
        pa:array[0..2001] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to n do readln(gi,x[i],y[i]);
end;

function root(a:longint):longint;
begin
        while a<>pa[a] do a:=pa[a];
        root:=a;
end;

procedure process;
var     i,x0,y0:longint;
begin
        for i:=1 to n do pa[i]:=i;
        dem:=0;
        for i:=1 to m do
        begin
                x0:=root(x[i]);
                y0:=root(y[i]);
                if x0<>y0 then
                begin
                        inc(dem);
                        pa[y0]:=x0;
                        pa[y[i]]:=x0;
                end;
                if dem=n-1 then break;
        end;

procedure output;
var     i,x0,y0:longint;
begin
        if not (dem=n-2) then write(go,'NO')
        else
        begin
                writeln(go,'YES');
                for i:=1 to m do
                begin
                        x0:=root(x[i]);
                        y0:=root(y[i]);
                        if x0<>y0 then










