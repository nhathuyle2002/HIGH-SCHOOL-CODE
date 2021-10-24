const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,cou:longint;
        a,b,c,cs:array[0..5001] of longint;
        f:array[0..5001,0..2501] of int64;
        d:array[0..5001] of boolean;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);readln(gi);
        for i:=1 to n do read(gi,b[i]);
        for i:=1 to n do cs[i]:=i;
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
                while a[i]>t do inc(i);
                while a[j]<t do dec(j);
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

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,j:longint;
begin
        sort(1,n);
        for i:=2 to n do
                for j:=1 to i div 2 do
                        f[i,j]:=max(f[i-1,j],f[i-1,j-1]+b[i]);
        fillchar(d,sizeof(d),false);
        i:=n;j:=n div 2;
        while (i>0) and (j>0) do
        begin
                if f[i,j]=f[i-1,j-1]+b[i] then
                begin
                        d[i]:=true;
                        inc(cou);c[cou]:=i;
                        dec(i);dec(j);
                end
                else dec(i);
        end;
end;

procedure output;
var     i,j:longint;
begin
        writeln(go,f[n,n div 2]);
        for i:=1 to cou do
        begin
                write(go,cs[c[i]],' ');
                for j:=c[i]-1 downto 1 do
                        if d[j]=false then
                        begin
                                d[j]:=true;
                                writeln(go,cs[j]);
                                break;
                        end;
        end;
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
