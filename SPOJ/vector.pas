const   ginp='ss.inp';
        gout='ss.out';
        maxg=4000;

type    vector=record x,y:longint;end;

var     gi,go:text;
        n,m,n1,n2:longint;
        a:array[0..31] of vector;
        b,c:array[0..1000000] of vector;
        dd:array[0..31] of longint;
        f:array[-maxg..maxg,-maxg..maxg] of longint;

procedure try(i:longint);
var     j,sx,sy:longint;
begin
        if i=n+1 then
        begin
                sx:=0;sy:=0;
                for j:=1 to n do
                        if dd[j]=1 then
                        begin
                                sx:=sx+a[j].x;
                                sy:=sy+a[j].y;
                        end;
                inc(n2);c[n2].x:=sx;c[n2].y:=sy;
                exit;
        end;
        for j:=0 to 1 do
        begin
                dd[i]:=j;
                try(i+1);
        end;
end;

procedure create;
var     i:longint;
begin
        readln(gi,m);
        n:=m div 2;
        for i:=1 to n do readln(gi,a[i].x,a[i].y);
        n2:=0;try(1);
        b:=c;n1:=n2;
        n:=m-m div 2;
        for i:=1 to n do readln(gi,a[i].x,a[i].y);
        n2:=0;try(1);
end;

function check(x:longint):boolean;
begin
        if (x>maxg) or (x<-maxg) then exit(false) else exit(true);
end;

procedure process;
var     i,u,v:longint;
        ans:int64;
begin
        readln(gi,u,v);
        if (check(u)=false) or (check(v)=false) then
        begin
                write(go,0);
                exit;
        end;
        ans:=0;
        for i:=1 to n1 do inc(f[b[i].x,b[i].y]);
        for i:=1 to n2 do
                if (check(u-c[i].x)) and (check(v-c[i].y)) then
                ans:=ans+f[u-c[i].x,v-c[i].y];
        write(go,ans);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        create;
        process;
        close(gi);close(go);
end.
