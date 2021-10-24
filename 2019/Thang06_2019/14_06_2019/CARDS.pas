const   fi='CARDS.INP';
        fo='CARDS.OUT';
var     n,m,k:longint;
        a:array[1..100000] of longint;
        dd:array[1..100000] of boolean;
function        kt(mid:longint):boolean;
var     i,d:longint;
begin
        d:=0;
        for i:=1 to mid do
                dd[i]:=false;
        for i:=n downto 1 do
        begin
                if a[i]>mid then continue;
                if dd[a[i]] then continue;
                if a[i]>mid-k-d then
                        begin
                                inc(d);
                                dd[a[i]]:=true;
                        end;
        end;
        if d>=mid then exit(true);
        exit(false);
end;
function        xuli:longint;
var     l,r,mid,kq:longint;
begin
        kq:=0;
        l:=0;
        r:=m;
        while l<=r do
        begin
                mid:=(l+r) div 2;
                if kt(mid) then
                begin
                        kq:=mid;
                        l:=mid+1;
                end
                else    r:=mid-1;
        end;
        exit(kq);
end;
procedure       nhapxuat;
var     f,g:text;
        i,t:longint;
begin
        assign(f,fi); reset(f);
        assign(g,fo); rewrite(g);
        readln(f,t);
        while t>0 do
        begin
                dec(t);
                readln(f,n,m,k);
                for i:=1 to n do
                        read(f,a[i]);
                readln(f);
                writeln(g,xuli);
        end;
        close(f); close(g);
end;
begin
        nhapxuat;
end.
