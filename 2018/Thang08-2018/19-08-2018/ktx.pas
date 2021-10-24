const   ginp='ktx.inp';
        gout='ktx.out';
        oo=trunc(1e9);

var     n,m,mk:longint;
        a:array[0..101] of longint;
        f,g:array[0..101,0..501] of int64;

procedure enter;
var     i,x:longint;
begin
        readln(n,m,mk);
        for i:=1 to n do
        begin
                readln(x);
                inc(a[x]);
        end;
end;

function get(i:longint):int64;
begin
        get:=int64(i)*(i+1) shr 1;
end;

function ccl(x,k:longint):int64;
var     tm:longint;
begin
        if x=0 then exit(0);
        if k=1 then exit(get(x));
        ccl:=get(x div k)+ccl(x-x div k,k-1);
end;

function min(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i,k,t:longint;
begin
        for i:=1 to m do
                for k:=0 to mk do
                        g[i,k]:=ccl(a[i],k+1);
        f[0,0]:=0;
        for i:=1 to m do
        begin
                f[i,0]:=f[i-1,0]+g[i,0];
                for k:=1 to mk do
                begin
                        f[i,k]:=f[i,k-1];
                        for t:=0 to k do
                                f[i,k]:=min(f[i,k],f[i-1,t]+g[i,k-t]);
                end;
        end;
        write(f[m,k]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
