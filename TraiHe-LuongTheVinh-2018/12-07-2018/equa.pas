// ~~ Best ~~ //

const   ginp='equa.inp';
        gout='equa.out';
        maxn=2000010;

var     n,k,m:longint;
        res:int64;
        nt,d:array[0..maxn+1] of longint;

procedure enter;
var     i,xx:longint;
begin
        readln(n,k,m);
        for i:=1 to k do
        begin
                read(xx);
                n:=n-xx+1;
        end;
end;

procedure sangnt;
var     i,j:longint;
begin
        fillchar(nt,sizeof(nt),0);
        for i:=2 to trunc(sqrt(n)) do
                if nt[i]=0 then
                for j:=i to n div i do nt[i*j]:=i;
end;

procedure up(x,tt:longint);
begin
        if nt[x]=0 then
        begin
                inc(d[x],tt);
                exit;
        end;
        inc(d[nt[x]],tt);
        up(x div nt[x],tt);
end;

function lt(a,p:longint):int64;
var     tm:int64;
begin
        if p=0 then exit(1);
        tm:=lt(a,p shr 1);
        lt:=(tm*tm) mod m;
        if p and 1=1 then lt:=(lt*a) mod m;
end;

procedure process;
var     i:longint;
begin
        res:=0;
        if k>n then exit;
        for i:=2 to n-1 do up(i,1);
        for i:=2 to k-1 do up(i,-1);
        for i:=2 to n-k do up(i,-1);
        res:=1;
        for i:=2 to n do
                if d[i]>0 then res:=(res*lt(i,d[i])) mod m;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        sangnt;
        process;
        close(input);close(output);
end.
