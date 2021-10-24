const   ginp='find.inp';
        gout='find.out';

var     n,m:longint;
        a,v:array[0..100010] of longint;

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
                        tm:=v[i];v[i]:=v[j];v[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure enter;
var     i:longint;
begin
        readln(n,m);
        for i:=1 to n do
        begin
                read(a[i]);
                v[i]:=i;
        end;
        sort(1,n);
end;

procedure process;
var     i,l,r,k,cou,ii:longint;
begin
        for ii:=1 to m do
        begin
                readln(l,r,k);
                cou:=0;
                for i:=1 to n do
                begin
                        if (l<=v[i]) and (v[i]<=r) then inc(cou);
                        if cou=k then break;
                end;
                writeln(a[i]);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
