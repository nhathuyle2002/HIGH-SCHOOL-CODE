const   ginp='letters.inp';
        gout='letters.out';

var     gi,go:text;
        n,m,k:longint;
        dem:int64;
        a:array[0..1000,0..1000] of char;
        f:array[0..1000,0..1000] of longint;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m,k);
        for i:=1 to n do
        begin
                for j:=1 to m do read(gi,a[i,j]);
                readln(gi);
        end;
end;

procedure process;
var     i,j,h,c,tmp:longint;
begin
        dem:=0;
        for i:=1 to n do
                for j:=1 to m do
                begin
                        f[i,j]:=f[i-1,j]+f[i,j-1]-f[i-1,j-1];
                        if a[i,j]='a' then inc(f[i,j]);
                end;
        for i:=1 to n do
                for j:=1 to m do
                        for h:=i-1 downto 1 do
                                for c:=j-1 downto 1 do
                                begin
                                        tmp:=f[i,j]-f[h-1,j]-f[i,c-1]+f[h-1,c-1];
                                        if tmp>k then break;
                                        if (a[i,j]=a[h,j]) and (a[i,j]=a[i,c]) and (a[i,j]=a[h,c]) then inc(dem);
                                end;
end;

procedure output;
begin
        write(go,dem);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
