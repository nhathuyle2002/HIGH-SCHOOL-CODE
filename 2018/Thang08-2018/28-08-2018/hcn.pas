const   ginp='hcn.inp';
        gout='hcn.out';
        oo=trunc(1e6);

var     m,n:longint;
        f:array[0..101,0..101] of longint;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure try(x,y:longint);
var     i,j:longint;
begin
        if f[x,y]>0 then exit;
        if x=y then f[x,y]:=1 else f[x,y]:=oo;
        for i:=1 to x-1 do
        begin
                try(i,y);try(x-i,y);
                f[x,y]:=min(f[x,y],f[i,y]+f[x-i,y]);
        end;
        for j:=1 to y-1 do
        begin
                try(x,j);try(x,y-j);
                f[x,y]:=min(f[x,y],f[x,j]+f[x,y-j]);
        end;
        f[y,x]:=f[x,y];
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        while not seekeof do
        begin
                readln(m,n);
                try(m,n);
                writeln(f[m,n]);
        end;
        close(input);close(output);
end.
