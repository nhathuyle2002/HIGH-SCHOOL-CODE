const   fi='DUNGEON.INP';
        fo='DUNGEON.OUT';
        maxm=200000+5;
type    dulieu=record
        u,v:int64;
        z:longint;
        end;
var     m,gh,ct:longint;
        kq,n:int64;
        a:array[0..maxm*2] of dulieu;
        b,giai,f,l,r:array[0..maxm*2] of int64;
procedure       nhap;
var     f:text;
        i:longint;
begin
        assign(f,fi); reset(f);
        readln(f,n);
        readln(f,m);
        for i:=1 to m do
        begin
                readln(f,a[i].v);
                //if a[i].v>n then a[i].v:=2;
        end;
        close(f);
end;
function        timcanh(u:int64):int64;
var     l,r,mid,lop:int64;
        dd,d1,d2,d3,d4:int64;
begin
        l:=0;
        r:=trunc(1e8);
        while l<=r do
        begin
                mid:=(l+r) div 2;
                if sqr(mid*2+1)<u
                then
                begin
                        lop:=mid*2+1+2;
                        l:=mid+1
                end
                else
                        r:=mid-1;
        end;
        d1:=sqr(lop-2)+1;
        d2:=d1+lop-2;
        d3:=d2+lop-1;
        d4:=d3+lop-1;
        dd:=4*(lop-2)-4;
        if u<d2 then exit(u-(dd+1));
        if u<d3 then exit(u-(dd+3));
        if u<d4 then exit(u-(dd+5));
        exit(u-(dd+7));
end;
procedure       sx(l,h:longint);
var     i,j:longint;
        k,tmp:dulieu;
begin
        i:=l;
        j:=h;
        k:=a[random(h-l+1)+l];
        repeat
                while a[i].u<k.u do inc(i);
                while a[j].u>k.u do dec(j);
                if i<=j then
                begin
                        tmp:=a[i];
                        a[i]:=a[j];
                        a[j]:=tmp;
                        inC(i);
                        dec(j);
                end;
        until i>j;
        if i<h then sx(i,h);
        if l<j then sx(l,j);
end;
function        min(a,b:int64):int64;
begin
        if a<b then min:=a else min:=b;
end;
procedure       capnhat(i,cc:longint);
var     j:longint;
        x,y:int64;
begin
        with a[i] do
        begin
                x:=a[i].u;
                if z<=m then
                begin
                        y:=b[a[i].z+m];
                        if cc=1 then
                        begin
                                if (f[x]+1<f[y])  then
                                begin
                                        f[y]:=f[x]+1;
                                        if l[y]<=ct then
                                        for j:=l[y] to r[y] do
                                                capnhat(j,1);
                                end;
                                if (f[x]+giai[x+1]-giai[x]<f[x+1]) then
                                begin
                                        f[x+1]:=f[x]+giai[x+1]-giai[x];
                                        if l[x+1]<=ct then
                                        for j:=l[x+1] to r[x+1] do
                                                capnhat(j,1);
                                end;
                        end
                        else
                        begin
                                f[y]:=min(f[y],f[x]+1);
                                f[x+1]:=min(f[x+1],f[x]+giai[x+1]-giai[x]);
                        end;
                        if (x-1>0) and (f[x-1]>f[x]+giai[x]-giai[x-1]) then
                        begin
                                f[x-1]:=f[x]+giai[x]-giai[x-1];
                                for j:=l[x-1] to r[x-1] do
                                        capnhat(j,1);
                        end;
                end
                else
                begin
                        f[x+1]:=min(f[x+1],f[x]+giai[x+1]-giai[x]);
                        if (x-1>0) and (f[x-1]>f[x]+giai[x]-giai[x-1]) then
                        begin
                                f[x-1]:=f[x]+giai[x]-giai[x-1];
                                for j:=l[x-1] to r[x-1] do
                                        capnhat(j,1);
                        end;
                end;
        end;
end;
procedure       xuli;
var     i,j,x,y:longint;
begin
        inc(m);
        a[m].u:=1;
        a[m].v:=2;
        inc(m);
        a[m].u:=n-1;
        a[m].v:=n;
        for i:=1 to m do
        begin
                if i<=m-2 then
                        a[i].u:=timcanh(a[i].v);
                a[i].z:=i;
                a[i+m].u:=a[i].v;
                a[i+m].z:=i+m;
        end;
        sx(1,m*2);
        j:=0;
        for i:=1 to m*2 do
        begin
                if a[i].u<>a[i-1].u then
                        begin
                                inc(j);
                                l[j]:=i;
                        end;
                r[j]:=i;
                b[i]:=j;
                giai[j]:=a[i].u;
        end;
        gh:=j;
        for i:=1 to m*2 do
                a[i].u:=b[i];
        for i:=1 to m*2 do
                if a[i].z>m then
                b[a[i].z]:=a[i].u;
        f[1]:=0;
        kq:=n*2;
        for i:=2 to gh do f[i]:=n*2;
        for i:=1 to m*2 do
        begin
                ct:=i;
                capnhat(i,0);
        end;
end;
procedure       xuat;
var     g:text;
        i:longint;
begin
        assign(g,fo); rewrite(g);
        for i:=1 to m*2 do
                if giai[a[i].u]=n then
                begin
                        write(g,f[a[i].u]);
                        break;
                end;
        close(g);
end;
begin
        nhap;
        xuli;
        xuat;
end.
