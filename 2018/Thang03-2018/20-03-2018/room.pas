const   ginp='room.inp';
        gout='room.out';

var     gi,go:text;
        n,m:longint;
        a,f:array[0..101] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to m do readln(gi,a[i]);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,j,tmp:longint;
begin
        for i:=1 to m do
        begin
                for j:=1 to n+1 do
                        if f[j]=0 then break;
                if j<=n then
                while (j<=n) and (a[i]>0) do
                begin
                        tmp:=max(0,a[i]-2);
                        f[j]:=a[i]-tmp;
                        a[i]:=tmp;
                        inc(j);
                end;
                for j:=1 to n do
                begin
                        if a[i]=0 then break;
                        if f[j]<2 then
                        begin
                                inc(f[j]);
                                dec(a[i]);
                        end;
                end;
        end;
end;

procedure output;
var     i:Longint;
begin
        for i:=1 to n do writeln(go,f[i]);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.

