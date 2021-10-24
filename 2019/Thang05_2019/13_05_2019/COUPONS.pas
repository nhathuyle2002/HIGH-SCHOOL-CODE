const   fi='COUPONS.INP';
        fo='COUPONS.OUT';
        maxc=trunc(1e16);
        maxn=300000;
        //316
type    dulieu=record
        x,y,z,gt:int64;
        end;
var     n,k,kq:longint;
        nheap:array[1..3] of longint;
        m:int64;
        heap:array[1..3,1..maxn] of longint;
        a:array[1..maxn,1..3] of longint;
        dd:array[1..maxn] of boolean;
procedure       nhap;
var     f:text;
        i:longint;
begin
        assign(f,fi); reset(f);
        readln(f,n,k,m);
        for i:=1 to n do
        begin
                readln(F,a[i,1],a[i,2]);
                a[i,3]:=a[i,1]-a[i,2];
        end;
        close(f);
end;
procedure       doi(x,i,j:longint);
var     tmp:longint;
begin
        tmp:=heap[x,i];
        heap[x,i]:=heap[x,j];
        heap[x,j]:=tmp;
end;
function        ss(x,i,j:longint):boolean;
begin
        if a[heap[x,i],x]>a[heap[x,j],x] then exit(true)
        else exit(false);
end;
procedure       up(x,i:longint);
begin
        if i<=1 then exit;
        if ss(x,i div 2,i) then
        begin
                doi(x,i div 2,i);
                up(x,i div 2);
        end;
end;
procedure       down(x,i:longint);
var     j:longint;
begin
        j:=i*2;
        if j>nheap[x] then exit;
        if (j<nheap[x]) and ss(x,j,j+1) then inc(j);
        if ss(x,i,j) then
        begin
                doi(x,i,j);
                down(x,j);
        end;
end;
procedure       them(x:longint; i:longint);
begin
        inc(nheap[x]);
        heap[x,nheap[x]]:=i;
        up(x,nheap[x]);
end;
procedure       bo(x:longint);
begin
        doi(x,1,nheap[x]);
        dec(nheap[x]);
        down(x,1);
end;
procedure       xuli;
var     i,j,cs:longint;
        s:int64;
        tmp:dulieu;
begin
        for i:=1 to n do
        begin
                them(1,i);
                them(2,i);
        end;
        nheap[3]:=0;
        fillchar(dd,sizeof(dd),false);
        for i:=1 to k do
        if nheap[2]>0 then
        begin
                cs:=heap[2,1];
                dec(m,a[cs,2]);
                if m<0 then break;
                dd[cs]:=true;
                them(3,cs);
                bo(2);
        end;
        repeat
                while (nheap[1]>0) and (dd[heap[1,1]]) do
                        bo(1);
                while (nheap[2]>0) and (dd[heap[2,1]]) do
                        bo(2);
                if nheap[2]<=0 then break;
                if (nheap[3]>0)
                and (a[heap[3,1],3] + a[heap[2,1],2] < a[heap[1,1],1]) then
                begin
                        dec(m,a[heap[3,1],3] + a[heap[2,1],2]);
                        if m<0 then break;
                        cs:=heap[2,1];
                        dd[cs]:=true;
                        bo(3);
                        them(3,cs);
                end
                else
                begin
                        cs:=heap[1,1];
                        dec(m,a[cs,1]);
                        if m<0 then break;
                        dd[cs]:=true;
                end;
        until false;
end;
procedure       xuat;
var     g:Text;
        i,kq:longint;
begin
        assign(g,fo); rewrite(g);
        kq:=0;
        for i:=1 to n do
                if dd[i] then inc(kq);
        write(g,kq);
        close(g);
end;
begin
        nhap;
        xuli;
        xuat;
end.
