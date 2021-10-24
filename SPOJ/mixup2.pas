const   ginp='ss.inp';
        gout='ss.out';
        maxbit=65536;

var     gi,go:text;
        n,d,maxb:longint;
        re:int64;
        a:array[0..17] of longint;
        f:array[0..17,0..maxbit+1] of int64;

function getbit(k,x:longint):longint;
begin
        getbit:=(x shr (k-1)) and 1;
end;

function setbit(t,k,x:longint):longint;
begin
        if t=1 then setbit:=x or (1 shl (k-1))
        else setbit:=x and (not (1 shl (k-1)));
end;

procedure input;
var     i:longint;
begin
        readln(gi,n,d);
        maxb:=1;
        for i:=1 to n do
        begin
                readln(gi,a[i]);
                maxb:=maxb*2;
        end;
        dec(maxb);
end;

procedure process;
var     i,tm,k,j:longint;
begin
        for j:=1 to maxb do
                for i:=1 to n do
                        if getbit(i,j)=1 then
                        begin
                                tm:=setbit(0,i,j);
                                if tm=0 then f[i,j]:=1 else
                                for k:=1 to n do
                                        if getbit(k,tm)=1 then
                                        if abs(a[i]-a[k])>d then f[i,j]:=f[i,j]+f[k,tm];
                        end;
        re:=0;
        for i:=1 to n do
                re:=re+f[i,maxb];
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        write(go,re);
        close(gi);close(go);
end.
