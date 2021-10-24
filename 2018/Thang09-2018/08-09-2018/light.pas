const   ginp='light.inp';
        gout='light.out';
        maxn=2010;
        oo=trunc(1e14);

type    save=record l,r,w:longint; end;

var     n,t:longint;
        res:int64;
        a:array[0..maxn] of save;
        f:array[0..maxn,0..maxn] of int64;
        q:array[0..4*maxn] of int64;
        leaf:array[0..maxn] of longint;

function min(x,y:int64):int64; inline;
begin
        if x<y then exit(x) else exit(y);
end;

procedure sort(l,r:longint);
var     i,j,t:longint;
        tmp:save;
begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l].r;
        repeat
                while a[i].r<t do inc(i);
                while a[j].r>t do dec(j);
                if i<=j then
                begin
                        tmp:=a[i];a[i]:=a[j];a[j]:=tmp;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
end;

procedure build(id,l,r:longint);
var     m:longint;
begin
        if l=r then leaf[l]:=id else
        begin
                m:=(l+r) shr 1;
                build(id*2,l,m);
                build(id*2+1,m+1,r);
        end;
end;

procedure update(i:longint; x:int64);
begin
        i:=leaf[i];
        q[i]:=x;
        while i>1 do
        begin
                i:=i shr 1;
                q[i]:=min(q[i*2],q[i*2+1]);
        end;
end;

function quece(i,j:longint):int64;
function try(id,l,r:longint):int64;
var     m:longint;
begin
        if (j<l) or (i>r) then exit(oo);
        if (i<=l) and (r<=j) then exit(q[id]);
        m:=(l+r) shr 1;
        try:=min(try(id*2,l,m),try(id*2+1,m+1,r));
end;
begin
        if i<=j then quece:=try(1,0,n) else quece:=oo;
end;

function bina_se(x:longint):longint;
var     l,r,m:longint;
begin
        l:=0; r:=n;
        while l<r do
        begin
                m:=(l+r) shr 1;
                if a[m].r<x then l:=m+1 else r:=m;
        end;
        bina_se:=l;
end;

procedure enter;
var     i:longint;
begin
        readln(n,t);
        for i:=1 to n do
        with a[i] do
        begin
                readln(r,l,w);
                r:=r+l; l:=r-2*l;
                if r>t then r:=t;
                if l<0 then l:=0;
        end;
        sort(1,n);
        with a[0] do
        begin
                l:=0; r:=0; w:=0;
        end;
        build(1,0,n);
end;

procedure process;
var     i,j,k:longint;
begin
        res:=oo;
        for i:=0 to n-1 do
        begin
                for k:=1 to 4*n do q[k]:=oo;
                if i=0 then update(0,0);
                for j:=0 to i-1 do
                        if f[j,i]<oo then update(j,f[j,i]);
                for j:=i+1 to n do
                begin
                        k:=bina_se(a[j].l);
                        f[i,j]:=quece(k,j-1)+a[j].w;
                        if (a[i].r=t) and (a[j].r=t) then res:=min(res,f[i,j]);
                        if f[i,j]<oo then update(j,f[i,j]);
                end;
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
