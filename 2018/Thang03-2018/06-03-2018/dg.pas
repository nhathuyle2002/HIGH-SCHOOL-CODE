const   ginp='dg.inp';
        gout='dg.out';

type    point=record
                x,y:real;
                d,dd:boolean;
                end;

var     gi,go:text;
        n,m,nn,t:longint;
        a,b,c:array[0..10000000] of point;
        h:array[0..10000000] of longint;
        goc:array[0..10000000] of real;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,t);
end;

procedure create;
var     i:longint;
begin
        nn:=0;
        readln(gi,n);
        for i:=1 to n do
        begin
                readln(gi,a[i].x,a[i].y);
                inc(nn);
                c[nn]:=a[i];
                c[nn].d:=true;
                c[nn].dd:=false;
        end;
        readln(gi,m);
        for i:=1 to m do
        begin
                readln(gi,b[i].x,b[i].y);
                inc(nn);
                c[nn]:=b[i];
                c[nn].d:=false;
                c[nn].dd:=false;
        end;
end;

procedure swap(var u,v:point);
var     tam:point;
begin
        tam:=u;
        u:=v;
        v:=tam;
end;

function ccl(p1,p2,p3:point):longint;
var     x1,x2,y1,y2,tmp:real;
begin
        x1:=p2.x-p1.x;
        y1:=p2.y-p1.y;
        x2:=p3.x-p2.x;
        y2:=p3.y-p2.y;
        tmp:=x1*y2-x2*y1;
        if tmp=0 then exit(0);
        if tmp>0 then exit(1);
        exit(-1);
end;

function lower(p1,p2:point):boolean;
var     gt:longint;
begin
        gt:=ccl(c[1],p1,p2);
        if gt>0 then exit(true);
        if (gt=0) and ((p1.x<p2.x) or ((p1.x=p2.x) and (p1.y<p2.y))) then exit(true);
        exit(false);
end;

procedure sort(l,r:Longint);
var     i,j:Longint;
        tmp:point;
        tam:boolean;
begin
        i:=l;j:=r;
        tmp:=c[random(r-l+1)+l];
        repeat
                while lower(c[i],tmp) do inc(i);
                while lower(tmp,c[j]) do dec(j);
                if i<=j then
                begin
                        swap(c[i],c[j]);
                        inc(i);
                        dec(j);
                end;
        until i>j;
        if l<j then sort(l,j);
        if i<r then sort(i,r);
end;

procedure convexhull;
var     i,dem,vt:longint;
begin
        vt:=1;
        for i:=2 to nn do
                if (c[i].y<c[vt].y) or ((c[i].y=c[vt].y) and (c[i].x<c[vt].x)) then vt:=i;
        swap(c[1],c[vt]);
        if nn>2 then sort(2,nn);
        c[1].dd:=true;c[2].dd:=true;
        h[1]:=1;h[2]:=2;
        dem:=2;
        for i:=3 to nn do
        begin
                while (dem>1) and (ccl(c[h[dem-1]],c[h[dem]],c[i])=-1) do
                begin
                        c[h[dem]].dd:=false;
                        dec(dem);
                end;
                inc(dem);
                h[dem]:=i;
                c[i].dd:=true;
        end;
end;

function ktxuat:boolean;
var     i:longint;
begin
        for i:=1 to nn do
        begin
                if (c[i].d=true) and (c[i].dd=false) then exit(false);
                if (c[i].d=false) and (c[i].dd=true) then exit(false);
        end;
        exit(true);
end;

procedure process;
var     i:longint;
        ok:boolean;
begin
        for i:=1 to t do
        begin
                create;
                convexhull;
                ok:=ktxuat;
                if ok then writeln(go,'YES') else writeln(go,'NO');
        end;

end;

procedure output;
begin
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.