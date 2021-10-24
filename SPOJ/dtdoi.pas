const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e9);

var     gi,go:text;
        n,s,gm,res:longint;
        a:array[0..101] of longint;
        f:array[0..10101] of longint;

procedure input;
var     i:longint;
begin
        gm:=0;
        readln(gi,n,s);
        for i:=1 to n do
        begin
                read(gi,a[i]);
                if a[i]>gm then gm:=a[i];
        end;
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i,j:longint;
begin
        res:=(s-10000) div gm;
        s:=s-((s-10000) div gm)*gm;
        for i:=1 to s do f[i]:=oo;
        f[0]:=0;
        for i:=0 to s-1 do
                if f[i]<>oo then
                for j:=1 to n do
                        if i+a[j]<=s then f[i+a[j]]:=min(f[i+a[j]],f[i]+1);
        res:=res+f[s];
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        write(go,res);
        close(gi);close(go);
end.
