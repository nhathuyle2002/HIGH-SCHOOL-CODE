const   ginp='ss.inp';
        gout='ss.out';
        maxbit=65536;
        vc=trunc(1e6);

var     gi,go:text;
        n,maxch:longint;
        c:array[1..16,1..16] of longint;
        f:array[1..16,0..maxbit] of longint;

function getbit(k,x:longint):longint;
begin
        getbit:=(x shr (k-1)) and 1;
end;

procedure setbit(t,k:longint;var x:longint);
begin
        if t=1 then x:=x or (1 shl(k-1))
        else x:=x and (not(1 shl(k-1)));
end;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do
        begin
                for j:=1 to n do read(gi,c[i,j]);
                readln(gi);
        end;
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i,j,tm,k:longint;
begin
        maxch:=1;
        for i:=1 to n do maxch:=maxch*2;
        for j:=1 to maxch-1 do
                for i:=1 to n do
                begin
                        f[i,j]:=vc;
                        if getbit(i,j)=1 then
                        begin
                                tm:=j;
                                setbit(0,i,tm);
                                if tm=0 then f[i,j]:=0 else
                                for k:=1 to 16 do
                                        if getbit(k,tm)=1 then f[i,j]:=min(f[i,j],f[k,tm]+c[k,i]);
                        end;
                end;
end;

procedure output;
var     i,ans:longint;
begin
        ans:=vc;
        for i:=1 to n do
                ans:=min(ans,f[i,maxch-1]);
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
