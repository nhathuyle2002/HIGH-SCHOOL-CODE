// ~~ Best ~~ //

const   ginp='ps2.inp';
        gout='ps2.out';

var     n:longint;
        m,x,y,u,v:int64;
        d:array[0..1010] of int64;

function md(a,b:int64):int64;
begin
        if a=0 then exit(0);
        md:=md(a shr 1,2*b mod m);
        if a and 1=1 then md:=(md+b) mod m;
end;

procedure try(i:longint);
var     tx,ty,tu,tv:int64;
begin
        if i>n then exit;
        tx:=x;ty:=y;
        tu:=u;tv:=v;
        if i and 1=1 then
        begin
                u:=(md(u,d[i])+x) mod m;
                v:=(md(v,d[i])+y) mod m;
                x:=(u-tu+m) mod m;
                y:=(v-tv+m) mod m;
        end else
        begin
                x:=(md(x,d[i])+u) mod m;
                y:=(md(y,d[i])+v) mod m;
                u:=(x-tx+m) mod m;
                v:=(y-ty+m) mod m;
        end;
        try(i+1);
end;

procedure main;
var     i:longint;
begin
        readln(n,m);
        for i:=1 to n do read(d[i]);
        x:=1;y:=1;u:=1;v:=0;
        try(1);
        if n and 1=0 then write(x,' ',y) else write(u,' ',v);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.
