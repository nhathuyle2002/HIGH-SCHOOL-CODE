const   ginp='ss.inp';
        gout='ss.out';
        maxbit=32;

var     gi,go:text;
        m,n,mb:longint;
        f:array[0..31,0..maxbit] of int64;

function getbit(k,x:longint):longint;
begin
        getbit:=(x shr(k-1)) and 3;
end;

procedure inac;
var     i:longint;
begin
        readln(gi,m,n);
        if m<n then
        begin
                i:=m;m:=n;n:=i;
        end;
        mb:=1;
        for i:=1 to n do mb:=mb*2;
        dec(mb);
end;

function check(x,y:longint):boolean;
var     i,tm1,tm2:longint;
begin
        for i:=1 to n-1 do
        begin
                tm1:=getbit(i,x);
                tm2:=getbit(i,y);
                if (tm1=0) and (tm2=0) then exit(false);
                if (tm1=3) and (tm2=3) then exit(false);
        end;
        exit(true);
end;

procedure dp;
var     i,j,k:longint;
begin
        fillchar(f,sizeof(f),0);
        for i:=0 to mb do f[1,i]:=1;
        for i:=2 to m do
                for j:=0 to mb do
                        for k:=0 to mb do
                                if check(j,k) then f[i,j]:=f[i,j]+f[i-1,k];
end;

procedure oup;
var     i:longint;
        ans:int64;
begin
        ans:=0;
        for i:=0 to mb do
                ans:=ans+f[m,i];
        writeln(go,ans);
end;

procedure main;
var     i,st:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,st);
        for i:=1 to st do
        begin
                inac;
                dp;
                oup;
        end;
        close(gi);close(go);
end;

begin
        main;
end.

