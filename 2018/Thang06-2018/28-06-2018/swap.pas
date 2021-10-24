const   ginp='swap.inp';
        gout='swap.out';

var     gi,go:text;
        a:array[0..2*100010] of longint;
        n,k,res:longint;

procedure swap(var x,y:longint);
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure main;
var     i,u,v:longint;
begin
        readln(gi,n);
        for i:=1 to n do a[i]:=1;
        for i:=n+1 to 2*n do a[i]:=0;
        res:=n;
        readln(gi,k);
        for i:=1 to k do
        begin
                readln(gi,u,v);
                if u>v then swap(u,v);
                swap(a[u],a[v]);
                if (u<=n) and (v>n) then res:=res+a[u]-a[v];
                writeln(go,res);
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        main;
        close(gi);close(go);
end.