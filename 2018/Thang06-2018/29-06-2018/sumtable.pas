const   ginp='sumtable.inp';
        gout='sumtable.out';

var     n:longint;
        f:array[0..1010,0..1010] of int64;

procedure update(x,y:longint;w:int64);
var     j:longint;
begin
        while x<=n do
        begin
                j:=y;
                while j<=n do
                begin
                        inc(f[x,j],w);
                        j:=j+j and (-j);
                end;
                x:=x+x and (-x);
        end;
end;

function quece(x,y:longint):int64;
var     j:longint;
begin
        quece:=0;
        while x>=1 do
        begin
                j:=y;
                while j>=1 do
                begin
                        inc(quece,f[x,j]);
                        j:=j-j and (-j);
                end;
                x:=x-x and (-x);
        end;
end;

procedure enter;
var     i,j:longint;
        x:int64;
begin
        readln(n);
        for i:=1 to n do
        begin
                for j:=1 to n do
                begin
                        read(x);
                        update(i,j,x);
                end;
        end;
end;

procedure process;
var     i,q,x,y,u,v,typ,w:longint;
begin
        readln(q);
        for i:=1 to q do
        begin
                read(typ);
                if typ=1 then
                begin
                        readln(x,y,w);
                        update(x,y,w);
                end;
                if typ=2 then
                begin
                        readln(x,y,u,v);
                        writeln(quece(u,v)-quece(u,y-1)-quece(x-1,v)+quece(x-1,y-1));
                end;
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
