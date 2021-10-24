const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n:longint;
        a,b:array[0..200001] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do
        begin
                read(gi,a[i]);b[i]:=1;
        end;
        readln(gi);
        for i:=n+1 to 2*n do
        begin
                read(gi,a[i]);b[i]:=2;
        end;
end;

procedure swap(var x,y:longint);
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
                        swap(b[i],b[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure output;
var     i,ans:longint;
        choose:array[0..200001] of boolean;
begin
        ans:=0;
        fillchar(choose,sizeof(choose),true);
        for i:=2 to 2*n do
                if (b[i]<>b[i-1]) and (choose[i-1]) then
                begin
                        choose[i]:=false;
                        inc(ans);
                end;
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        sort(1,2*n);
        output;
end.
