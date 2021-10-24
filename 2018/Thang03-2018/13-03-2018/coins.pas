const   ginp='coins.inp';
        gout='coins.out';

var     gi,go:text;
        m:longint;
        s:array[1..3] of longint;
        a:array[-10..1000001] of longint;

procedure input;
var     k,l:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,k,l,m);
        s[1]:=1;
        s[2]:=k;
        s[3]:=l;
end;

function check(i:longint):longint;
var     j:longint;
begin
        for j:=1 to 3 do
                if a[i-s[j]]=1 then exit(0);
        exit(1);
end;

procedure danhdau;
var     i:longint;
begin
        fillchar(a,sizeof(a),0);
        a[0]:=1;
        for i:=1 to 1000000 do a[i]:=check(i);
end;


procedure process;
var     i,n:longint;
begin
        for i:=1 to m do
        begin
                read(gi,n);
                if a[n]=0 then write(go,'A') else write(go,'B');
        end;
end;

procedure output;
begin
        close(gi);close(go);
end;

begin
        input;
        danhdau;
        process;
        output;
end.

procedure output;
