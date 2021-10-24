const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e6);

var     gi,go:text;
        n,res,st:longint;
        f:array[0..31,0..31,0..31] of longint;
        g:array[0..31,0..31] of longint;

procedure input;
var     i,j,k:longint;
begin
        readln(gi,n);
        for k:=1 to n do
                for i:=1 to n do
                begin
                        for j:=1 to n do
                        begin
                                read(gi,g[i,j]);
                                g[i,j]:=g[i,j]+g[i-1,j]+g[i,j-1]-g[i-1,j-1];
                                f[i,j,k]:=g[i,j]+f[i,j,k-1];
                        end;
                        readln(gi);
                end;
end;

procedure process;
var     i,j,k,t,tm:longint;
begin
        res:=-oo;
        for t:=1 to n do
                for i:=t to n do
                for j:=t to n do
                for k:=t to n do
                begin
                        tm:=f[i,j,k]-f[i,j,k-t]-f[i-t,j,k]+f[i-t,j,k-t]-f[i,j-t,k]+f[i,j-t,k-t]+f[i-t,j-t,k]-f[i-t,j-t,k-t];
                        if tm>res then res:=tm;
                end;
        writeln(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,st);
        while st>0 do
        begin
                input;
                process;
                dec(st);
        end;
        close(gi);close(go);
end.
