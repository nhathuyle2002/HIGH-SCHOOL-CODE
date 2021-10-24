const   ginp='ss.inp';
        gout='ss.out';
        maxb=1 shl 6 -1;

var     gi,go:text;
        n:longint;
        re1,re2:int64;
        z:array[0..101] of longint;
        f,w:array[0..101,0..maxb] of int64;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do readln(gi,z[i]);
end;

function getbit(k,x:longint):longint;
begin
        getbit:=(x shr (k-1)) and 1;
end;

function get3(k,x:longint):longint;
begin
        get3:=(x shr (k-1)) and 7;
end;

function cdt1(x,y:longint):boolean;
begin
        if (getbit(1,x)=1) and (getbit(3,y)=1) then exit(false);
        if (getbit(3,x)=1) and (getbit(1,y)=1) then exit(false);
        exit(true);
end;

function cdt2(x,y:longint):boolean;
begin
        if (getbit(2,x)=1) and ((getbit(1,y)=1) or (getbit(3,y)=1)) then exit(false);
        if (getbit(2,y)=1) and ((getbit(1,x)=1) or (getbit(3,x)=1)) then exit(false);
        exit(true);
end;

function cdt3(i,x:longint):boolean;
begin
        if z[i]=0 then exit(true);
        if getbit(3-z[i]+1,x)=0 then exit(true);
        exit(false);
end;

function check(x,y,i:longint):boolean;
var     t1,t2,t3:longint;
begin
        if get3(4,x)<>get3(1,y) then exit(false);
        t1:=get3(1,x);t2:=get3(4,x);t3:=get3(4,y);
        if (cdt3(i,t1)=false) or (cdt3(i-1,t2)=false) or (cdt3(i-2,t3)=false) then exit(false);
        if (cdt1(t1,t2)=false) or (cdt1(t2,t3)=false) then exit(false);
        if cdt2(t1,t3)=false then exit(false);
        exit(true);
end;

function count(x:longint):longint;
var     i:longint;
begin
        count:=0;
        for i:=1 to 3 do
                if getbit(i,x)=1 then inc(count);
end;

procedure process;
var     i,j,k,tm:longint;
begin
        if (n=1) then
        begin
                if z[1]=0 then re1:=3 else re1:=2;
                re2:=1;exit;
        end;
        for j:=0 to maxb do
                if cdt1(get3(1,j),get3(4,j)) and cdt3(2,get3(1,j)) and cdt3(1,get3(4,j)) then
                begin
                        f[2,j]:=count(get3(1,j))+count(get3(4,j));
                        w[2,j]:=1;
                end else f[2,j]:=-trunc(1e4);
        for i:=3 to n do
                for j:=0 to maxb do
                begin
                        f[i,j]:=-trunc(1e4);
                        for k:=0 to maxb do
                        if check(j,k,i) then
                        begin
                                tm:=count(j);
                                if f[i,j]<f[i-1,k]+tm then
                                begin
                                        f[i,j]:=f[i-1,k]+tm;
                                        w[i,j]:=w[i-1,k];
                                end else
                                if f[i,j]=f[i-1,k]+tm then
                                        w[i,j]:=w[i,j]+w[i-1,k];
                        end;
                end;
        re1:=0;re2:=0;
        for j:=0 to maxb do
                if f[n,j]>re1 then
                begin
                        re1:=f[n,j];
                        re2:=w[n,j];
                end else
                if (f[n,j]=re1) and (re1<>0) then
                        re2:=re2+w[n,j];
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        write(go,re1,' ',re2);
        close(gi);close(go);
end.
