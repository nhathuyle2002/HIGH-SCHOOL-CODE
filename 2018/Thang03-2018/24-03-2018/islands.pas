const   ginp='islands.inp';
        gout='islands.out';

var     gi,go:text;
        n,ans:longint;
        a,b:array[0..2000001] of longint;

procedure input;
var     i,tmp1:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do readln(gi,a[i]);
        i:=0;
        repeat
                inc(i);
                tmp1:=a[i-1];
                while a[i]=a[i+1] do inc(i);
                if (a[i]<tmp1) and (a[i]<a[i+1]) then b[i]:=1
                else if (a[i]>tmp1) and (a[i]>a[i+1]) then b[i]:=-1
                else b[i]:=0;
        until i>=n;
end;

procedure swap(var x,y:longint);
var     tmp:longint;
begin
        tmp:=x;
        x:=y;
        y:=tmp;
end;

procedure sort(l,r:longint);
var     i,j,tmp:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        tmp:=a[random(r-l+1)+l];
        repeat
                while a[i]<tmp do inc(i);
                while a[j]>tmp do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        swap(b[i],b[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure process;
var     i,dem:longint;
begin
        dem:=1;ans:=0;
        i:=0;
        repeat
                inc(i);
                dem:=dem+b[i];
                while a[i]=a[i+1] do
                begin
                        inc(i);
                        dem:=dem+b[i];
                end;
                if ans<dem then ans:=dem;
        until i>=n;
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

