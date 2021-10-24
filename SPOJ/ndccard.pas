const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,m,ans:longint;
        a:array[0..10001] of longint;
        d:array[-10000..30001] of boolean;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,n,m);
        for i:=1 to n do read(gi,a[i]);
end;

procedure process;
var     i,j:longint;
begin
        fillchar(d,sizeof(d),false);
        ans:=0;
        if m>30000 then m:=30000;
        d[a[1]+a[2]]:=true;
        for i:=3 to n do
        begin
                for j:=m downto ans do
                        if d[j-a[i]] then break;
                ans:=j;
                for j:=1 to i-1 do d[a[i]+a[j]]:=true;
        end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
