const   ginp='ss.inp';
        gout='ss.out';
        maxn=1 shl 20-1;

var     gi,go:text;
        n,maxb:longint;
        a:array[0..21,0..21] of longint;
        f,w:array[0..maxn] of longint;

procedure input;
var     i,j:longint;
begin
        readln(gi,n);
        for i:=1 to n do
        begin
                for j:=1 to n do read(gi,a[i,j]);
                readln(gi);
        end;
        maxb:=1 shl n-1;
end;

function getbit(k,x:longint):longint;
begin
        getbit:=(x shr (k-1)) and 1;
end;

function setbit(t,k,x:longint):longint;
begin
        if t=1 then setbit:=x or (1 shl (k-1))
        else setbit:=x xor (1 shl (k-1));
end;

procedure process;
var     i,j,t,k,tm:longint;
begin
        for j:=1 to maxb do
        begin
                t:=0;
                for i:=1 to n do
                        if getbit(i,j)=1 then inc(t);
                for i:=1 to n do
                        if getbit(i,j)=1 then
                        begin
                                tm:=setbit(0,i,j);
                                if tm=0 then
                                begin
                                        f[j]:=a[t,i];
                                        w[j]:=1;
                                end else
                                if f[j]<f[tm]+a[t,i] then
                                begin
                                        f[j]:=f[tm]+a[t,i];
                                        w[j]:=w[tm];
                                end
                                else if f[j]=f[tm]+a[t,i] then
                                        w[j]:=w[j]+w[tm];
                        end;
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        write(go,f[maxb],' ',w[maxb]);
        close(gi);close(go);
end.
