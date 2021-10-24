const   ginp='qd.inp';
        gout='qd.out';

var     n,nn,cou:longint;
        res:int64;
        a:array[0..300010] of longint;
        b,d:array[0..9000010] of longint;

procedure sort(l,r:longint; var dd:array of longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=dd[random(r-l+1)+l];
        repeat
                while dd[i]<t do inc(i);
                while dd[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=dd[i];dd[i]:=dd[j];dd[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j,dd);sort(i,r,dd);
end;

procedure enter;
var     i,n0:longint;
begin
        readln(n);
        for i:=1 to n do read(a[i]);
        sort(1,n,a);
        n0:=n;n:=0;
        for i:=1 to n0 do
                if a[i]<>a[n] then
                begin
                        inc(n);
                        a[n]:=a[i];
                end;
end;

function cnp(x:longint):longint;
var     l,r,mid:longint;
begin
        if (b[1]>x) or (b[cou]<x) then exit(0);
        l:=1;r:=cou;
        while l<r do
        begin
                mid:=(l+r) shr 1;
                if b[mid]<x then l:=mid+1 else r:=mid;
        end;
        if b[l]<>x then exit(0) else exit(d[l]);
end;

procedure process;
var     i,j:longint;
begin
        res:=0;
        if n>3000 then
        begin
                for i:=1 to n do res:=res+(i-1) div 2*2;
                exit;
        end;
        nn:=0;cou:=0;
        for i:=1 to n do
                for j:=i-1 downto 1 do
                        begin
                                inc(nn);
                                b[nn]:=a[i]+a[j];
                        end;
        sort(1,nn,b);
        for i:=1 to nn do
                if b[i]=b[cou] then inc(d[cou]) else
                begin
                        inc(cou);b[cou]:=b[i];
                        d[cou]:=1;
                end;
        for i:=1 to n do
                res:=res+cnp(a[i])*2;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        write(res);
        close(input);close(output);
end.
