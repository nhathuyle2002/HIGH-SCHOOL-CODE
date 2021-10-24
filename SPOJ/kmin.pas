const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        m,n,k,nh:longint;
        a,b,hi,hj:array[0..50010] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n,k);
        for i:=1 to m do read(gi,a[i]);readln(gi);
        for i:=1 to n do read(gi,b[i]);
end;

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

procedure swap(var i,j:longint);
var     tm:longint;
begin
        tm:=hi[i];hi[i]:=hi[j];hi[j]:=tm;
        tm:=hj[i];hj[i]:=hj[j];hj[j]:=tm;
end;

function sum(i:longint):longint;
begin
        sum:=a[hi[i]]+b[hj[i]];
end;

procedure downh(i:longint);
var     j:longint;
begin
        j:=i*2;
        if j>nh then exit;
        if (j<nh) and (sum(j)>sum(j+1)) then inc(j);
        if sum(j)<sum(i) then
        begin
                swap(i,j);
                downh(j);
        end;
end;

procedure output;
var     i:longint;
begin
        sort(1,m,a);sort(1,n,b);
        nh:=0;
        for i:=1 to n do
        begin
                inc(nh);
                hi[nh]:=1;hj[nh]:=i;
        end;
        for i:=1 to k do
        begin
                writeln(go,sum(1));
                hi[1]:=hi[1]+1;downh(1);
        end;
        close(gi);close(go);
end;

begin
        input;
        output;
end.
