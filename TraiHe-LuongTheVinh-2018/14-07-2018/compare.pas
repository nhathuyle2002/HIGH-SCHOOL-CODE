const   ginp='compare.inp';
        gout='compare.out';

var     n:longint;
        a:ansistring;
        b,v:array[0..100010] of longint;

procedure sort(l,r:longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=b[random(r-l+1)+l];
        repeat
                while b[i]<t do inc(i);
                while b[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=b[i];b[i]:=b[j];b[j]:=tm;
                        tm:=v[i];v[i]:=v[j];v[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure main;
var     i,d,c:longint;
begin
        readln(n);
        read(a);
        d:=-1;c:=1;
        b[1]:=0;v[1]:=1;
        for i:=2 to n do
        begin
                if a[i-1]='<' then
                begin
                        b[i]:=c;
                        inc(c);
                end else
                begin
                        b[i]:=d;
                        dec(d);
                end;
                v[i]:=i;
        end;
        sort(1,n);
        for i:=1 to n do b[v[i]]:=i;
        for i:=1 to n do write(b[i],' ');
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.
