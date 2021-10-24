const   ginp='grn.inp';
        gout='grn.out';

var     n,res:longint;
        a:array[0..2010] of longint;
        d:array[0..2010] of boolean;

procedure sort(l,r:longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure special;
var     i:longint;
begin
        for i:=2 to n+1 do
                if n mod (i-1)=0 then inc(res);
        write(res);
end;

procedure process;
var     i,l,r,dis:longint;
begin
        for i:=1 to 2*n do read(a[i]);
        sort(1,2*n);
        for i:=2 to n+1 do
        begin
                dis:=a[i]-a[1];
                for l:=1 to 2*n do d[l]:=false;
                d[1]:=true;d[i]:=true;
                d[2*n+1]:=true;
                r:=i+1;
                for l:=2 to 2*n+1 do
                        if not d[l] then
                        begin
                                while (r<=2*n) and (a[r]-a[l]<>dis) do inc(r);
                                if r>2*n then break;
                                d[l]:=true;d[r]:=true;
                        end;
                if l=2*n+1 then inc(res);
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        readln(n);
        res:=0;
        if n>1000 then special else process;
        close(input);close(output);
end.
