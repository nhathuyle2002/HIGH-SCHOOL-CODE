const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n:longint;
        a,b,cs:array[0..10001] of longint;
        ans:int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);
        readln(gi);
        for i:=1 to n do read(gi,b[i]);
        for i:=1 to n do cs[i]:=i;
end;

procedure swap(var x,y:longint);
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sort(l,r:longint);
var     i,j,tm:longint;
        t:real;
begin
        if l>=r then exit;
        i:=l;j:=r;
        tm:=random(r-l+1)+l;
        t:=a[tm]/b[tm];
        repeat
                while (a[i]/b[i])<t do inc(i);
                while (a[j]/b[j])>t do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        swap(b[i],b[j]);
                        swap(cs[i],cs[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure process;
var     i,t:longint;
begin
        t:=0;
        for i:=n downto 1 do
        begin
                t:=t+b[i];
                ans:=ans+a[i]*t;
        end;
end;

procedure output;
var     i:longint;
begin
        writeln(go,ans);
        for i:=n downto 1 do write(go,cs[i],' ');
        close(gi);close(go);
end;

begin
        input;
        sort(1,n);
        process;
        output;
end.
