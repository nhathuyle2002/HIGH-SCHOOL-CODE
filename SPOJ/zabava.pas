const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,m,k:longint;
        f,g:array[0..101,0..501] of int64;
        d:array[0..101] of int64;

procedure input;
var     i,x:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m,k);
        for i:=1 to n do
        begin
                readln(gi,x);
                inc(d[x]);
        end;
end;

function ccl(x:int64;i:longint):int64;
var     tm1,tm2:int64;
begin
        tm1:=x div (i+1);
        tm2:=x mod (i+1);
        if tm2=0 then ccl:=(i+1)*tm1*(tm1+1) div 2
        else ccl:=tm1*(tm1+1) div 2+ccl(x-tm1,i-1);
end;

function min(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i,j,t:longint;
begin
        for i:=1 to m do
                for j:=0 to k do
                        g[i,j]:=ccl(d[i],j);
        for i:=1 to m do
                for j:=0 to k do
                begin
                        f[i,j]:=f[i-1,j]+g[i,0];
                        for t:=1 to j do
                                f[i,j]:=min(f[i,j],f[i-1,j-t]+g[i,t]);
                end;
end;

procedure output;
begin
        write(go,f[m,k]);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
