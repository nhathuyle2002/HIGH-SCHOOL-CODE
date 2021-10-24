const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        m,n,k,n0:longint;
        a,f:array[0..1001000] of longint;
        ou:array[0..1001,0..1001] of longint;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n);
        readln(gi,k);
        for i:=1 to k do read(gi,a[i]);
end;

procedure process;
var     i,j,tm,t:longint;
begin
        tm:=0;
        for i:=1 to k do
        begin
                inc(tm);
                while a[i]>0 do
                begin
                        inc(n0);
                        f[n0]:=tm;
                        dec(a[i]);
                end;
        end;
        tm:=0;t:=0;
        for i:=1 to m do
        begin
                inc(tm);
                for j:=1 to n do
                begin
                        inc(t);
                        if t>n0 then exit;
                        if tm mod 2=1 then ou[i,j]:=f[t] else ou[i,n-j+1]:=f[t];
                end;
        end;
end;

procedure output;
var     i,j:longint;
begin
        for i:=1 to m do
        begin
                for j:=1 to n do write(go,ou[i,j],' ');
                writeln(go);
        end;
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.



