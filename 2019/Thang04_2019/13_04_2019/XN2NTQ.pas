const   fi='XN2NTQ.INP';
        fo='XN2NTQ.OUT';
        maxn=2000000;
var     n,dem,tmp,kq:longint;
        a:array[1..maxn] of longint;
        vt,f,next,ng1,ng2,a1,a2:array[1..maxn] of longint;
        d,xet,doi,noi:array[0..1000+123] of longint;
        dd:array[0..1000+123] of boolean;

        cs:array[0..1000+123,1..1000+123] of longint;
procedure       nhap;
var     f:text;
        i:longint;
begin
        assign(f,fi); reset(f);
        readln(f,n);
        for i:=1 to n do
        begin
                read(f,a[i]);
                if vt[a[i]]=0 then
                        inc(dem);
                vt[a[i]]:=i;
                if a[i]>tmp then tmp:=a[i];
        end;
        close(f);
end;
procedure       snt;
var     i,j:longint;
begin
        for i:=2 to maxn do
                f[i]:=i;
        for i:=2 to maxn do
        if f[i]=i then
        for j:=i to maxn div i do
                f[i*j]:=i;
        for i:=maxn-1 downto 2 do
        begin
                if f[i]=i then
                        next[i-1]:=i
                else    next[i-1]:=next[i];
        end;
end;
function       DFS(u:longint):boolean;
var     i,j,v:longint;
begin
        xet[u]:=dem;
        for i:=1 to d[u] do
        begin
                v:=cs[u,i];
                if noi[v]=0 then
                begin
                        noi[v]:=u;
                        noi[u]:=v;
                        exit(true);
                end
                else
                if (xet[noi[v]]<>dem) then
                        if DFS(noi[v]) then
                        begin
                                noi[u]:=v;
                                noi[v]:=u;
                                exit(true);
                        end;
        end;
        exit(false);
end;
procedure       xuli;
var     i,j,tr:longint;
begin
        if (dem=n) and (tmp=n) then
        begin
                kq:=n div 2;
                dem:=0;
                while dem<kq do
                begin
                        i:=next[n]-n;
                        j:=n;
                        while i<=j do
                        begin
                                inc(dem);
                                ng1[dem]:=i;
                                ng2[dem]:=j;
                                inc(i);
                                dec(j);
                        end;
                        n:=next[n]-n-1;
                end;
        end
        else
        begin
                kq:=0;
                for i:=1 to n do
                        for j:=1 to n do
                        if (i<>j) then
                        if (a[i]<>1) and (a[j]<>1) then
                        if f[a[i]+a[j]]=a[i]+a[j] then
                        begin
                                if noi[i]=noi[j] then
                                begin
                                        inc(kq);
                                        noi[i]:=j;
                                        noi[j]:=i;
                                end;
                                inc(d[i]);
                                cs[i,d[i]]:=j;
                        end;
                for i:=1 to n do dd[i]:=true;
                for i:=1 to n do
                if noi[i]=0 then
                begin
                        inc(dem);
                        if DFS(i) then inc(kq);
                end;
                tr:=0;
                i:=0;
                d[i]:=0;
                        for j:=1 to n do
                                if (a[j] mod 2=0) and (f[1+a[j]]=1+a[j]) then
                                begin
                                        inc(d[i]);
                                        cs[i,d[i]]:=j;
                                end;
                for i:=1 to n do
                if a[i]=1 then
                begin
                        d[i]:=d[0];
                        for j:=1 to d[i] do
                                cs[i,j]:=cs[0,j];
                        inc(dem);
                        if DFS(i)=false then
                        begin
                                if tr=0 then
                                        tr:=i
                                else
                                begin
                                        noi[i]:=tr;
                                        noi[tr]:=i;
                                        tr:=0;
                                        inc(kq);
                                end;
                        end;
                end;
                kq:=0;
                for i:=1 to n do
                if noi[i]>0 then
                begin
                        vt[i]:=i;
                        vt[noi[i]]:=noi[i];
                        inc(kq);
                        ng1[kq]:=i;
                        ng2[kq]:=noi[i];
                        noi[ng2[kq]]:=-1;
                        noi[ng1[kq]]:=-1;
                end
                else
                if noi[i]=0 then
                begin
                        kq:=kq;
                end;
        end;
end;
procedure      xuat;
var     g:text;
        i:longint;
begin
        assign(g,fo); rewrite(g);
        writeln(g,kq);
        for i:=1 to kq do
                writeln(g,vt[ng1[i]],' ',vt[ng2[i]]);
        close(g);
end;
begin
        nhap;
        snt;
        xuli;
        xuat;
end.
