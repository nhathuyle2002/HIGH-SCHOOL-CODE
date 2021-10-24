const   ginp='dhrect.inp';
        gout='dhrect.out';

var     gi,go:text;
        n:longint;
        ans:int64;
        a:array[0..300100] of longint;

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

procedure process;
var     i,dem:longint;
        tm:array[1..2] of longint;
begin
        dem:=0;i:=n;
        while i>=2 do
        begin
                if a[i]=a[i-1] then
                begin
                        inc(dem);
                        tm[dem]:=a[i];
                        if dem=2 then break;
                        dec(i);
                end;
                dec(i);
        end;
        ans:=-1;
        if dem<2 then exit;
        ans:=int64(tm[1])*tm[2];
end;

procedure main;
var     i,t,k:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,k);
        for t:=1 to k do
        begin
                readln(gi,n);
                for i:=1 to n do read(gi,a[i]);
                readln(gi);
                sort(1,n);
                process;
                writeln(go,ans);
        end;
        close(gi);close(go);
end;

begin
        main;
end.