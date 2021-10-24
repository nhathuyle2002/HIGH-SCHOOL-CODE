const   ginp='seq.inp';
        gout='seq.out';

var     gi,go:text;
        st,n,res:longint;
        a:array[0..17000] of int64;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

function ccl(l,r:longint):longint;
var     i:longint;
begin
        ccl:=0;
        for i:=l to r-1 do
                if a[i]-a[l-1]=a[r]-a[i] then ccl:=max(ccl(l,i)+1,ccl(i+1,r)+1);
end;

procedure main;
var     i,cou:longint;
begin
        readln(gi,n);
        cou:=0;
        for i:=1 to n do
        begin
                read(gi,a[i]);
                if a[i]=0 then inc(cou);
        end;
        if cou=n then
        begin
                res:=n-1;exit;
        end;
        cou:=n;n:=0;
        for i:=1 to cou do
                if a[i]<>0 then
                begin
                        inc(n);
                        a[n]:=a[n-1]+a[i];
                end;
        res:=ccl(1,n);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,st);
        while st>0 do
        begin
                main;
                writeln(go,res);
                dec(st);
        end;
        close(gi);close(go);
end.
