const   fi='GUARDS.INP';
        fo='GUARDS.OUT';
type    xy=record
        x,y,vt:longint;
        end;
var     n,k,l,r,nheap1,nheap2:longint;
        heap1,heap2:array[1..200000] of xy;
        dd:array[1..200000] of boolean;
        a:array[1..200000] of xy;
procedure       nhap;
var     f:text;
        i:longint;
begin
        assign(f,fi); reset(f);
        readln(f,n,k,l,r);
        for i:=1 to n do
                begin
                        readln(f,a[i].x,a[i].y);
                        a[i].vt:=i;
                end;
        close(f);
end;
procedure       sx(l,h:longint);
var     i,j:longint;
        k,tmp:xy;
begin
        i:=l;
        j:=h;
        k:=a[(l+h) div 2];
        repeat
                while (a[i].x<k.x) or (a[i].x=k.x) and (a[i].y>k.y) do inc(i);
                while (a[j].x>k.x) or (a[j].x=k.x) and (a[j].y<k.y) do dec(j);
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
procedure       doi1(i,j:longint);
var     tmp:xy;
begin
        tmp:=heap1[i];
        heap1[i]:=heap1[j];
        heap1[j]:=tmp;
end;
procedure       up1(i:longint);
begin
        if i=1 then exit;
        if heap1[i div 2].y>heap1[i].y then
        begin
                doi1(i,i div 2);
                up1(i div 2);
        end;
end;
procedure       down1(i:longint);
var     j:longint;
begin
        j:=i*2;
        if j>nheap1 then exit;
        if (j<nheap1) and (heap1[j].y>heap1[j+1].y) then inc(j);
        if heap1[i].y>heap1[j].y then
        begin
                doi1(i,j);
                down1(j);
        end;
end;
procedure       doi2(i,j:longint);
var     tmp:xy;
begin
        tmp:=heap2[i];
        heap2[i]:=heap2[j];
        heap2[j]:=tmp;
end;
procedure       up2(i:longint);
begin
        if i<=1 then exit;
        if heap2[i div 2].y<heap2[i].y then
        begin
                doi2(i,i div 2);
                up2(i div 2);
        end;
end;
procedure       down2(i:longint);
var     j:longint;
begin
        j:=i*2;
        if j>nheap2 then exit;
        if (j<nheap2) and (heap2[j].y<heap2[j+1].y) then inc(j);
        if heap2[i].y<heap2[j].y then
        begin
                doi2(i,j);
                down2(j);
        end;
end;
procedure       xuli;
var     i,j:longint;
begin
        for i:=1 to k do
                heap1[i].y:=l-1;
        nheap1:=k;
        nheap2:=0;
        for i:=1 to n do
                dd[i]:=true;
        for i:=1 to n do
                if (a[i].x<=l) and (a[i].y>=l) then
                begin
                        inc(nheap2);
                        heap2[nheap2]:=a[i];
                        up2(nheap2);
                end;
        for j:=1 to n do
                if a[j].x>l then
                begin
                        i:=j;
                        break;
                end;
        repeat
                while (i<=n) and (a[i].x<=heap1[1].y+1) do
                begin
                        inc(nheap2);
                        heap2[nheap2]:=a[i];
                        up2(nheap2);
                        inc(i);
                end;
                if (nheap2=0) or (heap2[1].y<=heap1[1].y)  then
                        begin
                                r:=-1;
                                exit;
                        end;
                dd[heap2[1].vt]:=false;
                heap1[1]:=heap2[1];
                down1(1);
                doi2(1,nheap2);
                dec(nheap2);
                if nheap2>2 then
                down2(1);
        until (heap1[1].y>=r) ;
end;
procedure       xuat;
var     g:text;
        i,dem:longint;
begin
        assign(g,fo); rewrite(g);
        if r=-1 then
                begin
                        write(g,r);
                        close(g);
                        HALT;
                end;
        dem:=0;
        for i:=1 to n do if dd[i]=false then inc(dem);
        writeln(g,dem);
        for i:=1 to n do if dd[i]=false then write(g,i,' ');
        close(g);
end;
procedure       taotest;
var     i,j:longint;
        g:text;
begin
        assign(g,fi); rewrite(g);
        randomize;
        n:=100000; k:=100; l:=1; r:=1000;
        writeln(g,n,' ',k,' ',l,' ',r);
        for i:=1 to n do
                begin
                        j:=random(r);
                        writeln(g,j,' ',j+random(r));
                end;
        close(g);
end;
begin
     //   taotest;
        nhap;
        sx(1,n);
        xuli;
        xuat;
end.
