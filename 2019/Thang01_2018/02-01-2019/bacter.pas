const
        fi='bacter.inp';
        fo='bacter.out';

var
        n,m:longint;
        kq:int64;
        a:array of array of int64;


procedure up(x,y,c:longint);
var t:longint;
begin
        t:=y;
        while x<=n do
        begin
                y:=t;
                while y<=n do
                begin
                        a[x,y]:=a[x,y]+c;
                        y:=y+ y and (-y);
                end;
                x:=x + x and (-x);
        end;
end;

function get(x,y:longint):int64;
var t:longint;
        r:int64;
begin
        t:=y; r:=0;
        while x>0 do
        begin
                y:=t;
                while y>0 do
                begin
                        r:=r+a[x,y];
                        y:=y- y and (-y);
                end;
                x:=x - x and (-x);
        end;
        get:=r;
end;

procedure main;
var
        i,x,y,c,u,v:longint;
        s:char;
begin
        readln(N,m);
        setlength(a,n+1);
        for i:=0 to n do setlength(a[i],n+1);
        for i:=1 to m do
        begin
                read(s);
                if s='S' then
                begin
                        readln(x,y,c);
                        up(x,y,c);
                end
                else
                begin
                        readln(x,y,u,v);
                        writeln(Get(u,v)-get(u,y-1)-get(x-1,v)+get(x-1,y-1));
                end;
        end;
end;

procedure enter;
begin
        assign(input,fi);    reset(input);
        assign(output,fo);rewrite(output);

        main;

        close(input);close(output);
end;

begin
enter;
end.

