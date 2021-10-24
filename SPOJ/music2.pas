const   ginp='music.inp';
        gout='music.out';

var     gi,go:text;
        n,d,m,n2:Longint;
        a,w,trace,cs:array[0..1009] of longint;
        f:array[0..1009,0..100009] of longint;

function max(x,y,z:Longint):longint;
begin
        if x>y then max:=x else max:=y;
        if max<z then max:=z;
end;

procedure input;
var     i:Longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,d);
        for i:=1 to n do
        begin
                read(gi,a[i]);
                if m<a[i] then m:=a[i];
                cs[i]:=i;
        end;
        readln(gi);
        for i:=1 to n do read(gi,w[i]);
end;

procedure swap(var x,y:longint);
var     tam:longint;
begin
        tam:=x;
        x:=y;
        y:=tam;
end;

procedure qs(l,r:longint);
var     i,j,x:longint;
begin
        i:=l;
        j:=r;
        x:=a[random(r-l+1)+l];
        repeat
                while (x>a[i]) do inc(i);
                while (x<a[j]) do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        swap(w[i],w[j]);
                        swap(cs[i],cs[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        if l<j then qs(l,j);
        if i<r then qs(i,r);
end;

procedure process;
var     i,j:Longint;
begin
        for i:=1 to n do
                for j:=d to a[i] do f[i,j]:=max(f[i,j-1],f[i-1,j],f[i-1,j-d]+w[i]);
end;

procedure truyvet;
var     i,j:longint;
begin
        i:=n;j:=m;
        while (i<>0) and (j>=d) do
                if f[i,j]=f[i-1,j-d]+w[i] then
                begin
                        inc(n2);
                        trace[n2]:=cs[i];
                        i:=i-1;
                        j:=j-d;
                end
                else dec(i);
end;

procedure output;
var     i:longint;
begin
        writeln(go,f[n,m]);
        truyvet;
        for i:=n2 downto 1 do write(go,trace[i],' ');
        close(gi);close(go);
end;

begin
        input;
        qs(1,n);
        process;
        output;
end.
