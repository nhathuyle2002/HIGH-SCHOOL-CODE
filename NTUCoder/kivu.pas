const   ginp='kivu.inp';
        gout='kivu.out';

var     m,n,res:longint;
        a,b:array[0..100010] of longint;

procedure sort(l,r:longint;var d:array of longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while d[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=d[i];d[i]:=d[j];d[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j,d);sort(i,r,d);
end;

procedure enter;
var     i:longint;
begin
        readln(n,m);
        for i:=1 to n do read(a[i]);readln;
        for i:=1 to m do read(b[i]);
        sort(1,n,a);sort(1,m,b);
end;

procedure process;
var     i,cou,j:longint;
begin
        j:=1;cou:=0;res:=0;
        for i:=1 to n do
        begin
                while (j<=m) and (b[j]<a[i]) do
                begin
                        inc(j);inc(cou);
                end;
                if cou>0 then
                begin
                        inc(res);dec(cou);
                end;
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.