const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        m,n,res:longint;
        a,b,c:ansistring;
        z:array[0..200010] of longint;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure input;
begin
        readln(gi,c);
        read(gi,b);
        a:=b+'*'+c;n:=length(a);
end;

procedure process;
var     i,l,r:longint;
begin
        res:=0;
        l:=1;r:=1;
        for i:=2 to n do
        begin
                if i<=r then z[i]:=min(r-i+1,z[i-l+1]);
                while (i+z[i]<=n) and (a[1+z[i]]=a[i+z[i]]) do inc(z[i]);
                if r<i+z[i]-1 then
                begin
                        l:=i;r:=i+z[i]-1;
                end;
                if r=n then
                begin
                        res:=z[i];exit;
                end;
        end;
end;

procedure output;
var     i:longint;
begin
        write(go,c);
        for i:=res+1 to length(b) do write(go,b[i]);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        output;
        close(gi);close(go);
end.
