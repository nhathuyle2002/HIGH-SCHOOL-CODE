const   fi='BACKUP.INP';
        fo='BACKUP.OUT';
        maxn=212345;
type    mangdong=array of longint;
        dl=record
        x,y,z:longint;
        end;
var     n,m,kq,nheap:longint;
        heap:array[0..maxn*3] of dl;
        dd:array[0..maxn+5] of boolean;
        s,l,r,vt,a:array[-5..maxn] of longint;
        f:array[0..100000] of mangdong;
procedure       nhap;
var     f:text;
        i:longint;
begin
        assign(f,fi); reset(f);
        readln(F,n,m);
        for i:=1 to n do
                read(f,a[i]);
        close(f);
end;
procedure       sx(l,h:longint);
var     i,j:longint;
        k,tmp:longint;
begin
        i:=l;
        j:=h;
        k:=a[random(h-l+1)+l];
        repeat
                while a[i]<k do inc(i);
                while a[j]>k do dec(j);
                if i<=j then
                begin
                        tmp:=a[i];
                        a[i]:=a[j];
                        a[j]:=tmp;
                        inc(i);
                        dec(j);
                end;
        until i>j;
        if i<h then sx(i,h);
        if l<j then sx(l,j);
end;
function        min(a,b:longint):longint;
begin
        if a<b then min:=a else min:=b;
end;
procedure       xuli1;
var     i,j:longint;
begin
        setlength(f[0],m+5);
        for i:=0 to m do
                f[0,i]:=trunc(1e9+1000);
        f[0,0]:=0;
        for i:=1  to n do
        begin
                setlength(f[i],m+5);
                for j:=1 to m do
                if j<=i div 2 then
                        f[i,j]:=min(f[i-1,j],f[i-2,j-1]+a[i]-a[i-1])
                else    f[i,j]:=f[i-1,j];
        end;
        kq:=f[n,m];
end;
procedure       tao(i,j:longint);
begin
        if (i<=0) or (j>n) then exit;
        inc(nheap);
        with heap[nheap] do
        begin
                x:=i;
                y:=j;
                z:=s[j]-s[i-1]-(s[j-1]-s[i]);
        end;
end;
function        trai(x:longint):longint;
begin
        while (dd[x]=false) do
        begin
                if x<=0 then break;
                x:=l[x];
        end;
        exit(x);
end;
function        phai(x:longint):longint;
begin
        while (dd[x]=false) do
        begin
                if x>n then break;
                x:=r[x];
        end;
        exit(x);
end;
procedure       doi(i,j:longint);
var     tmp:dl;
begin
        tmp:=heap[i];
        heap[i]:=heap[j];
        heap[j]:=tmp;
end;
function        ss(i,j:longint):boolean;
begin
        if heap[i].z>heap[j].z then exit(true);
        exit(false);
end;
procedure       up(i:longint);
begin
        if (i<=1) then exit;
        if ss(i div 2,i) then
        begin
                doi(i div 2,i);
                up(i div 2);
        end;
end;
procedure       down(i:longint);
var     j:longint;
begin
        j:=i*2;
        if (j>nheap) then exit;
        if (j<nheap) and (ss(j,j+1)) then inc(j);
        if ss(i,j) then
        begin
                doi(i,j);
                down(j);
        end;
end;
procedure       xuli2;
var     i,j,u,v:longint;
        tmp:dl;
begin
        kq:=0;
        a[0]:=a[1];
        for i:=1 to n do
                s[i]:=s[i-2]+a[i]-a[i-1];
        for i:=1 to n do
        begin
                r[i]:=i+1;
                l[i]:=i-1;
                dd[i]:=true;
                tao(i,i+1);
                up(nheap);
                dd[i]:=true;
        end;
        while nheap>0 do
        begin
                tmp:=heap[1];
                doi(1,nheap);
                dec(nheap);
                down(1);
                with tmp do
                if dd[x] and dd[y] then
                begin
                        dd[x]:=false;
                        dd[y]:=false;
                        kq:=kq+z;
                        dec(m);
                        if m=0 then exit;
                        u:=trai(x);
                        v:=phai(y);
                        l[x]:=u;
                        l[y]:=u;
                        r[x]:=v;
                        r[y]:=v;
                        tao(u,v);
                        up(nheap);
                end;
        end;
end;
procedure       xuat;
var     g:text;
        i:longint;
begin
        assign(g,fo); rewrite(g);
       { xuli1;
        writeln(g,kq);
        xuli2;     }
        writeln(g,kq);
        close(g);
end;
procedure       taotest;
var     f,g:text;
        x,i,j,z:longint;
begin
        assign(g,fi); rewrite(g);
        x:=100000;
        n:=x*2;
        m:=x;
        writeln(g,n,' ',m);
        z:=0;
        for i:=1 to n do
        begin
                z:=z+random(5)+1;
                write(g,z,' ');
        end;
        close(g);
end;
begin
      ////  randomize; taotest;
        nhap;
        sx(1,n);
        //if int64(1)*(n)*(m)<=10000000 then xuli1 else
        xuli2;
        xuat;
end.
