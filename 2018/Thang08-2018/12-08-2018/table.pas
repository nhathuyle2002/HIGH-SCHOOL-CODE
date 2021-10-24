const   ginp='table.inp';
        gout='table.out';

var     n,q,nn:longint;
        a,vi,vj:array[0..10000010] of longint;

procedure enter;
var     i,j:longint;
begin
        readln(n,q);
        nn:=0;
        for i:=1 to n do
        begin
                for j:=1 to n do
                begin
                        inc(nn);read(a[nn]);
                        vi[nn]:=i;vj[nn]:=j;
                end;
                readln;
        end;
end;

procedure swap(var x,y:longint); inline;
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sort(l,r:longint);
var     i,j,t:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        swap(vi[i],vi[j]);
                        swap(vj[i],vj[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure cnp(k:longint);
var     l,r,m:longint;
begin
        l:=1;r:=nn;
        while l<r do
        begin
                m:=(l+r) shr 1;
                if a[m]<k then l:=m+1 else r:=m;
        end;
        writeln(vi[l],' ',vj[l]);
end;

procedure process;
var     i,k:longint;
begin
        sort(1,nn);
        for i:=1 to q do
        begin
                readln(k);
                cnp(k);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
