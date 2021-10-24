const   ginp='ss.inp';
        gout='ss.out';
        maxn=1501;
        oo=1001;
        xx=10000;

type    point=record x,y:longint; end;

var     res:int64;
        n,nb,nc:longint;
        a:array[0..maxn] of point;
        b,c:array[0..maxn*maxn] of extended;
        d:array[0..maxn*maxn] of longint;
        mp:array[0..maxn*maxn] of point;

procedure sorta(l,r:longint);
var     i,j:longint;
        t,tmp:point;
begin
        if l>=r then exit;
        t:=a[random(r-l+1)+l];
        i:=l; j:=r;
        repeat
                while (a[i].x<t.x) or ((a[i].x=t.x) and (a[i].y<t.y)) do inc(i);
                while (a[j].x>t.x) or ((a[j].x=t.x) and (a[j].y>t.y)) do dec(j);
                if i<=j then
                begin
                        tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sorta(l,j); sorta(i,r);
end;

function chia(x,y:longint):extended;
begin
        if x=0 then chia:=oo
        else if y=0 then chia:=oo+1
        else    chia:=x/y;
end;

function ndao(x:extended):extended;
begin
        if x=oo then ndao:=oo+1 else
        if x=oo+1 then ndao:=oo else
        ndao:=-1/x;
end;

function cmp(p,q:point; x,y:extended):boolean;
begin
        if p.x<>q.x then exit(p.x<q.x);
        if p.y<>q.y then exit(p.y<q.y);
        exit(trunc(x*xx)<trunc(y*xx));
end;

procedure sort(l,r:longint);
var     i,j:longint;
        t,tmp:point;
        tt,ttmp:extended;
begin
        if l>=r then exit;
        i:=random(r-l+1)+l;
        t:=mp[i]; tt:=b[i];
        i:=l; j:=r;
        repeat
                while cmp(mp[i],t,b[i],tt) do inc(i);
                while cmp(t,mp[j],tt,b[j]) do dec(j);
                if i<=j then
                begin
                        tmp:=mp[i]; mp[i]:=mp[j]; mp[j]:=tmp;
                        ttmp:=b[i]; b[i]:=b[j]; b[j]:=ttmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
end;

function binary(x:extended):longint;
var     l,r,mid:longint;
begin
        if nc=0 then exit(0);
        l:=1; r:=nc;
        while l<r do
        begin
                mid:=(l+r) shr 1;
                if trunc(c[mid]*xx)<trunc(x*xx) then l:=mid+1 else r:=mid;
        end;
        if trunc(c[l]*xx)=trunc(x*xx) then exit(d[l]) else exit(0);
end;

procedure enter;
var     i,j,cou:longint;
begin
        readln(n);
        nb:=0;
        for i:=1 to n do readln(a[i].x,a[i].y);
        sorta(1,n); cou:=0;
        for i:=1 to n do
                if (a[i].x<>a[i-1].x) or (a[i].y<>a[i-1].y) then
                begin
                for j:=1 to cou do
                        begin
                                inc(nb);
                                mp[nb].x:=a[i].x+a[j].x; mp[nb].y:=a[i].y+a[j].y;
                                b[nb]:=chia(a[i].x-a[j].x,a[i].y-a[j].y);
                        end;
                inc(cou); a[cou]:=a[i];
                end;
end;

procedure process;
var     i:longint;
begin
        sort(1,nb);
        res:=0; nc:=0;
        for i:=1 to nb do
        begin
                res:=res+binary(ndao(b[i]));
                if trunc(b[i]*xx)=trunc(c[nc]*xx) then inc(d[nc]) else
                begin
                        inc(nc);
                        c[nc]:=b[i]; d[nc]:=1;
                end;
                if (mp[i].x<>mp[i+1].x) or (mp[i].y<>mp[i+1].y) then nc:=0;
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.

