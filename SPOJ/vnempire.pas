const   ginp='ss.inp';
        gout='ss.out';

type    mang=array[1..3] of int64;
        mang2=record x,y:longint;w:int64;end;

var     gi,go:text;
        n:longint;
        ans:int64;
        pa,cs:array[0..100100] of longint;
        a:array[0..100100] of mang;
        b:array[0..300100] of mang2;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do
        begin
                for j:=1 to 3 do read(gi,a[i,j]);
                cs[i]:=i;
                readln(gi);
        end;
end;

procedure sort(l,r,ns:longint);
var     i,j,tmp:longint;
        t,tm:mang;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i,ns]<t[ns] do inc(i);
                while a[j,ns]>t[ns] do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        tmp:=cs[i];cs[i]:=cs[j];cs[j]:=tmp;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j,ns);sort(i,r,ns);
end;

procedure sort2(l,r:longint);
var     i,j:longint;
        t,tm:mang2;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=b[random(r-l+1)+l];
        repeat
                while b[i].w<t.w do inc(i);
                while b[j].w>t.w do dec(j);
                if i<=j then
                begin
                        tm:=b[i];b[i]:=b[j];b[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort2(l,j);sort2(i,r);
end;

function root(p:longint):longint;
begin
        while p<>pa[p] do p:=pa[p];
        exit(p);
end;

procedure process;
var     ns,i,m,x0,y0,cou:longint;
begin
        m:=0;
        for ns:=1 to 3 do
        begin
                sort(1,n,ns);
                a[n+1]:=a[1];
                for i:=1 to n do
                begin
                        inc(m);
                        b[m].x:=cs[i];
                        b[m].y:=cs[i+1];
                        b[m].w:=abs(a[i,ns]-a[i+1,ns]);
                end;
        end;
        sort2(1,m);
        for i:=1 to n do pa[i]:=i;
        ans:=0;
        cou:=0;
        for i:=1 to m do
        with b[i] do
        begin
                if cou=n-1 then exit;
                x0:=root(x);
                y0:=root(y);
                if x0<>y0 then
                begin
                        pa[y0]:=x0;
                        pa[y]:=x0;
                        inc(cou);
                        ans:=ans+w;
                end;
        end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.



















