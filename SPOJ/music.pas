const   ginp='music.inp';
        gout='music.out';

var     gi,go:text;
        n,d,m:Longint;
        a,w:array[0..1009] of longint;
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
        begin
                for j:=1 to d-1 do f[i,j]:=max(0,f[i,j-1],f[i-1,j]);
                for j:=d to a[i] do f[i,j]:=max(f[i,j-1],f[i-1,j],f[i-1,j-d]+w[i]);
                for j:=a[i]+1 to m do f[i,j]:=max(0,f[i-1,j],f[i,j-1]);
        end;
end;

procedure output;
begin
        write(go,f[n,m]);
        close(gi);close(go);
end;

begin
        input;
        qs(1,n);
        process;
        output;
end.
