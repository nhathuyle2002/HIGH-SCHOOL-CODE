const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,m,t:longint;
        a:array[0..501] of int64;
        f:array[0..501,0..501] of int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m,t);
        for i:=1 to n do readln(gi,a[i]);
end;

function min(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,j,k,h:longint;
begin
        for i:=1 to m do
                for j:=1 to n do
                begin
                        f[i,j]:=f[i,j-1];
                        h:=a[j];
                        for k:=j downto 1 do
                        begin
                                if j-k+1>t then break;
                                h:=min(h,a[k]);
                                f[i,j]:=max(f[i,j],(j-k+1)*h+f[i-1,k-1]);
                        end;
                end;
end;

procedure output;
begin
        write(go,f[m,n]);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
