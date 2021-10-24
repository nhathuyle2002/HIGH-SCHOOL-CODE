const   ginp='bookshelf.inp';
        gout='bookshelf.out';

var     gi,go:text;
        n,l:longint;
        w,h,f:array[0..2001] of int64;
        maxh,sum:array[0..2001,0..2001] of int64;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

function min(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,l);
        for i:=1 to n do readln(gi,h[i],w[i]);
end;

procedure create;
var     i,j,kc:longint;
begin
        for i:=1 to n do
        begin
                maxh[i,i]:=h[i];
                sum[i,i]:=w[i];
        end;
        for kc:=1 to n-1 do
                for i:=1 to n-kc do
                begin
                        j:=i+kc;
                        maxh[i,j]:=max(maxh[i+1,j],maxh[i,j-1]);
                        sum[i,j]:=sum[i,j-1]+w[j];
                end;
end;

procedure process;
var     i,j:longint;
begin
        for i:=1 to n do
        begin
                f[i]:=f[i-1]+h[i];
                for j:=i-1 downto 1 do
                        if sum[j,i]<=l then f[i]:=min(f[i],f[j-1]+maxh[j,i]);
        end;
end;

procedure output;
begin
        write(go,f[n]);
        close(gi);close(go);
end;

begin
        input;
        create;
        process;
        output;
end.

















