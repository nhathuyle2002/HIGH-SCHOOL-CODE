const   ginp='spid.inp';
        gout='spid.out';

type    point=record x,y:int64;end;

var     gi,go:text;
        n,m:longint;
        r:int64;
        a:array[0..1010] of point;
        d:array[0..1010] of boolean;
        b:array[0..1000010] of point;

function kc(x,y:point):double;
begin
        kc:=sqrt(sqr(x.x-y.x)+sqr(x.y-y.y));
end;

procedure input;
var     i:longint;
begin
        readln(gi,n,m,r);
        for i:=1 to n do readln(gi,a[i].x,a[i].y);
        for i:=1 to m do readln(gi,b[i].x,b[i].y);
end;

procedure process;
var     i,j,res:longint;
begin
        fillchar(d,sizeof(d),false);
        for i:=1 to n do
                for j:=1 to m do
                        if kc(a[i],b[j])<=r then d[i]:=true;
        res:=0;
        for i:=1 to n do
                if d[i] then inc(res);
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.

