const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        m,n,maxb,re:longint;
        a,d:array[0..5,0..5] of longint;

procedure input;
var     i,j:longint;
begin
        readln(gi,m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do read(gi,a[i,j]);
                readln(gi);
        end;
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

function getbit(k,x:longint):longint;
begin
        getbit:=(x shr (k-1)) and 1;
end;

procedure process;
var     j,i,k,su,tm:longint;
begin
        re:=0;
        maxb:=1 shl (m*n)-1;
        for k:=0 to maxb do
        begin
                for i:=1 to m*n do
                        if i mod n=0 then d[i div n,n]:=getbit(i,k)
                        else d[i div n+1,i mod n]:=getbit(i,k);
                su:=0;
                for i:=1 to m do
                begin
                        tm:=0;
                        for j:=1 to n do
                                if d[i,j]=0 then tm:=tm*10+a[i,j] else
                                begin
                                        su:=su+tm;
                                        tm:=0;
                                end;
                        su:=su+tm;
                end;
                for j:=1 to n do
                begin
                        tm:=0;
                        for i:=1 to m do
                                if d[i,j]=1 then tm:=tm*10+a[i,j] else
                                begin
                                        su:=su+tm;
                                        tm:=0;
                                end;
                        su:=su+tm;
                end;
                re:=max(re,su);
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        write(go,re);
        close(gi);close(go);
end.
