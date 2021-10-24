const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,m:longint;
        a:array[0..10001] of longint;
        f0,f1:array[0..10001,0..501] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to n do readln(gi,a[i]);
end;

function max(x,y,z:longint):longint;
begin
        max:=x;
        if y>max then max:=y;
        if z>max then max:=z;
end;

procedure process;
var     i,j,tm:longint;
begin
        for i:=1 to n do
        begin
                f1[i,0]:=max(f1[i-1,0],f0[i-1,1],f1[i-1,1]);
                if i<m then tm:=i else tm:=m;
                for j:=1 to tm do
                begin
                        f1[i,j]:=f1[i-1,j-1]+a[i];
                        f0[i,j]:=max(0,f0[i-1,j+1],f1[i-1,j+1]);
                end;
        end;
end;

procedure output;
begin
        write(go,f1[n,0]);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
