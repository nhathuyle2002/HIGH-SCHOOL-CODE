const   ginp='climb.inp';
        gout='climb.out';

var     gi,go:text;
        m,n,cou,res:longint;
        a,f:array[0..1000100] of longint;
        d:array[1..4] of longint;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure input;
var     i,j:longint;
begin
        cou:=0;
        readln(gi,m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        inc(cou);read(gi,a[cou]);
                end;
                readln(gi);
        end;
end;

procedure dfs(i:longint);
var     j,k,dd,cc:longint;
begin
        if f[i]>-1 then exit;
        f[i]:=1;
        dd:=1;cc:=4;
        if i mod n=0 then cc:=3;
        if i mod n=1 then dd:=2;
        for j:=dd to cc do
        begin
                k:=i+d[j];
                if (k<1) or (k>cou) then continue;
                if a[i]<a[k] then
                begin
                        dfs(k);
                        f[i]:=max(f[i],f[k]+1);
                end;
        end;
end;

procedure process;
var     i:longint;
begin
        d[1]:=-1;d[2]:=-n;d[3]:=n;d[4]:=1;
        for i:=1 to cou do f[i]:=-1;
        for i:=1 to cou do
                dfs(i);
        res:=0;
        for i:=1 to cou do res:=max(res,f[i]);
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
