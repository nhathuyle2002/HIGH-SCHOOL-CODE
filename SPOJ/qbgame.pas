const   ginp='ss.inp';
        gout='ss.out';
        bit=1 shl 8-1;

var     gi,go:text;
        n,sb:longint;
        b:array[0..bit] of longint;
        re:int64;
        f:array[0..10001,0..bit] of int64;
        a:array[0..10001,1..8] of int64;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

function getbit(k,x:longint):longint;
begin
        getbit:=(x shr (k-1)) and 1;
end;

function cdt(x:longint):boolean;
var     k:longint;
begin
        for k:=1 to 7 do
                if (getbit(k,x)=1) and (getbit(k+1,x)=1) then exit(false);
        exit(true);
end;

procedure input;
var     i,j:longint;
begin
        readln(gi,n);
        re:=-trunc(1e9);
        for j:=1 to 8 do
        begin
                for i:=1 to n do
                begin
                        read(gi,a[i,j]);
                        re:=max(re,a[i,j]);
                end;
                readln(gi);
        end;
end;

procedure process;
var     i,j,k:longint;
        tm:int64;
begin
        sb:=0;
        for i:=0 to bit do
                if cdt(i) then
                begin
                        inc(sb);
                        b[sb]:=i;
                end;
        for i:=1 to n do
                for j:=1 to sb do
                begin
                        tm:=0;
                        for k:=1 to 8 do
                                if getbit(k,b[j])=1 then tm:=tm+a[i,k];
                        f[i,j]:=-trunc(1e13);
                        if i=1 then f[i,j]:=tm else
                        for k:=1 to sb do
                                if (b[j] and b[k]=0) then f[i,j]:=max(f[i,j],f[i-1,k]+tm);
                end;
        re:=0;
        for j:=1 to sb do
                re:=max(re,f[n,j]);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        if re>0 then process;
        write(go,re);
        close(gi);close(go);
end.
