const   ginp='storage.inp';
        gout='storage.out';
        maxn=300010;

var     n,k:longint;
        pa:array[0..maxn] of longint;

procedure create;
var     i:longint;
begin
        readln(n,k);
        for i:=1 to k do pa[i]:=i;
end;

function root(p:longint):longint;
begin
        while pa[p]<>p do p:=pa[p];
        root:=p;
end;

procedure union(a,b:longint);
var     paa,pab:longint;
begin
        paa:=root(a);pab:=root(b);
        if paa<>pab then
        begin
                pa[paa]:=pab;
                pa[a]:=pab;
                pa[b]:=pab;
        end else
        begin
                pa[paa]:=0;
                pa[b]:=0;
                pa[a]:=0;
        end;
end;

procedure process;
var     i,a,b,paa,pab:longint;
begin
        for i:=1 to n do
        begin
                readln(a,b);
                paa:=root(a);pab:=root(b);
                if (paa=0) and (pab=0) then write(0) else
                begin
                        write(1);
                        if paa=a then union(a,b) else
                        if pab=b then union(b,a) else
                        if paa>0 then union(a,b) else
                        if pab>0 then union(b,a);
                end;
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        create;
        process;
        close(input);close(output);
end.
