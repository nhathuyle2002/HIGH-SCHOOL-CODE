const   ginp='sococake.inp';
        gout='sococake.out';

var     gi,go:text;
        n,ans:longint;
        f:array[0..300,0..300] of longint;

procedure input;
var     i,j:longint;
        x:char;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do
        begin
                for j:=1 to n do
                begin
                        read(gi,x);
                        f[i,j]:=f[i-1,j]+f[i,j-1]-f[i-1,j-1];
                        if x='#' then inc(f[i,j]);
                end;
                readln(gi);
        end;
end;

function min(x,y,z,t:longint):longint;
begin
        min:=x;
        if min>y then min:=y;
        if min>z then min:=z;
        if min>t then min:=t;
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,j,tmp:longint;
begin
        ans:=0;
        for i:=1 to n-1 do
                for j:=1 to n-1 do
                begin
                        tmp:=min(f[i,j],f[i,n]-f[i,j],f[n,j]-f[i,j],f[n,n]-f[i,n]-f[n,j]+f[i,j]);
                        ans:=max(ans,tmp);
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






