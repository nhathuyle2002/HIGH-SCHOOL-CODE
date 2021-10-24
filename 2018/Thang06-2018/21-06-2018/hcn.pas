const   ginp='hcn.inp';
        gout='hcn.out';
        oo=trunc(1e6);

var     gi,go:text;
        m,n:longint;
        f:array[0..101,0..101] of longint;

procedure swap(var x,y:longint);
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure dequy(x,y:longint);
var     i:longint;
begin
        if f[x,y]<>-1 then exit;
        f[x,y]:=oo;
        if x=y then f[x,y]:=1;
        for i:=1 to x-1 do
        begin
                dequy(i,y);dequy(x-i,y);
                f[x,y]:=min(f[x,y],f[i,y]+f[x-i,y]);
        end;
        for i:=1 to y-1 do
        begin
                dequy(x,i);dequy(x,y-i);
                f[x,y]:=min(f[x,y],f[x,i]+f[x,y-i]);
        end;
        f[y,x]:=f[x,y];
end;

procedure main;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        for i:=1 to 100 do
                for j:=1 to 100 do f[i,j]:=-1;
        dequy(100,100);
        while not eof(gi) do
        begin
                readln(gi,m,n);
                if (m=0) or (n=0) then break;
                writeln(go,f[m,n]);
        end;
        close(gi);close(go);
end;

begin
        main;
end.
