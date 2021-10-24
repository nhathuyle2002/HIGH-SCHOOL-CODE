const   fi='USAB.INP';
        fo='USAB.OUT';
        oo=trunc(1e9);
type    dl=record
        x,y:longint;
        end;
        mang=array[1..10000000] of longint;
var     n,kq,cs,nn:longint;
        ll,rr:int64;
        g:text;
        a:array[1..200] of dl;
        dem:array[1..2] of longint;
        c:array[1..2] of mang;
        b,s:Array[0..1000] of int64;
procedure       sx1(l,h:longint);
var     i,j:longint;
        k,tmp:dl;
begin
        i:=l;
        j:=h;
        k:=a[random(h-l+1)+l];
        repeat
                while (a[i].x<k.x) do inc(i);
                while (a[j].x>k.x) do dec(j);
                if i<=j then
                begin
                        tmp:=a[i];
                        a[i]:=a[j];
                        a[j]:=tmp;
                        inc(i);
                        dec(j);
                end;
        until i>j;
        if i<h then sx1(i,h);
        if l<j then sx1(l,j);
end;
procedure       sx2(l,h:longint;var     t:mang);
var     i,j:longint;
        k,tmp:longint;
begin
        i:=l;
        j:=h;
        k:=t[random(h-l+1)+l];
        repeat
                while (t[i]<k) do inc(i);
                while (t[j]>k) do dec(j);
                if i<=j then
                begin
                        tmp:=t[i];
                        t[i]:=t[j];
                        t[j]:=tmp;
                        inc(i);
                        dec(j);
                end;
        until i>j;
        if i<h then sx2(i,h,t);
        if l<j then sx2(l,j,t);
end;
procedure       try(i:longint);
var     j,k:longint;
begin
        inc(dem[cs]);
        c[cs,dem[cs]]:=s[i-1];
        for j:=b[i-1]+1 to nn do
        if s[i-1]*a[j].x<=oo then
        begin
                s[i]:=s[i-1];
                b[i]:=j;
                for k:=1 to a[j].y do
                begin
                        s[i]:=s[i]*a[j].x;
                        if s[i]>oo then break
                        else try(i+1);
                end;
        end
        else exit;
end;
function        min(a,b:longint):longint;
begin
        if a<b then min:=a else min:=b;
end;
procedure       xuli;
var     i,j:longint;
begin
        b[0]:=0;
        nn:=min(n div 2,15);
        cs:=1;
        try(1);
        j:=0;
        for i:=nn+1 to n do
        begin
                inc(j);
                a[j]:=a[i];
        end;
        nn:=j;
        cs:=2;
        try(1);
        sx2(1,dem[1],c[1]);
        sx2(1,dem[2],c[2]);
end;
{function        tknp(x:longint):longint;
var     res,l,r,mid:longint;
begin
        res:=0;
        l:=1;
        r:=dem[2];
        while l<=r do
        begin
                mid:=(l+r) div 2;
                if c[2,mid]<=x then
                begin
                        res:=mid;
                        l:=mid+1;
                end
                else    r:=mid-1;
        end;
        exit(res);
end;  }
function        tim(x:int64):longint;
var     res,i,j:longint;
begin
        res:=0;
        j:=dem[2];
        for i:=1 to dem[1] do
        if c[1,i]<=x then
        begin
                while int64(1)*c[1,i]*c[2,j]>x do dec(j);
                res:=res+j;
        end
        else
        break;
        exit(res);
end;
procedure       nhapxuat;
var     f:text;
        i:longint;
begin
        assign(f,fi); reset(F);
        assign(g,fo); rewrite(g);
        readln(F,n);
        for i:=1 to n do
        with a[i] do
                readln(F,x,y);
        sx1(1,n);
        s[0]:=1;
        xuli;
        for i:=1 to 3 do
        begin
                kq:=0;
                readln(f,LL,RR);
                writeln(g,tim(rr)-tim(ll-1));
        end;
        close(f); close(g);
end;
begin
        nhapxuat;
end.
