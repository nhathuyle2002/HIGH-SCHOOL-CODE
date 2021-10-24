const   ginp='caro.inp';
        gout='caro.out';
        oo=trunc(1e15);

var     n,k,nn:longint;
        res:int64;
        a,s:array[0..4,0..101] of int64;
        g:array[0..4,0..101,0..51] of int64;
        ff:array[0..4,0..51] of int64;
        f:array[0..4,0..201] of int64;

procedure enter;
var     i,j:longint;
begin
        readln(n,k);
        nn:=n div 2+n mod 2;
        for i:=1 to 4 do
        begin
                for j:=1 to n do
                begin
                        read(a[i,j]);
                        s[i,j]:=s[i,j-1]+a[i,j];
                end;
                readln;
        end;
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,j,t,jj,tt:longint;
begin
        for i:=1 to 4 do
                for t:=1 to min(k,nn) do
                begin
                        ff[i,t]:=-oo;
                        g[i,0,t]:=-oo;
                        for j:=1 to n do
                        begin
                                g[i,j,t]:=g[i,j-1,t];
                                if t=1 then
                                for jj:=j-1 downto 0 do
                                        g[i,j,t]:=max(g[i,j,t],s[i,j]-s[i,jj])
                                else
                                for jj:=j-2 downto 0 do
                                        g[i,j,t]:=max(g[i,j,t],g[i,jj,t-1]+s[i,j]-s[i,jj+1]);
                                ff[i,t]:=max(ff[i,t],g[i,j,t]);
                        end;
                end;
        res:=-oo;
        for t:=1 to k do f[0,t]:=-oo;
        for i:=1 to 4 do
                for t:=1 to k do
                begin
                        f[i,t]:=-oo;
                        for tt:=0 to min(t,nn) do
                                f[i,t]:=max(f[i,t],f[i-1,t-tt]+ff[i,tt]);
                end;
        for t:=0 to k do res:=max(res,f[4,t]);
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
