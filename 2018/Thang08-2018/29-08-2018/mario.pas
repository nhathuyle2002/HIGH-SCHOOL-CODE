const   ginp='mario.inp';
        gout='mario.out';
        oo=1e13;

type    point=record x,y:double;end;

var     n:longint;
        a:array[0..810] of point;
        w:array[0..810,0..810] of double;
        d:array[0..810] of double;

procedure enter;
var     i:longint;
begin
        readln(n);
        readln(a[2].x,a[2].y);
        readln(a[3].x,a[3].y);
        for i:=1 to n do
        begin
                readln(a[4*i].x,a[4*i].y,a[4*i+1].x,a[4*i+1].y);
                a[4*i+2].x:=a[4*i].x;a[4*i+2].y:=a[4*i+1].y;
                a[4*i+3].x:=a[4*i+1].x;a[4*i+3].y:=a[4*i].y;
        end;
end;

function calc(x,y,z:point):double;
begin
        calc:=(x.y+y.y)*(y.x-x.x)+(y.y+z.y)*(z.x-y.x)+(z.y+x.y)*(x.x-z.x);
end;

function distan(x,y:point):double;
begin
        distan:=sqrt(sqr(x.x-y.x)+sqr(x.y-y.y));
end;

procedure init;
var     i,j,t:longint;
        ok:boolean;
begin
        for i:=1 to 4*n+3 do
                for j:=1 to 4*n+3 do w[i,j]:=oo;
        for i:=2 to 4*n+3 do
                for j:=i+1 to 4*n+3 do
                begin
                        ok:=true;
                        for t:=2 to 2*n+1 do
                                if (calc(a[i],a[j],a[t*2])*calc(a[i],a[j],a[t*2+1])<0)
                                and (calc(a[t*2],a[t*2+1],a[i])*calc(a[t*2],a[t*2+1],a[j])<0) then
                                begin
                                        ok:=false;
                                        break;
                                end;
                        if ok then w[i,j]:=distan(a[i],a[j]);
                        w[j,i]:=w[i,j];
                end;
end;

function min(x,y:double):double;
begin
        if x<y then exit(x) else exit(y);
end;

procedure dijkstra;
var     i,u,v:longint;
        put:array[0..810] of boolean;
begin
        for i:=0 to 4*n+3 do d[i]:=oo;
        d[2]:=0;
        fillchar(put,sizeof(put),true);
        repeat
                u:=0;
                for v:=2 to 4*n+3 do
                        if (put[v]) and (d[v]<d[u]) then u:=v;
                if (u=0) or (u=3) then break;
                put[u]:=false;
                for v:=2 to 4*n+3 do
                        d[v]:=min(d[v],d[u]+w[u,v]);
        until false;
        write(d[3]:0:3);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        init;
        dijkstra;
        close(input);close(output);
end.
