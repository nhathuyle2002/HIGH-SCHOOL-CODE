const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e15);

var     gi,go:text;
        m,n,st:longint;
        res:int64;
        c:array[0..1001,0..1001] of longint;
        f,mi:array[0..1001,0..1001] of int64;

function min(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

procedure input;
var     i,j:longint;
begin
        readln(gi,m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do read(gi,c[i,j]);
                readln(gi);
        end;
end;

procedure process;
var     i,j:longint;
begin
        mi[1,0]:=oo;
        for j:=1 to n+1 do
        begin
                f[1,j]:=c[1,j]+c[1,j-1];
                mi[1,j]:=min(mi[1,j-1],f[1,j]);
        end;
        for i:=2 to m do
        begin
                mi[i,0]:=oo;
                for j:=1 to n+1 do
                begin
                        f[i,j]:=min(f[i-1,j]-c[i-1,j]+c[i,j],mi[i-1,j-1]+c[i,j]+c[i,j-1]);
                        mi[i,j]:=min(mi[i,j-1],f[i,j]);
                end;
        end;
        res:=oo;
        for i:=1 to n+1 do res:=min(res,f[m,i]);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        readln(gi,st);
        while st>0 do
        begin
                input;
                process;
                writeln(go,res);
                dec(st);
        end;
        close(gi);close(go);
end.
