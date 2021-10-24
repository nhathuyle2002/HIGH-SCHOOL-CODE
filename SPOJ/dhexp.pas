const   ginp='';
        gout='';

var     gi,go:text;
        n,k:longint;
        a:array[0..1000000] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,k);
        for i:=1 to n do read(gi,a[i]);
end;

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

procedure output;
var     i:longint;
        ans:int64;
begin
        ans:=a[1];
        for i:=n downto 2 do
        begin
                dec(k);
                if k<0 then ans:=ans-a[i] else ans:=ans+a[i];
        end;
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        sort(2,n);
        output;
end.
