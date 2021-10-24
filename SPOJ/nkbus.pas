const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        a:array[0..200001] of longint;

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
var     i,tm,nn,st,k,j,t,n,m:longint;
begin
        readln(gi,n,m);
        st:=0;k:=0;
        for i:=1 to n do
        begin
                read(gi,tm,nn);
                for j:=1 to nn do
                begin
                        read(gi,t);
                        if t-st<=0 then t:=0 else t:=t-st;
                        inc(k);a[k]:=t;
                end;
                st:=st+tm;
                readln(gi);
        end;
        sort(1,k);
        if k<m then write(go,st+a[k]) else write(go,st+a[m]);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        process;
        close(gi);close(go);
end.
