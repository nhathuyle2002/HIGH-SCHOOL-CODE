const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e9);

var     n:longint;
        s:array[0..2010] of longint;
        f,g:array[0..2010,0..2010] of longint;

procedure enter;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do
        begin
                read(s[i]);
                s[i]:=s[i-1]+s[i];
                g[i,i]:=i;
        end;
end;

procedure process;
var     i,j,k,kc:longint;
begin
        for kc:=1 to n-1 do
                for i:=1 to n-kc do
                begin
                        j:=i+kc; f[i,j]:=oo;
                        for k:=g[i,j-1] to g[i+1,j] do
                                if f[i,j]>f[i,k]+f[k+1,j]+s[j]-s[i-1] then
                                begin
                                        f[i,j]:=f[i,k]+f[k+1,j]+s[j]-s[i-1];
                                        g[i,j]:=k;
                                end;
                end;
        write(f[1,n]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
