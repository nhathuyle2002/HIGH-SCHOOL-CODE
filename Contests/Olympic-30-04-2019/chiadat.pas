const   ginp='chiadat.inp';
        gout='chiadat.out';

var     gi,go:text;
        n,ans:longint;
        f:array[0..501,0..501] of longint;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do
        begin
                for j:=1 to n do
                begin
                        read(gi,f[i,j]);
                        f[i,j]:=f[i,j]+f[i-1,j]+f[i,j-1]-f[i-1,j-1];
                end;
                readln(gi);
        end;
end;

function min(x,y,z,t:longint):longint;
begin
        min:=x;
        if y<min then min:=y;
        if z<min then min:=z;
        if t<min then min:=t;
end;

function max(x,y,z,t:longint):longint;
begin
        max:=x;
        if y>max then max:=y;
        if z>max then max:=z;
        if t>max then max:=t;
end;

procedure process;
var     i,j,tm1,tm2:longint;
begin
        ans:=maxlongint;
        for i:=1 to n-1 do
                for j:=1 to n-1 do
                begin
                        tm1:=min(f[i,j],f[i,n]-f[i,j],f[n,j]-f[i,j],f[n,n]-f[i,n]-f[n,j]+f[i,j]);
                        tm2:=max(f[i,j],f[i,n]-f[i,j],f[n,j]-f[i,j],f[n,n]-f[i,n]-f[n,j]+f[i,j]);
                        if tm2-tm1<ans then ans:=tm2-tm1;
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
