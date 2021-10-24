const   ginp='langthang.inp';
        gout='langthang.out';
        base=round(1e9)+7;

var     n,m,s,t,maxk:longint;
        f:array[0..101,0..101] of int64;
        d:array[0..101,0..101] of longint;

procedure enter;
var     i,u,v:longint;
begin
        readln(n,m,s,t,maxk);
        fillchar(d,sizeof(d),false);
        for i:=1 to m do
        begin
                readln(u,v);
                inc(d[u,v]);
        end;
end;

procedure process;
var     k,u,v:longint;
begin
        f[s,0]:=1;
        for k:=1 to maxk do
                for u:=1 to n do
                        for v:=1 to n do
                                f[u,k]:=(f[u,k]+d[v,u]*f[v,k-1]) mod base;
        write(f[t,maxk]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.

