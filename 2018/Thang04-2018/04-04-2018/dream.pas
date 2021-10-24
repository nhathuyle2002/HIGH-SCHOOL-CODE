const   ginp='dream.inp';
        gout='dream.out';

var     gi,go:text;
        n,k,ans:longint;
        a,cs:array[0..1000001] of longint;

procedure swap(var x,y:longint);
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,k);
        for i:=1 to n do
        begin
                read(gi,a[i]);
                cs[i]:=i;
        end;
end;

procedure sort(l,r:longint);
var     i,j,ta,tcs:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        ta:=random(r-l+1)+l;
        tcs:=cs[ta];ta:=a[ta];
        repeat
                while (a[i]<ta) or ((a[i]=ta) and (cs[i]<tcs)) do inc(i);
                while (a[j]>ta) or ((a[j]=ta) and (cs[j]>tcs)) do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        swap(cs[i],cs[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure process;
var     i,it:longint;
begin
        a[0]:=-maxlongint;
        for i:=1 to n do
                if a[i]<>a[i-1] then
                begin
                        inc(ans);
                        it:=i;
                end
                else if (cs[i]-cs[it]>=k) then
                begin
                        inc(ans);
                        it:=i;
                end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        sort(1,n);
        process;
        output;
end.





