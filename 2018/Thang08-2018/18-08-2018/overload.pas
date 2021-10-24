const   ginp='overload.inp';
        gout='overload.out';

var     n,m,top:longint;
        a,b,r,q:array[0..100010] of longint;

procedure process;
var     i,j:longint;
begin
        readln(n,m);
        for i:=1 to n do read(a[i]);readln;
        for i:=1 to m do read(b[i]);
        top:=0;j:=m;
        for i:=n downto 1 do
        begin
                while (j>0) and (b[j]>=a[i]) do
                begin
                        inc(top);q[top]:=j;
                        dec(j);
                end;
                if top=0 then r[i]:=-1 else
                begin
                        r[i]:=q[top];
                        dec(top);
                end;
        end;
        for i:=1 to n do writeln(r[i]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        process;
        close(input);close(output);
end.
