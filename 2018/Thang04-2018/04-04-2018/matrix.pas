const   ginp='matrix.inp';
        gout='matrix.out';

var     gi,go:text;
        n,m:longint;
        ans:int64;
        a,f,dx,l:array[0..1001,0..1001] of longint;

procedure input;
var     i,j:longint;
        s:ansistring;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n);
        for i:=1 to m do
        begin
                readln(gi,s);
                for j:=1 to n do a[i,j]:=ord(s[j])-48;
        end;
end;

procedure create;
var     i,j,k:longint;
begin
        for i:=1 to m do
                for j:=1 to n do
                begin
                        k:=1;
                        while (a[i-k,j]=a[i+k,j]) and (i-k>0) and (i+k<=m) do inc(k);
                        dx[i,j]:=k-1;
                end;
end;

procedure create2;
var     i,j,k:longint;
begin
        for i:=2 to m do
                for j:=1 to n do
                begin
                        k:=0;
                        while (a[i+k,j]=a[i-k-1,j]) and (i-k-1>0) and (i+k<=m) do inc(k);
                        dx[i,j]:=k;
                end;
end;

procedure process;
var     i,j:longint;
begin
        for i:=1 to m do
                for j:=1 to n do
                begin
                        for k:=j downto 1 do
                end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        create;
        process;
        create2;
        process;
        output;
end.












