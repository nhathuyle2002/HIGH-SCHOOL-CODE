const   ginp='ss.inp';
        gout='ss.out';
        maxn=15010;
        maxg=80010;
        mmg=30000;

type    point= record x,y:longint; end;

var     n,s,w,res:longint;
        a:array[0..maxn] of point;
        f,g:array[0..maxg*4] of longint;

procedure sort(l,r:longint);
var     i,j:longint;
        t,tmp:point;
begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i].y<t.y do inc(i);
                while a[j].y>t.y do dec(j);
                if i<=j then
                begin
                        tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
end;

function max(x,y:longint):longint;
begin
        if x>y then max:=x else max:=y;
end;

procedure update(id,l,r,d,c,k:longint);
var     mid:longint;
begin
        if (d>r) or (c<l) then exit;
        if (d<=l) and (r<=c) then
        begin
                f[id]:=f[id]+k; g[id]:=g[id]+k;
                exit;
        end;
        mid:=(l+r) div 2;
        update(id*2,l,mid,d,c,k);
        update(id*2+1,mid+1,r,d,c,k);
        f[id]:=max(f[id*2],f[id*2+1])+g[id];
end;

procedure enter;
var     i:longint;
begin
        readln(s,w); readln(n);
        for i:=1 to n do
        begin
                readln(a[i].x,a[i].y);
                a[i].x:=a[i].x+mmg;
        end;
end;

procedure process;
var     l,r:longint;
begin
        sort(1,n);
        res:=0; l:=1;
        for r:=1 to n do
        begin
                while a[l].y+w<a[r].y do
                begin
                        update(1,0,maxg,a[l].x,a[l].x+s,-1);
                        inc(l);
                end;
                update(1,0,maxg,a[r].x,a[r].x+s,1);
                res:=max(res,f[1]);
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
