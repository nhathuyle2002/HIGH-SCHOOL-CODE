const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,sst,res:longint;
        a:array[0..50001] of longint;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);
        readln(gi);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

function ucln(x,y:longint):longint;
begin
        if y=0 then exit(x);
        ucln:=ucln(y,x mod y);
end;

function check(x:longint):longint;
var     i,uc:longint;
        d:array[0..50001] of boolean;
begin
        if x<res then exit(0);
        fillchar(d,sizeof(d),true);
        for i:=1 to n do
                if a[i] mod x=0 then d[i]:=false;
        for i:=1 to n+1 do
                if d[i] then break;
        if i=n+1 then exit(x);
        uc:=a[i];
        for i:=1 to n do
                if uc<res then exit(0) else
                if (d[i]) and (uc<a[i]) then uc:=ucln(a[i],uc)
                else if (d[i]) then uc:=ucln(uc,a[i]);
        check:=min(uc,x);
end;

procedure process;
var     i,gm,x,tm:longint;
        ok:boolean;
begin
        gm:=a[1];
        res:=0;
        for i:=2 to n do gm:=min(gm,a[i]);
        for x:=1 to trunc(sqrt(gm)) do
                if gm mod x=0 then
                begin
                        tm:=check(gm div x);
                        res:=max(res,tm);
                        tm:=check(x);
                        res:=max(res,tm);
                end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,sst);
        while sst>0 do
        begin
                input;
                process;
                writeln(go,res);
                dec(sst);
        end;
        close(gi);close(go);
end.
